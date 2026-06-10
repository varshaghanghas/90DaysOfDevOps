# Git Commands Reference

## Setup & Config
- `git config`: Configures Git settings like user identity.
  _Example:_ `git config --global user.name "Varsha Ghanghas"`
- `git init`: Creates a new local Git repository.
  _Example:_ `git init`

## Basic Workflow
- `git status`: Shows the state of the working directory and staging area.
  _Example:_ `git status`
- `git add`: Adds file changes to the staging area.
  _Example:_ `git add git-commands.md`
- `git commit`: Saves staged snapshots to the permanent history.
  _Example:_ `git commit -m "feat: initial commit"`

## Viewing Changes
- `git diff`: Shows differences between files in the working directory and the staging area.
  _Example:_ `git diff git-commands.md`
- `git log`: Displays the history of commits.
  _Example:_ `git log --oneline`

## Git Branching
- `git checkout -b devops`: create new branch called `devops` and moved to `devops` branch. Can also use `git switch -c <name>`.
- `git branch`: Lists, creates, or deletes branches.
- `git switch branch_name`: switches to branch given.

## Remote repositories
- `git push`: Push changes from local to remote directory on github. Only push changes to the current branch you are working in.
- `git push origin main`: Can reference the branch to push changes.

## other Commands
- `git switch <main>` : Moves your active workspace from your current branch to the specified branch.git. Same as `git checkout <name>`.
- `git push origin <master>`: Uploads your local branch commits online for the first time and links ("tracks") them together so future updates only require typing git push.
- `git pull origin <main>`: Downloads any fresh changes from the online server directly (branch given in command eg <main>) into the branch you are working on right now.
- `git merge <master> --allow-unrelated-histories`: Sucks the code history from another branch and fuses it directly into the branch you are currently standing on. `--allow-unrelated-histories` overrides Git's safety locks, forcing it to merge two branches that do not share a common starting point
- `git branch -d <master>`: Safely deletes a branch from your computer's local memory only after verifying its code has been merged elsewhere.