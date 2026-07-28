import os

import mysql.connector
from dotenv import load_dotenv


class Database:

    def __init__(self):
        load_dotenv()
        self.cnx = mysql.connector.connect(
            host=os.getenv("MYSQL_SERVER") if not None else "127.0.0.1",
            port=os.getenv("MYSQL_PORT") if not None else 3306,
            user=os.getenv("MYSQL_USER") if not None else "",
            password=os.getenv("MYSQL_PASSWORD") if not None else "",
            database=os.getenv("MYSQL_DATABASE") if not None else "lichess")

    def insertGame(self, values):
        cursor = self.cnx.cursor()

        sql = """
               INSERT IGNORE INTO games 
               (id, created_at, last_move_at, player, player_color, player_rating, player_rating_diff, 
               opponent, opponent_name, opponent_rating, opponent_rating_diff, result, perf, status, 
               moves, number_moves, rated, variant) 
               VALUES 
               (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s) 
               """

        val = (
            values.id,
            values.created_at,
            values.last_move_at,
            values.player,
            values.player_color,
            values.player_rating,
            values.player_rating_diff,
            values.opponent,
            values.opponent_name,
            values.opponent_rating,
            values.opponent_rating_diff,
            values.result,
            values.perf,
            values.status,
            values.moves,
            values.number_moves,
            values.rated,
            values.variant
        )

        cursor.execute(sql, val)

    def commit(self):
        self.cnx.commit()
