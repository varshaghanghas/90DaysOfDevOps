# Day 26 – GitHub CLI: Manage GitHub from Your Terminal

## Overview

Today I explored the GitHub CLI (`gh`), a command-line tool that allows developers to interact with GitHub directly from the terminal. It simplifies repository management, issue tracking, pull request workflows, and GitHub Actions monitoring.

---

## Task 1: Install and Authenticate


### Install 
#### Update Package Index
```bash
sudo apt update
```

#### Install Required Dependencies
```bash
sudo apt install curl -y
```

#### Add GitHub CLI Repository
```bash
# Downloads GitHub CLI's official GPG signing key and saves it
# to /usr/share/keyrings/githubcli-archive-keyring.gpg.
# This key is later used by APT to verify that packages from
# the GitHub CLI repository are authentic and have not been tampered with.
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | \
sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
# Grants read permission on the keyring file to all users (group and others).
# APT needs to be able to read this key when validating packages.
sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
# Adds the official GitHub CLI repository to APT sources.
# - dpkg --print-architecture automatically inserts your system architecture
#   (e.g., amd64, arm64).
# - signed-by specifies the GPG key that should be used to verify packages
#   from this repository.
# - tee writes the repository entry to
#   /etc/apt/sources.list.d/github-cli.list.
# - > /dev/null suppresses the output from tee.
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | \
sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
```

#### Install GitHub CLI
```bash
sudo apt update
sudo apt install gh -y
```
#### Verify Install
```bash
gh --version
```


### Generate SSH Key

Check for existing keys:

```bash
ls -al ~/.ssh
```

Generate a new SSH key:

```bash
ssh-keygen -t ed25519 -C "your-email@example.com"
```

Start SSH agent:

```bash
eval "$(ssh-agent -s)"
```

Add key to SSH agent:

```bash
ssh-add ~/.ssh/id_ed25519
```

Display public key:

```bash
cat ~/.ssh/id_ed25519.pub
```

Copy the output.

---

### Add SSH Key to GitHub

1. Open GitHub.
2. Go to **Settings**.
3. Click **SSH and GPG keys**.
4. Click **New SSH key**.
5. Enter a title.
6. Paste the copied public key.
7. Click **Add SSH key**.

Test SSH connection:

```bash
ssh -T git@github.com
```

Expected output:

```text
Hi <username>! You've successfully authenticated.
```

---

### Authenticate GitHub CLI

Run:

```bash
gh auth login
```

Choose:

```text
GitHub.com
SSH
Login with a web browser
```

Complete authentication in your browser.

---

### Verify Authentication

Check authentication status:

```bash
gh auth status
```

Example output:

```text
✓ Logged in to github.com as <username>
✓ Git operations for github.com configured to use ssh protocol
```

Check active account:

```bash
gh api user
```

Example output:

```json
{
  "login": "your-github-username",
  "name": "Your Name"
}
```
### Question: What authentication methods does `gh` support?

GitHub CLI supports the following authentication methods:

1. Web Browser Authentication (OAuth)
2. Personal Access Token (PAT)
3. SSH Authentication
4. HTTPS Authentication
5. GitHub Enterprise Authentication

---
## Task 2: Working with Repositories

### 1. Create a New Public GitHub Repository with README

```bash
gh repo create gh-cli-test-repo --public --add-readme
```
This creates a new public repository named `gh-cli-test-repo` with a README file.

### 2. Clone 90DaysOfDevOps Repository Using `gh`

```bash
gh repo clone varshaghanghas/90DaysOfDevOps
```
This clones my `90DaysOfDevOps` repository using GitHub CLI instead of `git clone`.

### 3. View Details of a Repository from Terminal

```bash
gh repo view varshaghanghas/90DaysOfDevOps
```

To view the repository in detailed format:

```bash
gh repo view varshaghanghas/90DaysOfDevOps --json name,description,visibility,url
```

### 4. List All My Repositories

```bash
gh repo list varshaghanghas
```

To list more repositories:

```bash
gh repo list varshaghanghas --limit 100
```

### 5. Open Repository in Browser from Terminal

```bash
gh repo view varshaghanghas/90DaysOfDevOps --web
```

This opens the repository directly in the browser.

