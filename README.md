# yaktor

DSL-based tool to produce an event-driven, asynchronous, distributed, multi-party state machine for Node.js.

## Description

[Yakor](https://github.com/Scispike/yaktor) leverages our npm modules [yaktor-lang](https://github.com/Scispike/yaktor-lang-js) and [yaktor-ui-angular1](https://github.com/Scispike/yaktor-ui-angular1) to produce an event-driven, asynchronous, distributed, multi-party state-machine in Node.js.

It is also an application generator for building an application based on yaktor.

## Usage

Typically, you'll want to

```
$ docker run -it -v "$PWD":/app --rm yaktor/yaktor yaktor create myapp
```

which will use Docker to pull the latest yaktor image and create a yaktor-based application called `myapp`.  Then, when the command completes,

```
$ cd myapp
$ yak gen-src gen-views start
```

After that, you can navigate to the `myapp`'s UI at `http://myapp.yaktor` (if you're on Mac with `docker-machine` installed, you'll have to use the IP address instead of `myapp.yaktor` that's echoed to the terminal when `yak start` runs).

## Edit

Once you're running, you can use any text editor you want to work on your application, but you might consider using our eclipse plugins, available at eclipse update site http://yaktor.io/eclipse.  They include a yaktor DSL-aware editor for `*.cl` and `*.dm` files that provide syntax highlighting and completion.

For more information, see the full yaktor documentation.