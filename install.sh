#!/bin/bash
dir=$(cd $(dirname $0) && pwd)
rel=${dir#$HOME/}
ok=0
ng=0

# Update submodules
git submodule update --init

# Make links
for x in .*
do
  if [[ "$x" = "." || "$x" = ".." || "$x" = ".git" || "$x" = ".gitmodules" || "${x%.swp}" != "$x" ]]; then
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

# clone Vundle
dest=~/.vim/bundle/Vundle.vim
if [[ ! -e $dest ]]; then
  if git clone https://github.com/VundleVim/Vundle.vim.git $dest; then
    echo "info: cloned Vundle.vim"
    echo "info: execute \"VundleInstall\" command in vim!"
    ok=$(($ok+1))
  else
    echo "error: cannot clone Vundle.vim"
    ng=$(($ng+1))
  fi
else
  echo "info: skipped cloning Vundle.vim"
fi

# clone 

test $ng -eq 0
