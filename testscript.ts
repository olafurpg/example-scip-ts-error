#!/usr/bin/env tsx
import fs from 'node:fs';
import {Command} from 'commander';

import { fromBinary } from "@bufbuild/protobuf";
import { IndexSchema } from "./scip-connect";

const program = new Command();

program
  .version("1.0.0")
  .description("")
  .parse(process.argv);

const args = program.args;
const file = fs.readFileSync(args[0], null);
const full_index = fromBinary(IndexSchema, file);
console.log(full_index);
