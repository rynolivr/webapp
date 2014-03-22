install:
	npm install
run:
	PORT=80 NODE_ENV=production forever start -c coffee server/app.coffee
