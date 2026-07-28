import json

import requests


class Lichess:

    def __init__(self, player):
        self.player = player

    def get_games(self, game_type: str = "rapid"):
        url = f"https://lichess.org/api/games/user/{self.player}"

        headers = {
            "Accept": "application/x-ndjson",
            "User-Agent": "MyChessApp/1.0 (contact: office@mpopp.net)",
        }

        params = {
            "rated": "true",
            "perfType": game_type,
            "sort": "dateAsc"
        }

        response = requests.get(url, headers=headers, params=params)
        response.raise_for_status()

        games = []

        for line in response.iter_lines(decode_unicode=True):
            if line:
                games.append(json.loads(line))

        return games

    def get_performance_statistics(self, game_type: str = "rapid"):
        url = f"https://lichess.org/api/user/{self.player}/perf/{game_type}"

        response = requests.get(url)
        response.raise_for_status()

        return response.json()

    def get_rating_history(self):
        url = f"https://lichess.org/api/user/{self.player}/rating-history"

        response = requests.get(url)
        response.raise_for_status()

        rh = response.json()
        rating_history = []

        for item in rh:
            if not item['points']:
                continue

            type = item['name']
            print("=" * 30)

            for p in item['points']:
                dict = {
                    "type": type,
                    "date": f"{p[0]:04}-{(p[1] + 1):02}-{p[2]:02}",
                    "rating": p[3]
                }
                rating_history.append(dict)

        return rating_history
