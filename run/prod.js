#!/usr/bin/env node

const babel = require('babel-core');
const fs = require('fs');
const path = require('path');
const riot = require('riot');
const util = require('./util');
const UglifyJS = require("uglify-js");

prod();

/** prod runs the compiler for the production build */
function prod() {
	const tagsDir = path.resolve(__dirname, '..', 'src');
	const outputFile = path.resolve(__dirname, '..', 'dist/app.js');

	compile(tagsDir, outputFile).catch(err => {
		console.log('Something went wrong!', err.toString(), '\n', err.stack);
	});
}

/**
 * compile finds all Riot tags, compiles each one into ES2015+ JS, transforms that into ES5 JS,
 * concatenates the whole thing and runs a minifier. This function returns a Promise that is
 * resolved when the full compilation is finished.
 */
function compile(tagsDir, outputFile) {
	console.log('compiling prod build...');
	console.time('compilation time');

	const files = fs.readdirSync(tagsDir);

	const fileTransforms = files.map(f => {
		return util.readFile(path.resolve(tagsDir, f))
			.then(tag => {
				const preBabelJS = riot.compile(tag);
				const transformResult = babel.transform(preBabelJS, { presets: ['es2015-riot'] });
				return transformResult.code;
			});
	});

	return Promise.all(fileTransforms)
		.then(js => {
			const concatJS = js.join('\n');
			const miniCode = UglifyJS.minify(concatJS, { fromString: true }).code;
			return util.writeFile(outputFile, miniCode);
		})
		.then(() => {
			console.timeEnd('compilation time');
			console.log('done.');
		});
}

