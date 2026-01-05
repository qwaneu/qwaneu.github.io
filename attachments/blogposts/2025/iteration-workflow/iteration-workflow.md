# Iteration Workflow

## Overview Diagram

```mermaid
flowchart TB
    subgraph Planning["📋 Planning Phase"]
        PP[project-planner skill]
        PP --> FJ[features.json]
        PP --> GOALS[GOALS.md]
        PP --> PLAN[plan.md]
        FJ --> ITD[docs/iteration-N.md]
    end

    subgraph Execution["⚙️ Execution Phase"]
        START["/iteration-start"]
        START --> |"reads"| GOALS
        START --> |"reads"| ITD
        START --> |"mark-started"| IS[iteration-state binary]
        IS --> |"updates status"| FJ

        IR[iteration-runner skill]
        START --> IR
        IR --> |"spawns per story"| TASK[Task Agents]
        TASK --> |"TDD loop"| CODE[Write Tests → Implement → Pass]
    end

    subgraph Verification["✅ Verification Phase"]
        CHECK["/iteration-check"]
        CODE --> CHECK
        CHECK --> TESTS[mix test]
        CHECK --> CREDO[mix credo --strict]
        CHECK --> FORMAT[mix format --check]

        TESTS --> CF[credo-fixer skill]
        CF --> |"auto-fix"| CREDO

        CHECK --> TCA[test-coverage-analyzer]
        TCA --> TFJ[docs/test-feedback.json]
        TFJ --> TCI[test-coverage-improver]
        TCI --> |"fix P1/P2 gaps"| NEWTESTS[New Tests]

        CHECK --> |"mark-complete"| IS
        IS --> CRJ[docs/check-result.json]
    end

    subgraph Transition["🔄 Transition Phase"]
        NEXT["/iteration-next"]
        CRJ --> |"validate"| NEXT
        NEXT --> |"updates"| PJ[progress.json]
        NEXT --> |"generates"| PROGRESS[PROGRESS.md]

        TFJ --> TGU[test-guidance-updater]
        TGU --> |"updates"| CONTRIB[CONTRIBUTING.md]
        TGU --> |"adds guidance to"| ITD2[docs/iteration-N+1.md]

        NEXT --> |"creates"| ITD2
        NEXT --> |"updates"| GOALS
    end

    ITD2 --> START

    style Planning fill:#e1f5fe
    style Execution fill:#fff3e0
    style Verification fill:#e8f5e9
    style Transition fill:#f3e5f5
```

## Detailed Flow

```mermaid
sequenceDiagram
    participant U as User
    participant PP as project-planner
    participant IS as iteration-state
    participant IR as iteration-runner
    participant IC as /iteration-check
    participant TCA as test-coverage-analyzer
    participant TCI as test-coverage-improver
    participant TGU as test-guidance-updater
    participant IN as /iteration-next

    rect rgb(225, 245, 254)
        Note over U,PP: Planning Phase
        U->>PP: Plan project
        PP->>PP: Create features.json
        PP->>PP: Create GOALS.md, plan.md
        PP->>PP: Create docs/iteration-1.md
    end

    rect rgb(255, 243, 224)
        Note over U,IR: Execution Phase
        U->>IS: /iteration-start
        IS->>IS: mark-started (status → in_progress)
        U->>IR: Run iteration
        loop Per User Story
            IR->>IR: Spawn Task Agent
            IR->>IR: TDD: Test → Fail → Implement → Pass
            IR->>IR: Commit
        end
    end

    rect rgb(232, 245, 233)
        Note over U,TCI: Verification Phase
        U->>IC: /iteration-check
        IC->>IC: Run tests, credo, format
        IC->>TCA: Analyze coverage
        TCA->>TCA: Write test-feedback.json
        TCA->>TCI: P1/P2 gaps found?
        TCI->>TCI: Fix gaps, add tests
        TCI->>TCI: Commit improvements
        IC->>IS: mark-complete
        IS->>IS: Write check-result.json
    end

    rect rgb(243, 229, 245)
        Note over U,IN: Transition Phase
        U->>IN: /iteration-next
        IN->>IN: Validate completion
        IN->>IN: Update progress.json
        IN->>TGU: Analyze test history
        TGU->>TGU: Update CONTRIBUTING.md
        TGU->>TGU: Add guidance to next iteration
        IN->>IN: Create iteration-N+1.md
        IN->>IN: Update GOALS.md
    end

    Note over U,IN: Loop back to Execution Phase
```

