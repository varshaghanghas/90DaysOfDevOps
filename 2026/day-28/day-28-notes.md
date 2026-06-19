# Day 28 – Revision Day: Everything from Day 1 to Day 27


## Challenge Tasks

### Task 1: Self-Assessment Checklist
Go through the checklist below. For each item, mark yourself honestly:
- **Can do confidently**
- **Need to revisit**
- **Haven't done yet**

#### Linux
- [x] Navigate the file system, create/move/delete files and directories
- [x] Manage processes — list, kill, background/foreground
- [ ] Work with systemd — start, stop, enable, check status of services
- [x] Read and edit text files using vi/vim or nano
- [x] Troubleshoot CPU, memory, and disk issues using top, free, df, du
    - CPU troubleshooting with `top`
    - Memory troubleshooting with `free`: `free -h` (`-h` makes files easy to read)
    - Disk space overview with `df`: `df -h`
    - Find large files with `du`: `du -sh *` (can run inside a folder to find what is wasting space), `du -sh * | sort -h` will find andn sort the biggest item first.
- [x] Explain the Linux file system hierarchy (/, /etc, /var, /home, /tmp, etc.)
    - `/`: root dir/ starting point
    - `/etc`: configuration files like user accounts exists in `/etc/passwd`
    - `/var`: variable data. like logs for any app exists here
    - `/home`: home dir/ user personal folder. eg for user `varsha` files exists in `/home/varsha`
    - `/tmp`" temporary files created by programs
    - other folders like `/bin` or `/sbin` holds the core programs and commands like `ls`, `cd`, `systemctl` etc.
- [x] Create users and groups, manage passwords
    - create a user using `useradd varsha`
    - set/change password `passwd varsha`
    - delete a user using `userdel -r varsha` (`-r` removes the home dir and personal files)
    - create a group `groupadd devops`
    - add a user to group `usermod -aG devops varsha`
    - remove user from group `gpasswd -d varsha devops`
    - all users are in `/etc/passwd` and groups are in `/etc/group`
- [x] Set file permissions using chmod (numeric and symbolic)
    - `chmod 744 filename/foldername`: numeric method uses 4 2 1 as 4= Read(`r`), 2= write(`w`), 1= execute(`x`). eg `744` is 7 (4+2+1) Owner can read, write and execute. 4 Group can only read. 4 Others can only read.
    - `chmod +x file/folder`: Symbolic method. 
        - `u` = User (owner), `g` = Group, `o` =Others, `a` = All users.
        - `+`= Add permission, `-`= Remove permission, `=`= Set exactly permission. eg; `chmod g+w file.txt` → Adds Write permission for the group. `chmod o-rwx file.txt` → Removes all permissions from others. `chmod u+x script.sh` → Adds Execute permission only for the owner

- [x] Change file ownership with chown and chgrp
    - changing owner with `chown`. `chown username filename` or changing user and group together `chown username:groupname filename`. `chown -R varsha /folderPath` apply changes to entire folder
    - changing group with `chgrp`. eg. `chgrp groupname filename`. `chgrp -R devops /folderPath` apply changes to entire folder.
- [x] Create and manage LVM volumes
    - create a physical volume(PV): `pvcreate /dev/sdb`, `/dev/sdb` is a hard drive for LVM use.
    - create a volume group(VG): `vgcreate my_pool /dev/sdb`, this will bundle PV drive in a shared storage pool called `my_pool`.
    - Create and Use a Logical Volume (LV): `lvcreate -L 20G -n my_storage my_pool`, we can carve an actual partition out of your storage pool. Let's create a 20 Gigabyte partition named `my_storage`. 
    - format and mount: 
        ```bash
        sudo mkfs.ext4 /dev/my_pool/my_storage
        sudo mkdir /mnt/data
        sudo mount /dev/my_pool/my_storage /mnt/data
        ```
    - Verify: `sudo lvs` or `sudo lvdisplay` 
    - Delete an LVM Setup: Unmount folder `sudo umount /mnt/data`, Remove LV: `sudo lvremove /dev/my_pool/my_storage`, Remove VG: `sudo vgremove my_pool`, Remove PV: `sudo pvremove /dev/sdb`
- [x] Check network connectivity — ping, curl, netstat, ss, dig, nslookup
    - check basic connections `ping 192.168.1.100`
    - test web pages and apps `curl google.com` or `curl -I google.com`; `-I` option grabs server status code instead of entire web page text.
    - `ss`: The modern tool to check active connections. eg; `ss -tulpn`
    - `netstat` this is oldest version of `ss` but we need to install it via `apt install net-tools`. eg. `netstat -tulpn`. What the `-tulpn` options mean:
        - `t` = Show TCP connections
        - `u` = Show UDP connections
        - `l` = Show only listening ports
        - `p` = Show the program name using the port
        - `n` = Show raw numbers instead of names
    - lookup for web addresses `nslookup google.com`
