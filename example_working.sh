#!/bin/bash
git clone https://github.com/google-deepmind/graphcast
cd graphcast
scip-python index
/scripts/testscript.ts index.scip