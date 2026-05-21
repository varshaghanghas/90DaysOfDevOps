# Day 06 - Linux Fundamentals: Read and Write Text Files

# Introduction

In Linux, almost everything is treated as a file:
- Logs
- Configurations
- Scripts
- Application output
- Server settings

As a DevOps engineer, you will constantly create, edit, read, and monitor files.

This practice covers the most important beginner file handling commands:
- `touch`
- `echo`
- `cat`
- `head`
- `tail`
- `tee`

---

# Step 1 - Check Current Directory

Before creating files, always know where you are.

## Command

```bash
pwd
```

## Explanation

`pwd` stands for:

```text
Print Working Directory
```

It shows your current location in the Linux filesystem.

## Example Output

```text
/home/ubuntu/day-06
```

---

# Step 2 - List Existing Files

## Command

```bash
ls
```

## Explanation

`ls` displays files and folders inside the current directory.

This helps you confirm whether a file already exists.

---

# Step 3 - Create an Empty File

## Command

```bash
touch notes.txt
```

## Explanation

The `touch` command creates an empty file.

If the file already exists, it updates the timestamp instead of creating a new file.

## Verify File Creation

```bash
ls
```

## Expected Output

```text
notes.txt
```

---

# Step 4 - Write Content into File

## Command

```bash
echo "Linux is important for DevOps" > notes.txt
```

## Explanation

### `echo`
Displays text in terminal.

### `>`
Redirects output into a file.

This command:
- Writes text into `notes.txt`
- Removes old content if file already contains data

## Important Concept

`>` = overwrite

Be careful because existing data will be replaced.

---

# Step 5 - Read File Content

## Command

```bash
cat notes.txt
```

## Explanation

`cat` displays complete file content in terminal.

## Expected Output

```text
Linux is important for DevOps
```

---

# Step 6 - Append More Data

## Command

```bash
echo "Linux commands improve automation skills" >> notes.txt
echo "DevOps engineers work with logs daily" >> notes.txt
```

## Explanation

`>>` appends content instead of replacing it.

## Difference Between `>` and `>>`

| Symbol | Meaning |
|---|---|
| `>` | Overwrite file |
| `>>` | Append to file |

---

# Step 7 - View Updated File

## Command

```bash
cat notes.txt
```

## Expected Output

```text
Linux is important for DevOps
Linux commands improve automation skills
DevOps engineers work with logs daily
```

---

# Step 8 - Read First Few Lines

## Command

```bash
head notes.txt
```

## Explanation

`head` displays the first 10 lines by default.

Useful when:
- Reading large log files
- Checking file headers
- Verifying initial content

## Read Specific Number of Lines

```bash
head -n 2 notes.txt
```

## Expected Output

```text
Linux is important for DevOps
Linux commands improve automation skills
```

---

# Step 9 - Read Last Few Lines

## Command

```bash
tail notes.txt
```

## Explanation

`tail` displays last 10 lines by default.

Very important for DevOps because:
- Logs constantly update
- Errors usually appear at the bottom
- Monitoring systems use tail frequently

## Read Specific Number of Lines

```bash
tail -n 2 notes.txt
```

## Expected Output

```text
Linux commands improve automation skills
DevOps engineers work with logs daily
```

---

# Step 10 - Monitor Live File Updates

## Command

```bash
tail -f notes.txt
```

## Explanation

`-f` means:

```text
follow
```

This command continuously watches file changes in real time.

Used heavily for:
- Application logs
- Server monitoring
- Debugging production issues

## Stop Monitoring

Press:

```text
CTRL + C
```

---

# Step 11 - Use tee Command

## Command

```bash
echo "tee command helps write and display output" | tee -a notes.txt
```

## Explanation

`tee` does two things:
1. Displays output on terminal
2. Writes output into a file

### `-a`
Means append mode.

Without `-a`, existing content gets overwritten.

---

# Step 12 - Final File Output

## Command

```bash
cat notes.txt
```

## Final Expected Output

```text
Linux is important for DevOps
Linux commands improve automation skills
DevOps engineers work with logs daily
tee command helps write and display output
```

---

# Real DevOps Usage

These commands are used daily in DevOps work.

## Examples

### Checking Application Logs

```bash
tail -f app.log
```

### Creating Configuration Files

```bash
touch nginx.conf
```

### Writing Deployment Notes

```bash
echo "Deployment successful" >> deploy.log
```

### Monitoring CI/CD Output

```bash
cat pipeline.log
```

---

# Common Beginner Mistakes

## Mistake 1 - Accidentally Overwriting Files

Wrong:

```bash
echo "new data" > notes.txt
```

This deletes previous content.

Use:

```bash
echo "new data" >> notes.txt
```

when you want to keep old data.

---

## Mistake 2 - Using cat on Huge Files

Large logs can flood terminal.

Instead use:
- `head`
- `tail`
- `less`

---

# What I Learned

- How to create files using `touch`
- Difference between overwrite and append
- How to read files using `cat`
- How to inspect files using `head` and `tail`
- How to monitor live file changes
- How `tee` works
- Why file handling is important in DevOps

---

# Practice Tasks I did

## Task 1

Create a file named:

```text
devops.txt
```

Add 5 lines using append mode.

---

## Task 2

Display:
- first 3 lines
- last 2 lines

---

## Task 3

Use `tee` to append one extra line.

---

# Conclusion

Linux file handling is a foundational DevOps skill.

Almost every DevOps tool:
- writes logs
- reads configs
- stores outputs
- updates files

Strong Linux fundamentals make advanced DevOps tools much easier to learn later.