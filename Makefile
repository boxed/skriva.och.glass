build:
	elm make src/Skriva.elm --output=skriva.js

live:
	elm-live src/Skriva.elm --no-server -- --output=skriva.js --optimize

live-debug:
	elm-live src/Skriva.elm --no-server -- --output=skriva.js --debug
