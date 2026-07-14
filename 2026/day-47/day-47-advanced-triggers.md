# Day 47 – Advanced Triggers: PR Events, Cron Schedules & Event-Driven Pipelines

## Task
You've used `push` and basic `pull_request` triggers. But GitHub Actions supports **dozens of event types** — today you go deep into PR lifecycle events, scheduled cron jobs, and chaining workflows together.

---

## Challenge Tasks

### Task 1: Pull Request Event Types
Create `.github/workflows/pr-lifecycle.yml` that triggers on `pull_request` with **specific activity types**:
1. Trigger on: `opened`, `synchronize`, `reopened`, `closed`
2. Add steps that:
   - Print which event type fired: `${{ github.event.action }}`
   - Print the PR title: `${{ github.event.pull_request.title }}`
   - Print the PR author: `${{ github.event.pull_request.user.login }}`
   - Print the source branch and target branch
3. Add a conditional step that only runs when the PR is **merged** (closed + merged = true)

`.github/workflows/pr-lifecycle.yml`:

```yml
name: Advanced PR Lifecycle

on:
  pull_request:
    types: [opened, synchronize, reopened, closed]

jobs:
  inspect-pr-event:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Code
        uses: actions/checkout@v4

      - name: Log PR Metadata
        run: |
          echo "=================== PR METADATA ==================="
          echo "Event Action Fired  : ${{ github.event.action }}"
          echo "PR Title            : ${{ github.event.pull_request.title }}"
          echo "PR Author           : ${{ github.event.pull_request.user.login }}"
          echo "Source Branch (Head): ${{ github.event.pull_request.head.ref }}"
          echo "Target Branch (Base): ${{ github.event.pull_request.base.ref }}"
          echo "==================================================="

      - name: Execute Post-Merge Operations
        if: github.event.action == 'closed' && github.event.pull_request.merged == true
        run: |
          echo "Status: Confirmed Merged!"
          echo "Executing downstream tasks for merged PR #${{ github.event.pull_request.number }}..."
```

Test it: create a PR, push an update to it, then merge it. Watch the workflow fire each time with a different event type.

After push (with new branch `pr-triggers`):

![Output](./img/picture1.png)

Created Pull Request and Merge Pull requrest. After pull request mergered:

![Output](./img/picture2.png)

---

### Task 2: PR Validation Workflow
Create `.github/workflows/pr-checks.yml` — a real-world PR gate:
1. Trigger on `pull_request` to `main`
2. Add a job `file-size-check` that:
   - Checks out the code
   - Fails if any file in the PR is larger than 1 MB
3. Add a job `branch-name-check` that:
   - Reads the branch name from `${{ github.head_ref }}`
   - Fails if it doesn't follow the pattern `feature/*`, `fix/*`, or `docs/*`
