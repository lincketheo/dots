#!/bin/bash

pc_file=".pre-commit-config.yaml"

if [ -f $pc_file ]; then
  echo "Already has a $pc_file. Remove it or manually install the pre-commit config file"
else
  cat <<EOF >$pc_file
# See https://pre-commit.com/hooks.html for more hooks
repos:
-   repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v3.2.0
    hooks:
    -   id: trailing-whitespace
    -   id: end-of-file-fixer
    -   id: check-yaml
    -   id: check-added-large-files
    -   id: check-merge-conflict
    -   id: check-symlinks
    -   id: detect-private-key
    -   id: check-ast
    -   id: check-executables-have-shebangs
    -   id: check-json
- repo: https://github.com/syntaqx/git-hooks
  rev: v0.0.18
  hooks:
  - id: shellcheck
  - id: shfmt
EOF

  pre-commit install
fi

echo "Reference:"
echo "    Install your precommits     pre-commit install"
echo "    Test your precommits:       pre-commit run --all-files"
