# Cash

Cash is a CLI tool for calculating content hash with SHA-256.

## Features

- SHA-256 content hashing
- Supports `.contenthashignore` file with `.gitignore` syntax
- That's it

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

➜  simple-nodejs git:(main) cash
6a244f061a8f06a9d1c0518f16afb0252ae7b6c5e28b772e5fa6459b9c930554
```
