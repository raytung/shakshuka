# Shakshuka

[![Build status](https://github.com/raytung/shakshuka/actions/workflows/ci.yml/badge.svg)](https://github.com/raytung/shakshuka/actions)
[![Crates.io](https://img.shields.io/crates/v/shakshuka.svg)](https://crates.io/crates/shakshuka)
[![Docker Hub](https://img.shields.io/docker/v/raytung/shk?label=Docker%20Hub&sort=semver)](https://img.shields.io/docker/v/raytung/shk?label=Docker%20Hub&sort=semver)

Shakshuka (`shk`) is a CLI tool for calculating content hash with SHA-256.

## Features

- SHA-256 content hashing
- Supports `.contenthashignore` file with `.gitignore` syntax.
  - Directories and files listed in `.contenthashignore` won't be included for calculating content hash

## Use case

This tool was built with repository management and artifact publishing in mind. Specifically, you may not want to trigger
an infrastructure deployment, or may not want to publish a new artifact (say Docker container image) if you only updated
content in a `README` file. With `shk`, you are able to tag your Docker image with the hash produced by `shk`, and skip
Docker image build step on CI completely if an image with the same hash already exist.

Do let me know if you have another use case for `shk`!

## Installation

The binary name for shakshuka is `shk`.

If you have the **Rust** toolchains installed, shakshuka can be installed with `cargo`

```shell
$ cargo install shakshuka
```

If you have **Docker** installed, shakshuka can be installed and run with `docker`

```shell
$ docker run --rm --volume "${PWD}:/opt/work/" --workdir "/opt/work/" raytung/shk
```

## Example

```
➜  simple-nodejs git:(main) exa -hlgSa .
Permissions Size Blocks User    Group   Date Modified Name
.rw-rw-r--    32      8 raytung raytung 22 Feb 21:30  .contenthashignore
.rw-rw-r--    14      8 raytung raytung 22 Feb 21:30  .gitignore
.rw-rw-r--    69      8 raytung raytung 22 Feb 21:30  jest.config.js
.rw-rw-r--   345      8 raytung raytung 22 Feb 21:30  package.json
drwxrwxr-x     -      - raytung raytung 22 Feb 21:30  src
.rw-rw-r--  155k    304 raytung raytung 22 Feb 21:30  yarn.lock

➜  simple-nodejs git:(main) bat .contenthashignore
───────┬──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
       │ File: .contenthashignore
───────┼──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
   1   │ node_modules/
   2   │ .contenthashignore
───────┴──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

➜  simple-nodejs git:(main) shk
6a244f061a8f06a9d1c0518f16afb0252ae7b6c5e28b772e5fa6459b9c930554
```
