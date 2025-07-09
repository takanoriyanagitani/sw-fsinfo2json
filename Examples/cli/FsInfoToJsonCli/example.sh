#!/bin/sh

./FsInfoToJsonCli . |
  dasel --read=json --write=toml |
  bat --language=toml