4. Add a job `pr-body-check` that:
   - Reads the PR body: `${{ github.event.pull_request.body }}`
   - Warns (but doesn't fail) if the PR description is empty

`.github/workflows/pr-checks.yml`:

```yml
name: PR Validation Gate

on:
  pull_request:
    branches:
      - main

jobs:
  file-size-check:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Code
        uses: actions/checkout@v4
        with:
          fetch-depth: 0 # Fetches full history to compare commits accurately

      - name: Validate File Sizes
        run: |
          echo "Scanning modified files for size limits (>1MB)..."
          
          # Get list of changed files between the PR branch and base branch
          CHANGED_FILES=$(git diff --name-only origin/${{ github.base_ref }}...HEAD)
          
          LARGE_FILES_FOUND=0
          
          for file in $CHANGED_FILES; do
            if [ -f "$file" ]; then
              # Get file size in bytes
              FILE_SIZE=$(stat -c%s "$file")
              # 1 MB = 1048576 bytes
              if [ "$FILE_SIZE" -gt 1048576 ]; then
                echo "ERROR: File '$file' exceeds the 1MB limit ($(NUM=$(($FILE_SIZE/1024)); echo $NUM) KB)."
                LARGE_FILES_FOUND=$((LARGE_FILES_FOUND + 1))
              fi
            fi
          done
          
          if [ "$LARGE_FILES_FOUND" -gt 0 ]; then
            exit 1
          fi
          echo "All modified files are within acceptable size limits."

  branch-name-check:
    runs-on: ubuntu-latest
    steps:
      - name: Validate Branch Prefix
        run: |
          BRANCH_NAME="${{ github.head_ref }}"
          echo "Evaluating branch name: $BRANCH_NAME"
          
          if [[ "$BRANCH_NAME" =~ ^(feature/|fix/|docs/) ]]; then
            echo "Branch naming convention matched."
          else
            echo "ERROR: Branch name does not match required conventions."
            echo "Allowed prefixes: feature/*, fix/*, docs/*"
            exit 1
          fi

  pr-body-check:
    runs-on: ubuntu-latest
    steps:
      - name: Inspect PR Body
        env:
          PR_BODY: ${{ github.event.pull_request.body }}
        run: |
          # Strip spaces and lines to check actual content presence
          CLEANED_BODY=$(echo "$PR_BODY" | tr -d '[:space:]')
          
          if [ -z "$CLEANED_BODY" ]; then
            echo "::warning::The description of this Pull Request is completely empty. Please add context."
          else
            echo "PR description contains documentation text."
          fi
```

**Verify:** Open a PR from a badly named branch — does the check fail?

After `push` if you check the Actions-> All workflows, we won't see the newly added workflow.
- After pull merge the workflow fails.

![Output](./img/picture3.png)

![Output](./img/picture5.png)

Now, Lets try creating new branch with `fix/pr-checks` and repush and pull request merge:

![Output](./img/picture6.png)

![Output](./img/picture7.png)

![Output](./img/picture8.png)

---

### Task 3: Scheduled Workflows (Cron Deep Dive)
Create `.github/workflows/scheduled-tasks.yml`:
1. Add a `schedule` trigger with cron: `'30 2 * * 1'` (every Monday at 2:30 AM UTC)
2. Add **another** cron entry: `'0 */6 * * *'` (every 6 hours)
3. In the job, print which schedule triggered using `${{ github.event.schedule }}`
4. Add a step that acts as a **health check** — curl a URL and check the response code

`.github/workflows/scheduled-tasks.yml`:

```yml
name: Scheduled Infrastructure Tasks

on:
  schedule:
    - cron: '30 2 * * 1'   # Every Monday at 02:30 UTC
    - cron: '0 */6 * * *'  # Every 6 hours (00:00, 06:00, 12:00, 18:00 UTC)
  workflow_dispatch:       # Allows manual testing from the Actions UI

jobs:
  maintenance-and-health:
    runs-on: ubuntu-latest
    steps:
      - name: Identify Trigger Source
        run: |
          if [ "${{ github.event_name }}" = "schedule" ]; then
            echo "Triggered by CRON Schedule Expression: ${{ github.event.schedule }}"
          else
            echo "Triggered Manually via Workflow Dispatch"
          fi

      - name: Service Health Check
        run: |
          echo "Initiating production endpoint health check..."
          
          # Target a public test endpoint or insert your custom production URL
          URL="https://httpbin.org"
          
          # Execute curl, capture HTTP status code silently
          STATUS_CODE=$(curl -s -o /dev/null -w "%{http_code}" "$URL")
          echo "Response Status Code: $STATUS_CODE"
          
          if [ "$STATUS_CODE" -ne 200 ]; then
            echo "ERROR: Health check failed with status code $STATUS_CODE"
            exit 1
          fi
          
          echo "System health check passed successfully."
```

Write in your notes:
- The cron expression for: every weekday at 9 AM IST
   - **Expression**: `30 3 * * 1-5`
   - **Calculation**: GitHub Actions schedules operate exclusively in Coordinated Universal Time (UTC). Indian Standard Time (IST) is 5 hours and 30 minutes ahead of UTC (\(*UTC + 5:30*\)). Subtracting 5.5 hours from 09:00 AM yields 03:30 AM UTC.

- The cron expression for: first day of every month at midnight
   - Expression: `0 0 1 * *`
   - Calculation: Minute `0`, Hour `0` (midnight), Day of Month `1`, Month `*` (every month), Day of Week `*` (any day).
- Why GitHub says scheduled workflows may be delayed or skipped on inactive repos
   - **Resource Contention (Peak Load Delays)**: 
      - Scheduled workflows run on GitHub's shared runner infrastructure.
      - Many developers schedule cron jobs at common times like the start of every hour (`0 * * * *`) or midnight (`0 0 * * *`).
      - When thousands of workflows start at the same time, GitHub's runners become heavily loaded.
      - Because of this, scheduled workflows may not start exactly on time.
      - Delays can range from a few minutes to more than an hour during busy periods.
      - If precise timing is important, avoid scheduling jobs at popular times. Using less common minutes (for example, `17 * * * *`) can help reduce delays.
   - **Inactive Repository Policy (Workflow Suspension)**:
      - GitHub automatically pauses scheduled cron workflows if a repository has no activity for 60 consecutive days.
      - This applies to both public and private repositories.
      - The purpose is to avoid wasting GitHub's runner resources.
      - Scheduled workflows remain disabled until there is new activity in the repository.
      - You can reactivate them by:
         - Pushing a new commit.
         - Updating a branch.
         - Manually triggering a workflow from the GitHub UI or via the GitHub API.

Scheduled workflows are reliable for routine automation, but they are **not guaranteed to run at the exact scheduled time**, and they can be **automatically suspended in inactive repositories**.

**Important:** Also add `workflow_dispatch` so you can test it manually without waiting for the schedule.

```yml
on:
  schedule:
    - cron: '30 2 * * 1'   # Every Monday at 02:30 UTC
    - cron: '0 */6 * * *'  # Every 6 hours (00:00, 06:00, 12:00, 18:00 UTC)
  workflow_dispatch:       # Allows manual testing from the Actions UI
```

---

### Task 4: Path & Branch Filters
Create `.github/workflows/smart-triggers.yml`:
1. Trigger on push but **only** when files in `src/` or `app/` change:
   ```yaml
   on:
     push:
       paths:
         - 'src/**'
         - 'app/**'
   ```
2. Add `paths-ignore` in a second workflow that skips runs when only docs change:
   ```yaml
   paths-ignore:
     - '*.md'
     - 'docs/**'
   ```
3. Add branch filters to only trigger on `main` and `release/*` branches
4. Test it: push a change to a `.md` file — does the workflow skip?

`.github/workflows/smart-triggers.yml`:

```yml
name: Core Source CI

on:
  push:
    branches:
      - main
      - 'release/*'
    paths:
      - 'src/**'
      - 'app/**'

jobs:
  build-and-test:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Code
        uses: actions/checkout@v4

      - name: Build Codebase
        run: |
          echo "Changes detected in src/ or app/ on branch: ${{ github.ref_name }}"
          echo "Executing application builds and tests..."
```

`.github/workflows/smart-triggers-docs-ignore.yml`:

```yml
name: Global Code Verification

on:
  push:
    branches:
      - main
      - 'release/*'
    paths-ignore:
      - '**.md'
      - 'docs/**'

jobs:
  validate-infrastructure:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Code
        uses: actions/checkout@v4

      - name: Verify Configurations
        run: |
          echo "Non-documentation update verified."
          echo "Running infrastructure configuration checks..."
```

Now when we push the workflow only the `.github/workflows/smart-triggers-docs-ignore.yml` run as we didn't made any change in `src/` or `app/`.

![Output](./img/picture9.png)

Now I make a change in `app/` and push changes and now both the workflow run.

![Output](./img/picture10.png)

Write in your notes: When would you use `paths` vs `paths-ignore`?

|  | Rule Type | Primary UseCase | Risk Factor |
|--|--|--|--|
| `paths` | Inclusionary (Allow-list) | Use when a workflow belongs to a specific, isolated component (e.g., a Microservice or Frontend SPA inside a monorepo). It only runs when targeted code is modified. | If a global config change (like updating a root `.gitignore` or `Dockerfile`) breaks that component, this workflow won't run to catch it. |
| `paths-ignore` | Exclusionary (Block-list) | Use for general repository infrastructure pipelines (Linter, Security Scans, General Testing). It ensures the workflow runs for *everything except* known safe files like documentation. | If you add a new file extension or folder to your project that does not need testing, you must manually update this block list to prevent waste. |

Use `paths` to optimize speed and cost for specialized components. Use `paths-ignore` to protect system integrity on global frameworks.

---

### Task 5: `workflow_run` — Chain Workflows Together
Create two workflows:
1. `.github/workflows/tests.yml` — runs tests on every push
2. `.github/workflows/deploy-after-tests.yml` — triggers **only after** `tests.yml` completes successfully:
   ```yaml
   on:
     workflow_run:
       workflows: ["Run Tests"]
       types: [completed]
   ```
3. In the deploy workflow, add a conditional:
   - Only proceed if the triggering workflow **succeeded** (`${{ github.event.workflow_run.conclusion == 'success' }}`)
   - Print a warning and exit if it failed

`.github/workflows/tests.yml`: It acts as the upstream catalyst for your deployment pipeline. Notice that the `name:` matches the name string targeted by your downstream configuration.

```yml
name: Run Tests

on:
  push:
    branches:
      - main

jobs:
  execute-tests:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Code
        uses: actions/checkout@v4

      - name: Execute Test Suite
        run: |
          echo "Running automated suite..."
          # Mocking a clean test passing execution
          exit 0

```

`.github/workflows/deploy-after-tests.yml`: This downstream pipeline runs automatically when `Run Tests` finishes. It uses a strict conditional check at the job level to verify the upstream execution state before taking action.

```yml
name: Conditional Deployment Chain

on:
  workflow_run:
    workflows: ["Run Tests"]
    types:
      - completed

jobs:
  evaluate-and-deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Inspect Upstream Conclusion
        run: |
          echo "Upstream Workflow ID: ${{ github.event.workflow_run.id }}"
          echo "Upstream Execution Conclusion: ${{ github.event.workflow_run.conclusion }}"

      - name: Check Failure State
        if: github.event.workflow_run.conclusion != 'success'
        run: |
          echo "::error::Upstream verification tests failed or were cancelled. Deploy aborted."
          exit 1

      - name: Execute Production Deployment
        if: github.event.workflow_run.conclusion == 'success'
        run: |
          echo "Confirmed Status: Success!"
          echo "Initiating cloud environment deployment sequences..."

```

**Verify:** Push a commit — does the test workflow run first, then trigger the deploy workflow?

**How the Workflow Runs:**
- **Push** your changes to the remote `main` branch.
- **Run Tests** starts automatically because it is triggered by the push event.
- After the testing workflow finishes, GitHub automatically starts the Conditional Deployment Chain workflow using the `workflow_run` trigger.
- The deployment workflow checks the final status of the test workflow before continuing.

![Output](./img/picture11.png)

![Output](./img/picture12.png)

**What Happens Next?**
- **If the tests pass**
   - The deployment workflow detects that the test workflow completed successfully.
   - The failure-check step is skipped.
   - The deployment process continues normally and prints the deployment success message.
- **If the tests fail**: For example, if you intentionally modify the test workflow to use `exit 1:`
   - The deployment workflow still starts because `workflow_run` is triggered whenever the previous workflow completes, regardless of its result.
   - The workflow checks the conclusion of the test run.
   - Since the result is not success, it logs a clear GitHub Actions error using `::error::`.
   - The workflow exits immediately, preventing any deployment from taking place.

The `workflow_run` trigger only works with workflows that exist on the repository's default branch (usually `main`).

---

### Task 6: `repository_dispatch` — External Event Triggers
1. Create `.github/workflows/external-trigger.yml` with trigger `repository_dispatch`
2. Set it to respond to event type: `deploy-request`
3. Print the client payload: `${{ github.event.client_payload.environment }}`
4. Trigger it using `curl` or `gh`:
   ```bash
   gh api repos/<owner>/<repo>/dispatches \
     -f event_type=deploy-request \
     -f client_payload='{"environment":"production"}'
   ```

`.github/workflows/external-trigger.yml`:

```yml
name: External Event Pipeline

on:
  repository_dispatch:
    types: [deploy-request]

jobs:
  handle-external-event:
    runs-on: ubuntu-latest
    steps:
      - name: Process Dispatch Payload
        run: |
          echo "================ EXTERNAL DISPATCH ================"
          echo "Event Type Received : ${{ github.event.action }}"
          echo "Target Environment  : ${{ github.event.client_payload.environment }}"
          echo "Triggered By User   : ${{ github.actor }}"
          echo "==================================================="

      - name: Dynamic Environment Deployment
        run: |
          ENV_TARGET="${{ github.event.client_payload.environment }}"
          echo "Initializing deployment sequence for environment: $ENV_TARGET"
```

- Run using `gh`:

```bash
gh api repos/varshaghanghas/github-actions-practice/dispatches \
  -f event_type=deploy-request \
  -F client_payload='{"environment":"local-testing"}'    # instead of `local-testing` we can use object to "local", "test", "staging" or "production".
```

- Using raw `curl`:

```yml
# curl -X POST \
#   -H "Accept: application/vnd.github+json" \
#   -H "Authorization: Bearer YOUR_PERSONAL_ACCESS_TOKEN" \
#   https://github.com<owner>/<repo>/dispatches \
#   -d '{"event_type": "deploy-request", "client_payload": {"environment": "production"}}'

cmd /c 'curl -X POST \
 -H "Accept: application/vnd.github+json" \
 -H "Authorization: Bearer YOUR_PERSONAL_ACCESS_TOKEN" \
 https://github.com -d "{\"event_type\": \"deploy-request\", \"client_payload\": {\"environment\": \"local-testing\"}}"'

```

**When would an external system (like a Slack bot or monitoring tool) trigger a pipeline?**
we use `repository_dispatch` when we want something outside of GitHub to pull the trigger on our workflows. Instead of waiting for a developer to push code or open a PR, an external tool sends a quick web signal (a webhook) to GitHub saying, "Hey, run this job right now, and here is some data to use."
most common real-world scenarios:
- Interactive ChatOps (Slack or Discord Bots)
   - **What happens**: You are chatting with your team in Slack and want to deploy the latest code to a test environment without opening your terminal or browser.
   - **The trigger**: You type something like `/deploy-app staging` in the chat channel. A Slack bot catches your message, builds the JSON payload, and shoots it over to GitHub to kick off the deployment pipeline automatically.
- Emergency Automated Rollbacks (Monitoring Tools)
   - **What happens**: Your team just launched a fresh update, but something breaks at 2:00 AM. Production servers start throwing bad errors, or the memory usage spikes.
   - **The trigger**: Monitoring platforms like Datadog, New Relic, or AWS CloudWatch catch the error spike immediately. Instead of waiting for a human to wake up and click buttons, the monitoring tool triggers a rollback workflow instantly to revert the code and protect live users.
- Content Publishing (Headless CMS)
   - **What happens**: A marketing writer finishes a blog post or edits a website page inside a tool like Contentful, Strapi, or WordPress. They click the green "Publish" button inside that app.
   - **The trigger**: The CMS platform doesn't know anything about code, but it fires a webhook to your repository. The GitHub workflow wakes up, grabs the new text, rebuilds your static website pages (using tools like Next.js or Gatsby), and deploys the fresh content to the live site.
- Base Image Updates (Container Registries)
   - **What happens**: Your application runs inside a Docker container built on top of a secure base operating system image (like Node or Ubuntu). The team managing that base image pushes a brand new security patch.
   - **The trigger**: The container registry (like Docker Hub or Amazon ECR) fires an update notification event. Your repository catches it and automatically spins up a pipeline to rebuild and re-test your application against the newest, safest base image.


---

### Matrix Comparison

| Trigger Type | Best Used For | Primary Advantage | Main Limitation |
|---|---|---|---|
| PR Events | Code review, pre-merge linting, unit testing | Catches bugs early | Increases developer wait times |
| Cron Schedules | Nightly security scans, database backups | Predictable resource usage | Does not react to real-time changes |
| Event-Driven | ChatOps, deployment rollbacks, cloud alerts | Highly decoupling systems | Requires complex security handling |

---

## Hints
- PR merge check: `if: github.event.pull_request.merged == true`
- Cron syntax: `minute hour day-of-month month day-of-week`
- Scheduled workflows only run on the **default branch**
- `workflow_run` gives you access to the triggering workflow's conclusion and artifacts
- `repository_dispatch` requires a personal access token with `repo` scope
- Path filters use glob patterns — `**` matches nested directories

---

## Documentation
Create `day-47-advanced-triggers.md` with:
- Your workflow YAML files
- The cron expressions from Task 3
- Screenshot of the PR checks running on a pull request
- Explanation of `workflow_run` vs `workflow_call` in your own words

---

## Submission
1. Add `day-47-advanced-triggers.md` to `2026/day-47/`
2. Commit and push to your fork

---

## Learn in Public
Share your PR validation workflow on LinkedIn — automated PR gates are a real DevOps flex.

`#90DaysOfDevOps` `#DevOpsKaJosh` `#TrainWithShubham`

Happy Learning!
**TrainWithShubham**