- [x] Explain DNS resolution, IP addressing, subnets, and common ports
    - DNS: Computers do not understand website names like `google.com`. They only understand numbers. Domain Name System (DNS) is the system that translates human names into computer numbers.
    - IP Addressing: (the home address). IPv4  & IPv6.
        - IPv4: most common used style and uses 4 numbers seperated by dots. eg. `192.168.1.1`
        - IPv6: newer style made because the world ran out of IPv4 numbers. It uses numbers and letters separated by colons. Example: `2001:0db8:85a3:0000:0000:8a2e:0370:7334`
    - Subnet: is like neighborhoods or sub-network which divides large network into smaller, organized pieces. Think of a large company network like a big apartment building. A subnet is like grouping rooms by floor so the mailman does not get lost. Computers on same subnet can talk to each other directly.
    - Common ports: is like apartment doors. if an IP address is street adrress of an apartment building, a *port* is specific apartment number.  Some common ports are: `22` for SSH, `80` for HTTP, `443` for HTTPS etc.

#### Shell Scripting
- [x] Write a script with variables, arguments, and user input
    - script (`script.sh`) with variables and arguments
    ```bash
    #!/bin/bash

    # VARIABLES and ARGUMENTS ($1 IS FIRST WORK TYPES AFTER SCRIPT NAME)
    NAME="Varsha"
    AGE=$1

    echo "Hello $NAME. You age is $AGE"

    # USER INPUT
    read -p "Enter you name: " USERNAME
    echo "Welcome $USERNAME"
    ```
    - Run the script: 
    ```bash
    chmod 744 script.sh     # making the script executable
    ./script.sh 30          # 30  is age passing as argument
    ```
- [x] Use if/elif/else and case statements
    - write script with **if else** in `if_else_case.sh`
    ```bash
    #!/bin/bash

    # 1. IF / ELIF / ELSE
    read -p "Enter score (1-10): " NUM
    if [ "$NUM" -gt 7 ]; then
        echo "Great score!"
    elif [ "$NUM" -eq 7 ]; then
        echo "Good score!"
    else
        echo "Needs practice!"
    fi

    # 2. CASE STATEMENT
    read -p "Enter choice (start/stop): " ACT
    case $ACT in
        "start") echo "Starting service..." ;;
        "stop")  echo "Stopping service..." ;;
        *)       echo "Unknown choice!"     ;;
    esac
    ```
    - Run it: 
    ```bash
    chmod 744 if_else_case.sh
    ./if_else_case.sh
    ```
- [x] Write for, while, and until loops
    - script for `loops.sh`
    ```bash
    #!/bin/bash

    # 1. FOR LOOP (Runs a set number of times)
    echo "--- For Loop ---"
    for i in {1..3}; do
        echo "Count: $i"
    done

    # 2. WHILE LOOP (Runs AS LONG AS a condition is true)
    echo "--- While Loop ---"
    NUM=1
    while [ $NUM -le 3 ]; do
        echo "While: $NUM"
        NUM=$((NUM + 1))
    done

    # 3. UNTIL LOOP (Runs UNTIL a condition becomes true)
    echo "--- Until Loop ---"
    COUNT=1
    until [ $COUNT -gt 3 ]; do
        echo "Until: $COUNT"
        COUNT=$((COUNT + 1))
    done
    ```
    - run it
    ```bash
    chmod 744 loops.sh
    ./loops.sh
    ```
- [x] Define and call functions with arguments and return values
    - script `short_func.sh`
    ```bash
    #!/bin/bash

    # 1. FUNCTION WITH ARGUMENTS ($1 is the first argument passed in)
    greet() {
        echo "Hello, $1!"
    }

    # 2. FUNCTION WITH RETURN VALUE
    add() {
        echo $(($1 + $2))
    }

    # 3. CALLING THE FUNCTIONS
    greet "Varsha"

    # Run the function and save its output into a variable
    SUM=$(add 10 5)
    echo "Result is: $SUM"
    ```
    - run it
    ```bash
    chmod 744 short_func.sh
    ./short_func.sh
    ```
- [x] Use grep, awk, sed, sort, uniq for text processing
    - Filter lines with `grep`: eg `grep "error" log.txt` print line containing word "error".
    - Extract columns with `awk`: `awk '{print $1}' log.txt` prints just first word of every line (`error:`, `info:`, etc.)
    - replace with `sed`: `sed 's/error/danger' log.txt` changes every word *"error"* with *"danger"* in `log.txt`
    - sort line with `sort`: `sort log.txt`
    - clean duplicates with `uniq`: `sort log.txt | uniq` gives a clean list with unique lines.
    - combined example `grep "error" log.txt | sort | uniq -c` Output: 1 error: service crash and 2 error: database timeout (The `-c` flag counts the matches).
