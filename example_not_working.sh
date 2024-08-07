#!/bin/bash
git clone https://github.com/BurntSushi/ripgrep
cd ripgrep
rust-analyzer scip .
/scripts/testscript.ts index.scip