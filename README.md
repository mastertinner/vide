# Vide

[![Docker Build](https://img.shields.io/docker/cloud/build/mastertinner/vide.svg?style=flat-square)](https://hub.docker.com/r/mastertinner/vide)
![Docker Pulls](https://img.shields.io/docker/pulls/mastertinner/vide.svg?style=flat-square)

A containerized IDE powered by [NeoVim](https://neovim.io/).

This container is filled with all the good stuff from [my Vim config](https://github.com/mastertinner/dotfiles/). It contains a full "IDE" and is optimized for editing [Go](https://golang.org), [Rust](https://www.rust-lang.org), [JavaScript](https://en.wikipedia.org/wiki/JavaScript), [TypeScript](https://www.typescriptlang.org), [Markdown](https://en.wikipedia.org/wiki/Markdown) and [shell scripts](https://en.wikipedia.org/wiki/Shell_script).

## Usage

By default, the container-internal `/src` directory will be opened. You'll therefore have to mount your project into there:

```shell
$ docker run --rm -it -v "${PWD}:/src" mastertinner/vide
```

The container comes with most supported programming languages and tools preinstalled so you can run `:terminal` to run commands.

## Caveats

### Docker Detach keys

`ctrl + p` triggers a fuzzy search for files. Since this key binding is already used in Docker for detaching from containers, you'll have to press it twice to trigger the fuzzy search. To mitigate this, simply add the following line to your `~/.docker.config.json` to change the default keys:

```json
  "detachKeys": "ctrl-e,e"
```

### Resources

Some async jobs like linting JavaScript can be rather resource intensive. If the containers feels slow, consider giving Docker more memory ;-)
