### You need to run one server instance + one client instance for the "chain" to be complete, see instructions below:

Run server locally:
- go to folder /fullstack_demo/server
- run: `pip install -r requirements.txt`
- if successful - run `py api.py` (or whatever runs python `python3` etc) and check info in terminal for `URL` + `PORT`
**note:** dont forget to make adjustments in `.env` file for local db conf

Run client locally:
- open a new terminal, `ctrl+shift+ö` on win (in VSCode)
- go to folder /fullstack_demo/client
- run: `npm i`
- if successful - run `npm run dev`

Run super easy client locally:
- download https://marketplace.visualstudio.com/items?itemName=ritwickdey.LiveServer
- restart VSCode (probably)
- right-click `index.html` -> Open With Live Server
- go to browser