### 6. Delete the Test Repository

Be careful with this command because deleting a repository is permanent.

```bash
gh repo delete varshaghanghas/gh-cli-test-repo
```

GitHub CLI will ask for confirmation before deleting the repository.

To skip confirmation, this command can be used:

```bash
gh repo delete varshaghanghas/gh-cli-test-repo --yes
```

---
## Task 3: Working with Issues

### 1. Create an Issue from the Terminal

Create an issue with a title, description, and label:

```bash
gh issue create \
  --repo varshaghanghas/90DaysOfDevOps \
  --title "Day 26 GitHub CLI Testing" \
  --body "Created this issue as part of the Day 26 GitHub CLI challenge." \
  --label documentation
```

### 2. List All Open Issues

```bash
gh issue list --repo varshaghanghas/90DaysOfDevOps
```

Example output:

```text
#25  Day 26 GitHub CLI Testing    OPEN
#24  Update README                OPEN
```

### 3. View a Specific Issue

View issue number 25:

```bash
gh issue view 25 --repo varshaghanghas/90DaysOfDevOps
```

To open the issue in your browser:

```bash
gh issue view 25 --repo varshaghanghas/90DaysOfDevOps --web
```

### 4. Close an Issue

Close issue number 25:

```bash
gh issue close 25 --repo varshaghanghas/90DaysOfDevOps
```

Add a closing comment:

```bash
gh issue close 25 \
  --repo varshaghanghas/90DaysOfDevOps \
  --comment "Issue resolved and closed."
```

## Question: How could you use `gh issue` in a script or automation?

The `gh issue` command can be integrated into scripts and automation workflows to improve project management and incident tracking.

Examples include:

- Automatically creating issues when a CI/CD pipeline fails.
- Creating bug reports from monitoring and alerting systems.
- Opening issues when infrastructure checks detect problems.
- Generating task lists from deployment scripts.
- Automatically assigning labels and team members based on issue type.
- Creating incident tickets from application logs or cloud alerts.
- Closing issues automatically when a deployment or fix is completed.

### Example: Create an Issue When a Script Fails

```bash
#!/bin/bash

if ! ./deploy.sh; then
  gh issue create \
    --repo varshaghanghas/90DaysOfDevOps \
    --title "Deployment Failed" \
    --body "Automated deployment failed. Investigation required." \
    --label bug
fi
```
This script automatically creates a GitHub issue whenever a deployment fails.

---

## Task 4: Pull Requests

### 1. Create a New Branch

```bash
git checkout -b day-26-gh-cli
```

Verify the branch:

```bash
git branch
```

### 2. Make Changes

Edit a file, for example:

```bash
echo "GitHub CLI Practice - Day 26" >> day-26-notes.md
```

Check changes:

```bash
git status
```

### 3. Commit and Push Changes

Stage files:

```bash
git add .
```

Commit changes:

```bash
git commit -m "Add Day 26 GitHub CLI notes"
```

Push branch to GitHub:

```bash
git push origin day-26-gh-cli
```

### 4. Create a Pull Request from the Terminal

```bash
gh pr create \
  --repo varshaghanghas/90DaysOfDevOps \
  --title "Day 26: GitHub CLI Notes" \
  --body "Added Day 26 notes and completed GitHub CLI tasks."
```

Alternatively:

```bash
gh pr create --fill
```

The `--fill` option automatically uses your commit message and description.

### 5. List All Open Pull Requests

```bash
gh pr list --repo varshaghanghas/90DaysOfDevOps
```

Example output:

```text
#26  Day 26: GitHub CLI Notes     OPEN
#25  Update README                OPEN
```
### 6. View Pull Request Details

View your PR:

```bash
gh pr view
```

View a specific PR:

```bash
gh pr view 26
```

View detailed information including reviewers and checks:

```bash
gh pr view 26 \
  --json title,state,reviewRequests,reviews,statusCheckRollup
```

Open PR in browser:

```bash
gh pr view 26 --web
```

### 7. Merge the Pull Request

Merge using the default merge strategy:

```bash
gh pr merge 26 --merge
```

Squash commits into one:

```bash
gh pr merge 26 --squash
```

Rebase commits:

```bash
gh pr merge 26 --rebase
```

