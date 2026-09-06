#!/bin/sh
# AI-Generated-By: OpenAI Codex
# Updated: 2026-09-06

# Install from this checkout; never clone, download plugins, or change login shells.
set -eu
repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P)
target_dir=${HOME:?HOME must be set}
with_zsh=false
dry_run=false
while [ "$#" -gt 0 ]; do
    case "$1" in
        --zsh) with_zsh=true ;;
        --dry-run) dry_run=true ;;
        --target) shift; [ "$#" -gt 0 ] || { echo '--target requires a directory' >&2; exit 2; }; target_dir=$1 ;;
        --help) echo 'Usage: sh install-nas.sh [--dry-run] [--zsh] [--target DIRECTORY]'; exit 0 ;;
        *) echo "Unknown option: $1" >&2; exit 2 ;;
    esac
    shift
done
[ -d "$target_dir" ] || { echo "Target directory does not exist: $target_dir" >&2; exit 1; }
target_dir=$(CDPATH= cd -- "$target_dir" && pwd -P)
command -v git >/dev/null
if "$with_zsh"; then command -v zsh >/dev/null; fi
git_entry=$(mktemp)
trap 'rm -f -- "$git_entry"' EXIT HUP INT TERM
git config --file "$git_entry" --add include.path "$repo_dir/.gitconfig"
git config --file "$git_entry" --add include.path '~/.gitconfig.local'
backup_dir=
install_link() {
    source_file=$1
    destination=$target_dir/$2
    if [ "${3:-link}" = file ] && [ -f "$destination" ] && [ ! -L "$destination" ] && cmp -s "$source_file" "$destination"; then
        echo "Already configured: $destination"
        return
    fi
    if [ -L "$destination" ] && [ "$(readlink "$destination")" = "$source_file" ]; then
        echo "Already linked: $destination"
        return
    fi
    if "$dry_run"; then
        echo "Would install ${3:-link} (backing up any existing path): $destination"
        return
    fi
    if [ -e "$destination" ] || [ -L "$destination" ]; then
        if [ -z "$backup_dir" ]; then
            backup_dir=$(mktemp -d "$target_dir/.my-config-backup.XXXXXXXX")
            chmod 700 "$backup_dir"
            echo "Backup directory: $backup_dir"
        fi
        mv -- "$destination" "$backup_dir/$2"
    fi
    if [ "${3:-link}" = file ]; then
        cp -- "$source_file" "$destination"
        chmod 600 "$destination"
        echo "Configured: $destination"
    else
        ln -s -- "$source_file" "$destination"
        echo "Linked: $destination -> $source_file"
    fi
}
install_link "$git_entry" .gitconfig file
install_link "$repo_dir/.gitignore_global" .gitignore_global
if "$with_zsh"; then
    install_link "$repo_dir/.zshenv" .zshenv
    install_link "$repo_dir/.zprofile" .zprofile
    install_link "$repo_dir/.zshrc" .zshrc
fi
