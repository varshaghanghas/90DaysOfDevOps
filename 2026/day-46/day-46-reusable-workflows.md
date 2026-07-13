# Day 46 – Reusable Workflows & Composite Actions

**Why do we use them?**

As projects grow, GitHub Actions workflows often contain the same code in multiple repositories or multiple workflows. Instead of copying and pasting the same logic everywhere, GitHub provides two ways to reuse code:

- Reusable Workflows → Reuse an entire workflow or job.
- Composite Actions → Reuse a group of steps as one step.

The biggest difference is:
- Reusable Workflow = Reuse complete jobs or pipelines
- Composite Action = Reuse a collection of steps

## Reusable Workflows
Think of a reusable workflow as a ready-made pipeline that other workflows can call.

Instead of creating the same CI/CD pipeline in every repository, you write it once and reuse it wherever needed.

**Trigger**
Reusable workflows use:

```yml
on:
  workflow_call:
```

Location: `.github/workflows/`

They are stored just like normal workflow files.

**Best Use Cases:**
- Standard CI pipelines
- Company-wide deployment process
- Security scanning
- Compliance checks
- Multi-job workflows
- Different runners for different jobs

**Advantages**
- Reuse entire pipelines
- Can contain multiple jobs
- Supports matrix builds
- Supports environments
- Better secret management
- Each job can run on a different runner

**Example**
Instead of writing:

```text
Build
↓

Test
↓

Security Scan
↓

Deploy
```

inside every repository,
create it once and simply call it from other repositories.

## Composite Actions
Composite Actions are much smaller.
Instead of reusing an entire workflow, they package several steps into one reusable action.
Think of them like creating your own custom GitHub Action.

**Trigger**
Defined using:

```yml
runs:
  using: composite
```

Location: 
Stored inside a folder containing: `action.yml`

For example: 
```text
.github/actions/setup-node/
    action.yml
```

or inside a separate GitHub repository.

**Best Use Cases:**
- Install dependencies
- Configure tools
- Run common shell scripts
- Code formatting
- Linting
- Small automation tasks

**Advantages:**
- Easy to reuse
- Keeps workflows clean
- Great for repeated setup tasks
- Can be shared publicly on GitHub Marketplace

**Need to reuse an entire workflow or multiple jobs? → Use a Reusable Workflow.**
**Need to reuse a group of repeated steps? → Use a Composite Action.**

**Simple memory trick:**
- Reusable Workflow = Reuse Jobs
- Composite Action = Reuse Steps

---

### Task 1: Understand `workflow_call`

