all: node_modules
	purs compile src/*.purs '../../src/**/*.purs' '../../bower_components/purescript-*/src/**/*.purs'
	purs bundle --module MultiAsync output/*/*.js > output/bundle.js
	echo 'module.exports = PS.MultiAsync;' >> output/bundle.js
	node_modules/.bin/browserify output/bundle.js index.js -o html/index.js

node_modules:
	npm install
