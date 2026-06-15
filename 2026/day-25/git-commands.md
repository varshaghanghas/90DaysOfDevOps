# Git Commands Cheat Sheet (Days 22–25)

## Setup & Config
- `git init` - Initializes a brand new local repository.
- `git config --global user.name "Name"` - Sets global commit name.
- `git config --global user.email "email@example.com"` - Sets global commit email.

## Basic Workflow
- `git add <file>` - Adds specific file modifications to the staging area.
- `git add .` - Stages all local modifications in the current directory.
- `git commit -m "message"` - Records staged snapshots into project history.
- `git status` - Shows working directory and staging area states.
- `git log --oneline` - Displays condensed chronological commit history.
- `git diff` - Views unstaged file differences against the last commit.

## Branching
- `git branch <name>` - Creates a new branch pointer.
- `git checkout <name>` - Switches to the specified branch.
- `git switch <name>` - Modern alternative to switch branches safely.
- `git branch -d <name>` - Deletes a fully merged local branch.

## Remote
- `git clone <url>` - Copies a remote repository locally.
- `git remote add origin <url>` - Links local repository to a remote server.
- `git push origin <branch>` - Uploads local commits to a remote branch.
- `git fetch` - Downloads history from remote without altering local files.
- `git pull` - Fetches remote changes and merges them into current HEAD.

## Merging & Rebasing
- `git merge <branch>` - Joins specified branch history into active branch.
- `git rebase <branch>` - Rewrites local commits on top of another branch tip.

## Stash & Cherry Pick
- `git stash` - Saves modified tracking files onto a temporary stack.
- `git stash pop` - Restores and deletes the latest stashed set of files.
- `git cherry-pick <commit-hash>` - Applies changes from an isolated commit.

## Reset & Revert
- `git reset --soft HEAD~1` - Undoes commit; leaves files staged.
- `git reset --mixed HEAD~1` - Undoes commit; leaves files unstaged.
- `git reset --hard HEAD~1` - Undoes commit; wipes all local changes completely.
- `git revert <commit-hash>` - Creates a new forward-facing undo commit safely.


## The Safety Net: git reflog
If you accidentally run `git reset --hard` and wipe out your work, the commits are not instantly gone. Git keeps a hidden log of your historical HEAD movements for up to 90 days.

- **View Reflog:** `git reflog`
- **How to rescue a lost commit:** 
  1. Find the commit hash or the pointer reference (e.g., `HEAD@{2}`) from before your destructive reset.
  2. Run `git reset --hard HEAD@{2}` to completely restore your working tree to that exact moment in time.
