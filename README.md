# Interview Generator
Prepare for a job interview with a mix of common and quirky questions.


## How To Run It

First, install the dependencies with Yarn (`yarn install`) or NPM (`npm install`).

Then, if you want the development build, use `node run/dev`. This will also start a watcher on the *src* directory, that will recompile the build whenever a change occurs.

On the other hand, if you the production build, use `node run/prod`.

Once you have a build, you should be able to just open *index.html* directly in your browser, since this app doesn't do any network calls.


## Why?

I wanted to help out my girlfriend prepare for an interview, and I've playing around with [Riot](https://riot.js.org/) recently. After putting it together pretty quickly (it has only one source file), I decided to use it as a playground to test out some ideas.

I've been wanting to find ways to dramatically simplify and speed up my front-end development stack, while still keeping the most useful features of the different tools I've used in the past few years.

I'm a fan of building components with React + JSX, with my template sitting in the same file as my component code, and this template reflecting the state of my component without using two-way binding (unlike AngularJS). Riot uses the same approach, but with a lighter framework and a simpler approach to pre-compiling.

More importantly, I want to really simplify my development toolchain. I've made use of Grunt, Gulp, Brocolli, Webpack and Browserify in the past, and I've never been fully satisfied. I've come to the conclusion that no development toolchain will "just work", there will always be some point where you'll need rack your brain to figure why X build tool isn't outputting what you're expecting, why it's taking so long run a certain task or why it's taking so much to just *initiate* before running a task.

The biggest issue when running into these toolchain problems is that you have very little visibility. You're using a tool (Webpack, Gulp, etc) with a big codebase, paired with a bunch of plugins for each little subtask that you want to run, all outputting log or error messages of their choosing. So I've decided to bypass these tools altogether and use the NPM modules (like [babel-core](https://github.com/babel/babel/tree/master/packages/babel-core)) directly. That's what this repo demonstrates and the main reason I've decided to upload it.


## The Research Conclusions

So far, this development toolchain is looking quite promising.

- Tasks start very quickly
- Compilation runs under 500ms on my 2013 Macbook Pro
- In dev mode, recompilation after a file change takes under 100ms
- The task scripts are small, easy to understand
- Improvements can easily be added for future needs

That last point was a really nice surprise. For example, I've realized I could easily shorten recompilation times by adding an in-memory cache of the file transforms (but it would be overkill at this point). I could also add colors to my toolchain logs, or start a static server, or a bunch of other things. Doing so would simply require me to search for the appropriate NPM module, or to just create the functionality myself. No need to rely on some intermediary toolchain plugin.
