# Day 11 - Linux File Ownership & Group Management

## What I Learned

Today I practiced Linux file ownership and group management commands.

### Topics Covered
- Understanding file owners and groups
- Using `chown` command
- Using `chgrp` command
- Changing both owner and group together
- Verifying ownership using `ls -l`

---

# Task 1: Understanding Ownership

## Command Used
```bash
ls -l
```

### File Format
```bash
-rw-r--r-- 1 owner group size date filename
```

### Difference Between Owner and Group

- **Owner** → The individual user who controls the file
- **Group** → A collection of users who can access the file based on permissions

The owner has primary control over the file, while the group helps multiple users share access without changing ownership.

## Snapshot
Output:

![List](./img/Picture1.png)

---

# Task 2: Basic chown Operations

## Commands Practiced
```bash
vim devops-file.txt

ls -l devops-file.txt

sudo chown tokyo devops-file.txt

sudo chown berlin devops-file.txt

ls -l
```

### Learning
- `chown` is used to change file ownership
- Ownership changes can be verified using `ls -l`

## Snapshot
Output:

![List](./img/Picture2.png)

---

# Task 3: Basic chgrp Operations

## Commands Practiced
```bash
vim team-notes.txt

sudo groupadd heist-team

chgrp heist-team team-notes.txt

ls -l
```

## Snapshot
group while file created:

![List](./img/Picture3.png)


File permission after group change:

![List](./img/Picture4.png)

### Learning
- `groupadd` creates a new group
- `chgrp` changes the group ownership of a file

---

# Task 4: Combined Owner & Group Change

## Commands Practiced
```bash
vim project-config.yaml

sudo chown professor:heist-team project-config.yaml

mkdir app-logs

sudo chown berlin:heist-team app-logs

ls -l
```

## Snapshot
group while file created:

![List](./img/Picture5.png)

### Learning
- `chown owner:group` changes both owner and group together
- Ownership can also be applied to directories

---

# Commands Learned

```bash
ls -l
chown
chgrp
groupadd
mkdir
vim
```

# Conclusion

Today I learned how Linux file ownership and group permissions work.  
I practiced changing owners and groups using `chown` and `chgrp`, and verified the changes using `ls -l`.