Practice Repo: [github-actions-practice](https://github.com/varshaghanghas/github-actions-practice)

Before writing any code, research and answer in your notes:
1. What is a **reusable workflow**?

Think of a reusable workflow as a ready-made pipeline that other workflows can call.

Instead of creating the same CI/CD pipeline in every repository, you write it once and reuse it wherever needed.

2. What is the `workflow_call` trigger?

**Trigger**
Reusable workflows use:

```yml
on:
  workflow_call:
```

3. How is calling a reusable workflow different from using a regular action (`uses:`)?
- **Scope & Level:** A regular action is called at the **Step level** inside a job. A reusable workflow is called at the Job level—it completely replaces or defines a job block.
- **Infrastructure Management:** A regular action inherits the machine runner (`runs-on`) of the job it sits in. A reusable workflow manages its own runners, environments, and concurrency rules inside its own file.
- **Syntax difference:**
    - Regular Action: Placed inside `jobs.<job_id>.steps[*].uses`
    - Reusable Workflow: Placed inside `jobs.<job_id>.uses` (no steps block below it)

4. Where must a reusable workflow file live?

Workflow Location: `.github/workflows/`

They are stored just like normal workflow files.

**Best Use Cases:**
- Standard CI pipelines
- Company-wide deployment process
- Security scanning
- Compliance checks
- Multi-job workflows
- Different runners for different jobs

**Advantages**
- Reuse entire pipelines
- Can contain multiple jobs
- Supports matrix builds
- Supports environments
- Better secret management
- Each job can run on a different runner

**Example**
Instead of writing:

```text
Build
↓

Test
↓

Security Scan
↓

Deploy
```

inside every repository,
create it once and simply call it from other repositories.

---

### Task 2: Create Your First Reusable Workflow
Create `.github/workflows/reusable-build.yml`:
1. Set the trigger to `workflow_call`
2. Add an `inputs:` section with:
   - `app_name` (string, required)
   - `environment` (string, required, default: `staging`)
3. Add a `secrets:` section with:
   - `docker_token` (required)
4. Create a job that:
   - Checks out the code
   - Prints `Building <app_name> for <environment>`
   - Prints `Docker token is set: true` (never print the actual secret)

`.github/workflows/caller-workflow.yml`:

```yml
name: Reusable Build Pipeline

# 1. Set the trigger to workflow_call
on:
  workflow_call:
    # 2. Add an inputs section
    inputs:
      app_name:
        description: 'The name of the application'
        type: string
        required: true
      environment:
        description: 'Target deployment environment'
        type: string
        required: true
        default: 'staging'
    # 3. Add a secrets section
    secrets:
      docker_token:
        description: 'Authentication token for Docker registry'
        required: true

jobs:
  # 4. Create a job that executes the build steps
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Code
        uses: actions/checkout@v4

      - name: Print Details
        run: |
          echo "Building ${{ inputs.app_name }} for ${{ inputs.environment }}"

      - name: Check Secret Availability
        # Conditional validation to safely check if the token exists without printing it
        run: |
          if [ -n "${{ secrets.docker_token }}" ]; then
            echo "Docker token is set: true"
          else
            echo "Docker token is set: false"
            exit 1
          fi
```

**Verify:** This file alone won't run — it needs a caller. That's next.
We create `.github/workflows/caller-workflow.yml` next.
---

### Task 3: Create a Caller Workflow
Create `.github/workflows/caller-workflow.yml`:
1. Trigger on push to `main`
2. Add a job that uses your reusable workflow:
   ```yaml
   jobs:
     build:
       uses: ./.github/workflows/reusable-build.yml
       with:
         app_name: "my-web-app"
         environment: "production"
       secrets:
         docker_token: ${{ secrets.DOCKER_TOKEN }}
   ```
3. Push to `main` and watch it run

Caller workflow: `caller-workflow.yml`

```yml
name: Trigger App Build

on:
  push:
    branches: [ main ]

jobs:
  # Call the reusable workflow at the job level
  run-reusable-build:
    uses: ./.github/workflows/reusable-build.yml
    with:
      app_name: "my-web-app"
      environment: "production"
    secrets: inherit
    # secrets:
    #   docker_token: ${{ secrets.MY_REPO_DOCKER_SECRET }}
```
**Verify:** In the Actions tab, do you see the caller triggering the reusable workflow? Click into the job — can you see the inputs printed?

![Output](./img/picture1.png)

![Output](./img/picture2.png)

---

### Task 4: Add Outputs to the Reusable Workflow
Extend `reusable-build.yml`:
1. Add an `outputs:` section that exposes a `build_version` value
2. Inside the job, generate a version string (e.g., `v1.0-<short-sha>`) and set it as output
3. In your caller workflow, add a second job that:
   - Depends on the build job (`needs:`)
   - Reads and prints the `build_version` output

Updated `reusable-build.yml`:

```yml
name: Reusable Build Pipeline

# 1. Set the trigger to workflow_call
on:
  workflow_call:
    # 2. Add an inputs section
    inputs:
      app_name:
        description: 'The name of the application'
        type: string
        required: true
      environment:
        description: 'Target deployment environment'
        type: string
        required: true
        default: 'staging'
    # 3. Add a secrets section
    secrets:
      docker_token:
        description: 'Authentication token for Docker registry'
        required: true

    # day 46 task 4: Declare the workflow-level outputs
    outputs:
      build_version:
        description: "The generated version string"
        value: ${{ jobs.build.outputs.version_string }} # Maps the job output up to the workflow

jobs:
  # 4. Create a job that executes the build steps
  build:
    runs-on: ubuntu-latest
    # day 46 task 4.2. Map the step output to the job output
    outputs:
      version_string: ${{ steps.gen_version.outputs.version }}
    steps:
      - name: Checkout Code
        uses: actions/checkout@v4

      - name: Generate Version String
        id: gen_version # Needed so other steps/jobs can reference this specific step
        run: |
          # Grab the first 7 characters of the commit SHA
          SHORT_SHA=$(echo "${{ github.sha }}" | cut -c1-7)
          VERSION="v1.0-${SHORT_SHA}"
          
          echo "Generated version: $VERSION"
          # Save it to the official GitHub environment file
          echo "version=$VERSION" >> $GITHUB_OUTPUT

      - name: Print Details
        run: |
          echo "Building ${{ inputs.app_name }} for ${{ inputs.environment }}"

      - name: Check Secret Availability
        # Conditional validation to safely check if the token exists without printing it
        run: |
          if [ -n "${{ secrets.docker_token }}" ]; then
            echo "Docker token is set: true"
          else
            echo "Docker token is set: false"
            exit 1
          fi
```

Updated `.github/workflows/caller-workflow.yml`:

```yml
name: Trigger App Build

on:
  push:
    branches: [ main ]

jobs:
  # Call the reusable workflow at the job level
  run-reusable-build:
    uses: ./.github/workflows/reusable-build.yml
    with:
      app_name: "my-web-app"
      environment: "production"
    secrets: inherit
    # secrets:
    #   docker_token: ${{ secrets.MY_REPO_DOCKER_SECRET }}

  # Day 46- task 3: Run a downstream task that uses the output
  deploy-app:
    runs-on: ubuntu-latest
    needs: run-reusable-build # <-- CRITICAL: Ensures this job waits for the build to finish
    steps:
      - name: Print Version From Reusable Workflow
        run: |
          # Reference pattern: needs.<job_id>.outputs.<output_name>
          echo "The version retrieved from the build job is: ${{ needs.run-reusable-build.outputs.build_version }}"
```

**Verify:** Does the second job print the version from the reusable workflow?

![Output](./img/picture3.png)

---

### Task 5: Create a Composite Action
Create a **custom composite action** in your repo at `.github/actions/setup-and-greet/action.yml`:
1. Define inputs: `name` and `language` (default: `en`)
2. Add steps that:
   - Print a greeting in the specified language
   - Print the current date and runner OS
   - Set an output called `greeted` with value `true`
3. Use the composite action in a new workflow with `uses: ./.github/actions/setup-and-greet`

`.github/actions/setup-and-greet/action.yml`:

```yml
name: 'Setup and Greet'
description: 'Greets users in a specified language and logs runner metadata'

# 1. Define inputs
inputs:
  name:
    description: 'Name of the person to greet'
    required: true
  language:
    description: 'Language code (e.g., en, es)'
    required: true
    default: 'en'

# 3. Define the outputs
outputs:
  greeted:
    description: 'Confirmation that the greeting was processed'
    value: 'true'

# Tell GitHub this is a step-level composite action
runs:
  using: 'composite'
  steps:
    # 2. Add step to print greeting in the specified language
    - name: Print Greeting
      run: |
        if [ "${{ inputs.language }}" = "es" ]; then
          echo "¡Hola, ${{ inputs.name }}!"
        elif [ "${{ inputs.language }}" = "fr" ]; then
          echo "Bonjour, ${{ inputs.name }}!"
        else
          echo "Hello, ${{ inputs.name }}!"
        fi
      shell: bash # <-- MANDATORY for every step in a composite action

    # 2. Add step to print current date and runner OS
    - name: Log Metadata
      run: |
        echo "Current Date/Time: $(date)"
        echo "Runner Operating System: ${{ runner.os }}"
      shell: bash

```

Caller workflow `test-composite.yml`

```yml
name: Test Composite Action

on:
  push:
    branches: [ main ]
  workflow_dispatch: # <-- ADD THIS LINE to enable manual triggering from the UI

jobs:
  greet-job:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Code
        uses: actions/checkout@v4

      - name: Run Setup and Greet Action
        id: greet_step
        uses: ./.github/actions/setup-and-greet
        with:
          name: "Alex"
          language: "es"

      - name: Verify Output
        run: |
          echo "Was greeting processed? ${{ steps.greet_step.outputs.greeted }}"

```

**Verify:** Does your custom action run and print the greeting?

![Output](./img/picture4.png)

---

### Task 6: Reusable Workflow vs Composite Action
Fill this in your notes:

| | Reusable Workflow | Composite Action |
|---|---|---|
| Triggered by | `workflow_call` | `uses:` in a step |
| Can contain jobs? | Yes (one or many entire jobs) | No (sequential steps only) |
| Can contain multiple steps? | Yes (inside its defined jobs) | Yes (combines multiple steps into one) |
| Lives where? | Must live in `.github/workflows/` | Root of any directory (uses `action.yml`) |
| Can accept secrets directly? | Yes (via `secrets:` or `secrets: inherit`) | No (must pass them manually as regular inputs) |
| Best for | Standardizing entire pipelines across an org | Script cleanup & packaging repetitive steps |

#### Takeaway
- **The "Job" Boundary**: Think of a Reusable Workflow as an orchestrator. Because it handles jobs, it can configure its own environments, matrices, and runners. A Composite Action is just a **macro pack**—it has to inherit whatever runner the caller job is already sitting on.
- **Secret Visibility**: Reusable Workflows are fully enterprise-secure. They have native compliance features to map secrets smoothly. Composite actions treat data like strings—they have no inherent concept of context secrets, meaning you have to explicitly feed them via `with:` fields.

---

## Hints
- Reusable workflows must be in `.github/workflows/` directory
- Caller syntax: `uses: ./.github/workflows/file.yml` (same repo) or `uses: org/repo/.github/workflows/file.yml@main` (cross-repo)
- Composite action: `action.yml` with `runs: using: "composite"`
- Reusable workflow outputs: `on: workflow_call: outputs: name: value: ${{ jobs.job-id.outputs.name }}`
- A reusable workflow can be called by at most 20 unique caller workflows in a single run