- [x] Handle errors with set -e, set -u, set -o pipefail, trap
    - Safety Guard: `set -eui o pipefail`
        - `set -e` exit on error
        - `set -u` unset variables. stops immediately if we try to use a variable that was never create.
        - `set -p pipefail` pipeline failures. Ensures that if you chain commands together with a pipe (`|`), the script will fail if any command in the chain fails, not just the last one.
    - Catching Cleanups with `trap`: The `trap` command lets you run a specific action automatically when your script finishes or crashes. It is perfect for cleaning up temporary files so you don't leave clutter behind. eg: 
    ```bash
    #!/bin/bash
    set -e -u -o pipefail

    # Run the 'cleanup' function automatically on EXIT (success or crash)
    trap 'cleanup' EXIT

    cleanup() {
        echo "🧹 Cleaning up temporary files..."
        rm -f /tmp/work_file.txt
    }

    # Script logic starts here
    echo "Working..." > /tmp/work_file.txt
    echo "Processing complete."
    ```
- [x] Schedule scripts with `crontab`
    - `crontab` is a built-in Linux tool used to automate and schedule scripts to run at specific times.  The 5-Star Time Code:
    ```text
    *   *   *   *   *   
    │   │   │   │   │   
    │   │   │   │   └── Day of week (0-6) (Sunday=0)
    │   │   │   └─── Month (1-12)
    │   │   └─── Day of month (1-31)
    │   └─── Hour (0-23)
    └─── Minute (0-59)
    ```
    - Common Schedule Examples: 
        - Every minute: * * * * *
        - Every hour (at minute 0): 0 * * * *
        - Every day at midnight: 0 0 * * *
        - Every Sunday at midnight: 0 0 * * 0
    - How to setup scheduler: `crontab -e` edit crontab job. `crontab -l` list scheduled tasks.


#### Git & GitHub
- [x] Initialize a repo, stage, commit, and view history
    - Initialize a repo: `git init`
    - stage fiiles: `git add filename` or `git add .`
    - commit changes: `git commit -m "you commit msg"`
    - history: `git log` or `git log --oneline`
- [x] Create and switch branches
    - Create a branch: `git branch feature-abc`
    - Switch to a branch: `git checkout feature-abc` (Or use the modern command: `git switch feature-abc`)
    - Create and switch at once: `git checkout -b feature-xyz` (Or `git switch -c feature-xyz`)
- [x] Push to and pull from GitHub
    - Link local to GitHub: `git remote add origin https://github.com`
    - Push to GitHub: `git push -u origin main` (Sends local commits to GitHub)
    - Pull from GitHub: `git pull origin main` (Fetches changes from GitHub and merges them into your file)
- [x] Explain clone vs fork
    - `clone`: copying an exisitng repo from remote to local computer
    - `fork`: making a perosnal monline copy of someone's public repo on your github. perfect for contributing to projects.
- [x] Merge branches — understand fast-forward vs merge commit
    - **Fast-Forward Merge**: Happens if the main line hasn't changed. Git just slides the pointer forward. No new commit is made.
    - **Merge Commit**: Happens when both branches have new changes. Git blends the code together and creates a new "merge commit" to tie them up
- [ ] Rebase a branch and explain when to use it vs merge
- [x] Use git stash and git stash pop
    - **Stash work**: `git stash` hides your unfinished changes so your workplace becomes clean.
    - **Bring work back**: `git stash pop` restores your hidden changes so you can keep coding.
- [x] Cherry-pick a commit from another branch
    - Cherry-pick: `git cherry-pick COMIIT_ID` copies a single commit from an other branch and paste it right into your current branch.
- [x] Explain squash merge vs regular merge
    - **Regular merge**:  keeps every single commit you made on your feature branch when moving to main.
    - **Squash merge**: condesnses all 10 or 20 of your small feature commit into *one single clean commit* before adding it to main.
- [x] Use git reset (soft, mixed, hard) and git revert
    - `git reset --soft`: Uncommits your changes. Files stay staged.
    - `git reset --mixed`: Uncommits your changes. Files become unstaged.
    - `git reset --hard`: Danger! Destroys all changes and resets everything back to the last commit.
    - `git revert COMMIT_ID`: Safe for public code. Creates a brand new commit that does the exact opposite of the broken commit
