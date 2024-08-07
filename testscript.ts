#!/usr/bin/env tsx
import {Command} from 'commander';
import {scip} from './scip';
import * as fs from 'fs';


const program = new Command();

program
  .version("1.0.0")
  .description("")
  .parse(process.argv);

const args = program.args;
const file = fs.readFileSync(args[0], null);
const full_index = scip.Index.deserializeBinary(file);