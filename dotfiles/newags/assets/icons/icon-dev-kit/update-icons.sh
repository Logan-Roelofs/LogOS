#!/bin/bash

repo_url="https://gitlab.gnome.org/Teams/Design/icon-development-kit-www.git"
repo_dir="icon-development-kit-www"

if [ ! -d "$repo_dir" ]; then
  git clone --depth 1 "$repo_url" "$repo_dir"
fi

find . -maxdepth 1 -name "*-symbolic.svg" -exec rm {} \;

find "./$repo_dir/img/symbolic" -name "*-symbolic.svg" -exec mv {} . \;

rm -rf "$repo_dir"
