import yaml
from urllib.request import urlretrieve
from pathlib import Path

URL = "https://raw.githubusercontent.com/github/linguist/master/lib/linguist/languages.yml"

filename, _ = urlretrieve(URL)
langs = yaml.full_load(Path(filename).read_text())
langs = "\n".join(
    f"""  "{k.lower()}": rgb("{v["color"]}"),"""
    for k, v in langs.items()
    if v["type"] == "programming" and "color" in v
)
Path(__file__.replace(".py", ".typ")).write_text(
f"""// This list is generated from {URL}
#let github-pl-colors = (
{langs}
)
"""
)
