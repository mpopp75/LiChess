import json
import os

from dotenv import load_dotenv

from Database import Database
from Game import Game
from Lichess import Lichess

load_dotenv()

player = os.getenv("PLAYER")

if player is None:
    print("No player set")
    exit()

database = Database()

lichess = Lichess(player)
games = lichess.get_games("rapid")

for g in games:
    g = Game(player, g)
    g.debug()
    database.insertGame(g)
    database.commit()

    print("-" * 30)

performance_statistics = json.dumps(lichess.get_performance_statistics("rapid"), indent=2)

with open("performance_statistics.json", mode="w") as file:
    print(performance_statistics)
    file.write(performance_statistics)

rating_history = json.dumps(lichess.get_rating_history(), indent=2)

with open("rating_history.json", mode="w") as file:
    print(rating_history)
    file.write(rating_history)
