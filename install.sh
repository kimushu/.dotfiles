#!/bin/sh
dir=$(cd $(dirname $0) && pwd)
rel=${dir#$HOME/}
ok=0
ng=0
for x in .*
do
  if [[ "$x" = "." || "$x" = ".." || "$x" = ".git" || "${x%.swp}" != "$x" ]]; then
    continue
  fi
  link=$HOME/$x
  if [[ -L $link ]]; then
    dest=$(readlink $link)
    if [[ "$dest" != "$rel/$x" ]]; then
      echo "error: destination not match ($link -> $dest)"
      ng=$(($ng+1))
    else
      echo "info: $link -> $dest (already exists)"
      ok=$(($ok+1))
    fi
  elif [[ -a $link ]]; then
    echo "error: $link is not symbolic link"
    ng=$(($ng+1))
  else
    dest=$rel/$x
    if ln -s $dest $link; then
      echo "info: $link -> $dest (created)"
      ok=$(($ok+1))
    else
      echo "error: cannot create symbolic link ($link -> $dest)"
      ng=$(($ng+1))
    fi
  fi
done
test $ng -eq 0