Delete branch after merge:

```bash
gh pr merge 26 --merge --delete-branch
```
## Question: What merge methods does `gh pr merge` support?

GitHub CLI supports three merge methods:

### Merge Commit

```bash
gh pr merge --merge
```

- Preserves all commits.
- Creates a merge commit.

### Squash Merge

```bash
gh pr merge --squash
```

- Combines all commits into a single commit.
- Keeps commit history cleaner.

### Rebase Merge

```bash
gh pr merge --rebase
```

- Replays commits on top of the target branch.
- Maintains a linear commit history.

## Question: How would you review someone else's PR using `gh`?

### List Pull Requests

```bash
gh pr list
```

### View PR Details

```bash
gh pr view 26
```

### Check Changes

```bash
gh pr diff 26
```

### Checkout the PR Locally

```bash
gh pr checkout 26
```

This downloads the PR branch to your local machine for testing.

### Approve the PR

```bash
gh pr review 26 --approve
```

### Request Changes

```bash
gh pr review 26 --request-changes --body "Please update the documentation."
```

### Leave a Comment

```bash
gh pr review 26 --comment --body "Looks good overall."
```

---

## Task 5: GitHub Actions & Workflows Preview

### 1. List Workflow Runs on a Public Repository

Example public repository that uses GitHub Actions:

```bash
gh run list --repo cli/cli
```

This lists recent workflow runs from the GitHub CLI repository.
### 2. View the Status of a Specific Workflow Run

First, copy a run ID from the previous command.

Then view the workflow run:

```bash
gh run view <run-id> --repo cli/cli
```

Example:

```bash
gh run view 1234567890 --repo cli/cli
```

To view more details:

```bash
gh run view <run-id> --repo cli/cli --log
```

### 3. List Available Workflows

```bash
gh workflow list --repo cli/cli
```

---

### 4. View Workflow Details

```bash
gh workflow view <workflow-name-or-id> --repo cli/cli
```

Example:

```bash
gh workflow view "Lint" --repo cli/cli
```

## Question: How could `gh run` and `gh workflow` be useful in a CI/CD pipeline?

`gh run` and `gh workflow` are useful in CI/CD pipelines because they allow engineers to monitor and control GitHub Actions directly from the terminal or automation scripts.

### Uses of `gh run`

- Check recent pipeline runs.
- View whether a workflow passed or failed.
- Inspect logs for failed jobs.
- Re-run failed workflow runs.
- Watch live workflow progress from the terminal.

Example:

```bash
gh run list --repo varshaghanghas/90DaysOfDevOps
```

```bash
gh run view <run-id> --repo varshaghanghas/90DaysOfDevOps --log
```

```bash
gh run watch <run-id> --repo varshaghanghas/90DaysOfDevOps
```

```bash
gh run rerun <run-id> --repo varshaghanghas/90DaysOfDevOps
```

### Uses of `gh workflow`

- List available workflows in a repository.
- View workflow configuration details.
- Enable or disable workflows.
- Manually trigger workflows.
- Integrate workflow execution into deployment scripts.

Example:

```bash
gh workflow list --repo varshaghanghas/90DaysOfDevOps
```

```bash
gh workflow run <workflow-name.yml> --repo varshaghanghas/90DaysOfDevOps
```

```bash
gh workflow disable <workflow-name.yml> --repo varshaghanghas/90DaysOfDevOps
```

```bash
gh workflow enable <workflow-name.yml> --repo varshaghanghas/90DaysOfDevOps
```

### Benefits in CI/CD

- Monitor workflow execution from terminal.
- Re-run failed workflows quickly.
- Debug workflow failures.
- Trigger workflows programmatically.
- Integrate pipeline monitoring into scripts.

### CI/CD Automation Example

```bash
#!/bin/bash

gh workflow run deploy.yml --repo varshaghanghas/90DaysOfDevOps

echo "Deployment workflow triggered."

gh run list --repo varshaghanghas/90DaysOfDevOps --limit 1
```

This script manually triggers a deployment workflow and then checks the latest workflow run.

---

## Task 6: Useful GitHub CLI Commands

### 1. `gh api` - Make Raw GitHub API Calls

