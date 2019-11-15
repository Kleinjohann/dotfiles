#!/usr/bin/env bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

BACKUPPATH="$HOME/dotfile_backup"

# Font Colour Definitions

RED=`tput setaf 1`
GREEN=`tput setaf 2`
RESET=`tput sgr0`

# Utility Functions

file_exists() { test -e "$1"; }

is_symlink() { test -L "$1"; }

create_new_symlink() { ln -s "$1" "$2"; }

invalid_file_error() {
    file_loc="$1"
    symlink_loc="$2"

    echo "${RED}WARNING${RESET}: Failed to link $symlink_loc to $file_loc"
    echo "         $file_loc does not exist"

    return 1
}

mv_and_rename_if_target_exists() {
    file="$1"
    target_dir="$2"

    basename="${file##*/}"
    stripext="${fname%.*}"
    extension="${fname##*.}"

    if file_exists "$target_dir/$basename"
    then
        n=1
        while file_exists "$target_dir/${stripext}_$n.$extension"
        do
            let n+=1
        done
        mv "$file" "$target_dir/${stripext}_$n.$extension"
    else
        mv "$file" "$target_dir/$basename"
    fi

}

handle_existing_regular_file() {
    echo "It seems like $symlink_loc already exists."
    read -p "Do you want to [d]elete, [m]ove (-> $BACKUPPATH/) or [k]eep $symlink_loc? " -n 1 -r </dev/tty

    if [[ $REPLY =~ ^[Dd]$ ]]
    then
        printf "\nDeleting $symlink_loc..."

        rm -rf "$symlink_loc"
        create_new_symlink "$file_loc" "$symlink_loc"

        echo "Created a symlink $symlink_loc -> $file_loc"

    elif [[ $REPLY =~ ^[Mm]$ ]]; then
        printf "\nMoving $symlink_loc to $BACKUPPATH..."

        mkdir -p "$BACKUPPATH"
        mv_and_rename_if_target_exists "$symlink_loc" "$BACKUPPATH"
        create_new_symlink "$file_loc" "$symlink_loc"

        echo "Created a symlink $symlink_loc -> $file_loc"

    else
        printf "\nKeeping $symlink_loc...\n"

    fi
}

handle_existing_symlink() {
    current_dest=$(readlink "$symlink_loc")

    if [[ "$current_dest" == "$file_loc" ]]
    then
        echo "$symlink_loc -> $file_loc ${GREEN}exists${RESET}."
    else
        echo "It seems like $symlink_loc already is a symlink to $current_dest."
        read -p "Do you want to replace it? [Y/N] " -n 1 -r </dev/tty

        if [[ $REPLY =~ ^[Yy]$ ]]
        then
            echo
            echo "Removing current symlink..."

            unlink "$symlink_loc"
            create_new_symlink "$file_loc" "$symlink_loc"

            echo "Created a symlink $symlink_loc -> $file_loc"

        fi
    fi

    echo

}

handle_existing_file() {
    file_loc="$1"
    symlink_loc="$2"

    if is_symlink "$symlink_loc"
    then
        handle_existing_symlink "$file_loc" "$symlink_loc"
    else
        handle_existing_regular_file "$file_loc" "$symlink_loc"
    fi

}

create_link() {
    file_loc="$SCRIPTPATH/$1";
    target_name=".${1%.*}"
    symlink_loc="$HOME/$target_name";

    if ! file_exists "$file_loc"
    then
        invalid_file_error "$file_loc" "$symlink_loc"
    elif file_exists "$symlink_loc"
    then
        handle_existing_file "$file_loc" "$symlink_loc"
    else
        create_new_symlink "$file_loc" "$symlink_loc"
        echo "Created a symlink $symlink_loc -> $file_loc"
    fi
}

find -name '*.symlink' | while read line; do
    filename="${line##*/}"
    create_link "$filename"
done

