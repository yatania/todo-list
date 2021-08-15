#!/usr/bin/env sh

set -e

npm run build

cd dist

git init
git add .
git commit -m 'New Deployment'
git push -f https://github.com/yatania/todo-list.git master:gh-pages

cd -
