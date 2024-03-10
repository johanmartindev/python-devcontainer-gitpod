import json
import textwrap
import urllib.request

API_URL = "https://en.wikipedia.org/api/rest_v1/page/random/summary"


def main():
    with urllib.request.urlopen(API_URL) as response:
        data = json.load(response)

    print(data["title"])
    print()
    print(textwrap.fill(data["extract"]))


if __name__ == "__main__":
    main()
