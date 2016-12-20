#!/usr/bin/env node

const babel = require('babel-core');
const chokidar = require('chokidar');
const fs = require('fs');
const path = require('path');
const riot = require('riot');
const util = require('./util');

dev();

/** dev runs the compiler for the development build, and then starts the watcher */
function dev() {
	const tagsDir = path.resolve(__dirname, '..', 'src');
	const outputFile = path.resolve(__dirname, '..', 'dist/app.js');
	const compileWithArgs = compile.bind(null, tagsDir, outputFile);

	compileWithArgs()
		.then(() => watch(tagsDir, compileWithArgs))
		.catch(err => {
			console.log('Something went wrong!', err.toString(), '\n', err.stack);
		});
}

/**
 * compile finds all Riot tags, compiles each one into ES2015+ JS, adds a source reference,
 * transforms that into ES5 JS and then concatenates the whole thing. This function returns a
 * Promise that is resolved when the full compilation is finished.
 */
function compile(tagsDir, outputFile) {
	console.log('compiling dev build...');
	console.time('compilation time');

	const files = fs.readdirSync(tagsDir);

	const fileTransforms = files.map(f => {
		return util.readFile(path.resolve(tagsDir, f))
			.then(tag => {
				let preBabelJS = riot.compile(tag);

				// this adds a source reference, because Riot doesn't produce a sourcemap AST yet
				preBabelJS = `// source: ${f}\n${preBabelJS}`;

				const transformResult = babel.transform(preBabelJS, { presets: ['es2015-riot'] });
				return transformResult.code;
			});
	});

	return Promise.all(fileTransforms)
		.then(js => util.writeFile(outputFile, js.join('\n')))
		.then(() => {
			console.timeEnd('compilation time');
		});
}

/**
 * watch will track changes on dir, and run onChangeFn each time a change occurs. This function
 * return a Promise that is resolved when the watcher has been initiated.
 */
function watch(dir, onChangeFn) {
	return new Promise((resolve, reject) => {
		let isReady = false;
		let rootDir = path.resolve(__dirname, '..');

		chokidar
			.watch(dir, { ignoreInitial: true })
			.on('ready', () => {
				console.log(`watching ${path.relative(rootDir, dir)}...`);
				isReady = true;
				resolve(true);
			})
			.on('error', err => {
				console.log(`Watcher error: ${error}`);
				if (!isReady) reject(error);
			})
			.on('all', (event, fpath) => {
				const time = (new Date()).toLocaleTimeString();
				console.log(`[${time}] ${event}: ${path.relative(rootDir, fpath)}`);
				onChangeFn();
			});
	});
}
