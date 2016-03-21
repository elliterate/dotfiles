#!/bin/bash -e

# Get the directory of this script, regardless of where it is called from.
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Find all files.
DOTFILES=$( find $DIR -type f )
# Strip leading "$DIR/" added by `find`.
DOTFILES=$( echo "${DOTFILES[*]}" | sed "s|^$DIR/||" )
# Filter dotfiles (those whose relative path begins with a dot).
DOTFILES=$( echo "${DOTFILES[*]}" | egrep '^\.' )
# Reject internal version control files.
DOTFILES=$( echo "${DOTFILES[*]}" | egrep -v '^\.git(\/|$)' )

for file in $DOTFILES; do
  target=$DIR/$file
  destination=$HOME/$file
  destination_dir=`dirname $destination`

  # Ensure the destination directory exists.
  if [ ! -d $destination_dir ]; then
    mkdir -p $destination_dir
  fi

  if [ -L $destination ]; then
    if [ "$( readlink $destination )" != "$target" ]; then
      # Backup an existing destination symlink that links to something else.
      mv -f $destination $destination.bak
    fi
  elif [ -e $destination ]; then
    # Backup an existing non-symlink file.
    mv -f $destination $destination.bak
  fi

  # Symlink the dotfile.
  ln -nfs $target $destination
done
