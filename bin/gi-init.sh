#!/bin/bash

gitignore=".gitignore"
ignores=("tags**")

if [ ! -f "$gitignore" ]; then
  touch "$gitignore"
fi

# Loops through ignores and adds them to gitignore if they're not already there
for ignore in "${ignores[@]}"; do
  if ! grep -q "$ignore" "$gitignore"; then
    echo "$ignore" >> "$gitignore"
  fi
done

