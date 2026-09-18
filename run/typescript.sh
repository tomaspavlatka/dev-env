#!/bin/sh

# TypeScript compiler (tsc) plus its language server, used by the ts_ls LSP in Neovim.
#
# typescript is pinned to the 6.x line: 7.x is the native Go rewrite and no longer
# ships lib/tsserver.js, which typescript-language-server requires to start.
npm install -g typescript@6 typescript-language-server