## Test Feedback Loop

```mermaid
flowchart LR
    subgraph Iteration1["Iteration N"]
        I1[Implement Features]
        T1[Run Tests]
        A1[Analyze Gaps]
        F1[Fix P1/P2 Gaps]
    end

    subgraph Feedback["📊 Feedback Collection"]
        TF[test-feedback.json]
        A1 --> TF
        TF --> |"coverageTrend"| TREND[Historical P1/P2 counts]
        TF --> |"patternsObserved"| PATTERNS[Common gap patterns]
    end

    subgraph Learning["🧠 Learning Phase"]
        TGU[test-guidance-updater]
        TREND --> TGU
        PATTERNS --> TGU
        TGU --> CONTRIB[CONTRIBUTING.md<br/>Testing Guidelines]
        TGU --> GUIDANCE[Next Iteration<br/>Testing Guidance]
    end

    subgraph Iteration2["Iteration N+1"]
        GUIDANCE --> I2[Implement with Guidance]
        I2 --> T2[Run Tests]
        T2 --> A2[Analyze Gaps]
        A2 --> |"fewer gaps"| RESULT[Improved Coverage]
    end

    I1 --> T1 --> A1 --> F1
    F1 --> TF
    CONTRIB --> I2

    style Feedback fill:#fff9c4
    style Learning fill:#e1bee7
```

## File Flow

```mermaid
flowchart TB
    subgraph Primary["Primary (JSON)"]
        FJ[features.json<br/>Project definition]
        PJ[progress.json<br/>History tracking]
        CRJ[check-result.json<br/>Verification results]
        TFJ[test-feedback.json<br/>Coverage analysis]
    end

    subgraph Generated["Generated (Markdown)"]
        GOALS[GOALS.md<br/>Current state summary]
        PLAN[plan.md<br/>Roadmap overview]
        PROGRESS[PROGRESS.md<br/>Human-readable history]
        ITD[docs/iteration-N.md<br/>Executable spec]
    end

    subgraph Binary["Binary Tools"]
        IS[.claude/bin/iteration-state]
    end

    FJ --> |"generates"| GOALS
    FJ --> |"generates"| PLAN
    FJ --> |"generates"| ITD
    PJ --> |"generates"| PROGRESS

    IS --> |"updates"| FJ
    IS --> |"writes"| CRJ

    TFJ --> |"informs"| ITD

    style Primary fill:#bbdefb
    style Generated fill:#c8e6c9
    style Binary fill:#ffccbc
```

## Key Concepts

### JSON-Primary Output
- `features.json` is the source of truth for project structure
- `progress.json` tracks historical completion data
- Markdown files are generated summaries for human readability

### Test Feedback Loop
1. **Iteration N**: Test coverage analyzer finds gaps (P1-P4)
2. **Fix Phase**: P1/P2 gaps are fixed immediately (blocking)
3. **Learning Phase**: `test-guidance-updater` analyzes patterns
4. **Iteration N+1**: Testing guidance prevents recurring gaps

### Status Transitions
```
pending → in_progress → complete
   ↑                        |
   └────────────────────────┘
         (next iteration)
```

### Priority Levels
| Priority | Type | Blocking? |
|----------|------|-----------|
| P1 | Core functionality | Yes |
| P2 | Error handling | Yes |
| P3 | Edge cases | No |
| P4 | Domain-specific | No |
