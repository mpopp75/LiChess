import math
from datetime import datetime


class Game:

    def __init__(self, player: str, game: dict):
        self.id = game['id']
        self.created_at = str(datetime.fromtimestamp((game['createdAt'] / 1000)))[0:19]
        self.last_move_at = str(datetime.fromtimestamp((game['lastMoveAt'] / 1000)))[0:19]
        self.player = player

        if game['players']['white']['user']['id'] == player:
            self.player_color = "w"
            p_color = "white"
            o_color = "black"
        else:
            self.player_color = "b"
            p_color = "black"
            o_color = "white"

        self.player_rating = int(game['players'][p_color]['rating'])
        self.player_rating_diff = int(game['players'][p_color]['ratingDiff'])
        self.opponent = game['players'][o_color]['user']['id']
        self.opponent_name = game['players'][o_color]['user']['name']
        self.opponent_rating = game['players'][o_color]['rating']
        self.opponent_rating_diff = game['players'][o_color]['ratingDiff']

        if "winner" in game and game['winner'] == p_color:
            self.result = 1.0
        elif "winner" in game and game['winner'] == o_color:
            self.result = 0.0
        else:
            self.result = 0.5

        self.perf = game['perf']
        self.status = game['status']
        self.moves = game['moves']
        self.number_moves = math.ceil(len(game['moves'].split()) / 2)
        self.rated = game['rated']
        self.variant = game['variant']

    def debug(self):
        print(f"{self.id=}")
        print(f"{self.created_at=}")
        print(f"{self.last_move_at=}")
        print(f"{self.player=}")
        print(f"{self.player_color=}")
        print(f"{self.player_rating=}")
        print(f"{self.player_rating_diff=}")
        print(f"{self.opponent=}")
        print(f"{self.opponent_name=}")
        print(f"{self.opponent_rating=}")
        print(f"{self.opponent_rating_diff=}")
        print(f"{self.result=}")
        print(f"{self.perf=}")
        print(f"{self.status=}")
        print(f"{self.moves=}")
        print(f"{self.number_moves=}")
        print(f"{self.rated=}")
        print(f"{self.variant=}")