- [x] Explain GitFlow, GitHub Flow, and Trunk-Based Development
    - **GitFlow**: Complex strategy using separate branches for features, develops, releases, and hotfixes. Good for traditional software.
    - **GitHub Flow**: Simple and agile. Everything branches off main, gets reviewed via Pull Requests (PRs), and deploys immediately.
    - **Trunk-Based**: Developers commit small changes directly into the main ("trunk") branch multiple times a day to avoid big merge conflicts
- [x] Use GitHub CLI to create repos, PRs, and issues
    - Create a repo: `gh repo create`
    - Create a PR: `gh pr create`
    - Create an issue: `gh issue create`

---

### Task 2: Revisit Your Weak Spots
1. Pick **3 topics** from the checklist where you marked "Need to revisit"
2. Go back to that day's challenge and redo the hands-on tasks
3. Document what you re-learned in `day-28-notes.md`


**Work with systemd** — start, stop, enable, check status of services
    - 🟢 Start a service: `service nginx start`
    - 🔴 Stop a service: `service nginx stop`
    - 📊 Check status: `service nginx status`

**Rebase a branch and explain when to use it vs merge**
    - **Rebase**: Moves your entire branch timeline so it starts at the tip of the updated main branch (`git rebase main`).
    - **When to use Rebase**: Use it on private feature branches to keep a clean, straight history line.
    - **When to use Merge**: Use it on public/shared branches to preserve the true history of when things happened


---

### Task 3: Quick-Fire Questions
Answer these from memory (no Googling). Then verify your answers:

1. What does `chmod 755 script.sh` do?
    It gives the **Owner** full permissions (read, write, execute) and gives **Group** and **Others** permission to only read and execute the script. This makes the file a runnable program
2. What is the difference between a process and a service?
    **Process**: Any single program or command running on your system right now (like running ls or opening a text editor).
    **Service**: A special process that runs quietly in the background all the time, waiting to do work (like a web server.
3. How do you find which process is using port 8080?
    By running the network status command: `sudo ss -tulpn | grep 8080` or `sudo netstat -tulpn | grep 8080`
4. What does `set -euo pipefail` do in a shell script?
    IT is a safety guard that stops your script instantly if a command fails (`-e`), if you use an unmade variable (`-u`), or if any piped command fails (`-o pipefail`).
5. What is the difference between `git reset --hard` and `git revert`?
    `git reset --hard`: Erases history. It rolls you back in time and destroys all uncommitted changes.
    `git revert`: Protects history. It creates a brand new commit that safely undoes the mistakes of an old commit
6. What branching strategy would you recommend for a team of 5 developers shipping weekly?
    **GitHub Flow**. It is simple, keeps the team fast, uses short-lived feature branches, and relies on Pull Requests to review code before shipping it every week
7. What does `git stash` do and when would you use it?
    It temporarily hides your dirty, unfinished code changes to give you a clean workspace. You use it when you need to emergency-switch to another branch without losing your current progress.
8. How do you schedule a script to run every day at 3 AM?
    You add this line to your `crontab -e` file:
    ```text
    0 3 * * * /path/to/script.sh
    ```
9. What is the difference between `git fetch` and `git pull`?
    `git fetch:` Only downloads the latest changes from GitHub to your computer. It does not touch your actual working files.
    `git pull`: Downloads the changes and instantly merges them into your current working files (fetch + merge).
10. What is LVM and why would you use it instead of regular partitions?
    **Logical Volume Manager** (LVM) is a flexible disk tool. You use it instead of standard partitions because it lets you shrink, grow, or combine multiple hard drives into one storage pool without turning off your system.

---

### Task 4: Organize Your Work
1. Make sure all your daily submissions (day-1 through day-27) are committed and pushed. **Yes**
2. Check that your `git-commands.md` is up to date: **Yes**
3. Check that your shell scripting cheat sheet is complete: **Yes**
4. Verify your GitHub profile and repos are clean (from Day 27): **Yes**

---

### Task 5: Teach It Back
Topics to teach from.
Examples:
- Explain Git branching to a non-developer
- Explain file permissions to a new Linux user
- Explain what a crontab is and why sysadmins use it

Teaching is the best test of understanding.

##### 🍕 Teaching Git Branching (Like a Master Chef)

Imagine you run a famous pizza restaurant, and you have a secret recipe that everyone loves. This perfect recipe is your **"main branch."**

One day, you want to try adding spicy honey to the pizza. Instead of messing up the actual sauce in the main kitchen, you take a small bowl of sauce over to a side table. This side table is your new **"branch."** 

On your side table, you can experiment, add toppings, and taste-test without ruining the dinner service for your real customers. 

If the new spicy honey pizza tastes amazing, you pour that side bowl back into the main pot so everyone can eat it. In Git, we call this a **"merge."** If it tastes terrible, you just wash the side bowl out and forget it ever happened! Your main recipe stays safe the whole time.