The `gh api` command allows you to interact directly with the GitHub REST API from the terminal.

Get information about your GitHub account:

```bash
gh api user
```

Get details about a repository:

```bash
gh api repos/varshaghanghas/90DaysOfDevOps
```

List your repositories:

```bash
gh api user/repos
```

**Use Case:** Useful for automation scripts, retrieving repository data, and interacting with GitHub features not directly available through other `gh` commands.

### 2. `gh gist` - Create and Manage GitHub Gists

Create a gist:

```bash
echo "Hello GitHub Gist" > notes.txt
gh gist create notes.txt
```

Create a public gist:

```bash
gh gist create notes.txt --public
```

List your gists:

```bash
gh gist list
```

View a gist:

```bash
gh gist view <gist-id>
```

**Use Case:** Quickly share code snippets, notes, configuration files, or scripts.

### 3. `gh release` - Create and Manage Releases

Create a release:

```bash
gh release create v1.0.0 --title "Version 1.0.0" --notes "Initial release"
```

List releases:

```bash
gh release list
```

View release details:

```bash
gh release view v1.0.0
```

Delete a release:

```bash
gh release delete v1.0.0
```

**Use Case:** Manage software versions and publish release artifacts directly from the terminal.

### 4. `gh alias` - Create Command Shortcuts

Create an alias for listing pull requests:

```bash
gh alias set prs "pr list"
```

Use the alias:

```bash
gh prs
```

Create an alias for viewing workflow runs:

```bash
gh alias set runs "run list"
```

Use the alias:

```bash
gh runs
```

List configured aliases:

```bash
gh alias list
```

**Use Case:** Save time by creating shortcuts for frequently used GitHub CLI commands.

### 5. `gh search repos` - Search GitHub Repositories

Search for Kubernetes repositories:

```bash
gh search repos kubernetes
```

Search repositories by language:

```bash
gh search repos "language:python machine-learning"
```

Search repositories with high star counts:

```bash
gh search repos "devops stars:>1000"
```

Limit results:

```bash
gh search repos docker --limit 10
```

**Use Case:** Discover open-source projects, research technologies, and find example repositories directly from the terminal.

## All `gh` Commands Added to git-commands.md

```bash
# GitHub API
gh api user
gh api repos/<owner>/<repo>

# Gists
gh gist create <file>
gh gist list
gh gist view <gist-id>

# Releases
gh release create <tag>
gh release list
gh release view <tag>

# Aliases
gh alias set prs "pr list"
gh alias list

# Repository Search
gh search repos <keyword>
gh search repos "language:python"
```

---

## Key Learnings

- Learned how to install and configure GitHub CLI (`gh`) on Ubuntu.
- Generated SSH keys and connected GitHub securely using SSH authentication.
- Authenticated GitHub CLI and verified the active GitHub account.
- Created, viewed, listed, and deleted repositories directly from the terminal.
- Cloned repositories using `gh repo clone` instead of traditional Git commands.
- Created, viewed, listed, and closed GitHub issues using GitHub CLI.
- Learned how GitHub Issues can be integrated into automation and CI/CD workflows.
- Created branches, pushed changes, opened pull requests, and merged them entirely from the terminal.
- Explored different pull request merge strategies: Merge, Squash, and Rebase.
- Reviewed pull requests using GitHub CLI commands such as `gh pr diff`, `gh pr checkout`, and `gh pr review`.
- Explored GitHub Actions workflows using `gh run` and `gh workflow`.
- Learned how GitHub CLI can be used to monitor, debug, and trigger CI/CD pipelines.
- Used `gh api` to interact with the GitHub REST API directly from the terminal.
- Created and managed GitHub Gists using `gh gist`.
- Learned how to create and manage GitHub Releases using `gh release`.
- Created custom command shortcuts with `gh alias`.
- Searched GitHub repositories directly from the terminal using `gh search repos`.
- Understood how GitHub CLI improves developer productivity by reducing context switching between the browser and terminal.
- Gained hands-on experience with terminal-based GitHub management, an important skill for DevOps and automation workflows.

---

## Conclusion

GitHub CLI is an essential tool for DevOps engineers and developers. It streamlines GitHub workflows, supports automation, and enables efficient repository management directly from the command line.