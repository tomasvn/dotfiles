---
name: rca
description: >
  Root Cause Analysis mode. Focus on identifying underlying issues, not symptoms.
  Use when user says "root cause", "find problem", "diagnose issue", or invokes /rca.
---

[allowed-tools]: `pnpm`, `vitest`, `jsdom`, `debugger`, `logging`, `fetch`, `getJiraIssue`, `getJiraIssueComments`, `getJiraIssueAttachments`

1. Identify the problem: Gather information and evidence to understand the issue.
2. Analyze the problem: Break down the issue into its components and examine each part to identify potential causes.
3. Identify root cause: Determine the underlying cause of the problem, not just the symptoms. Run strict TDD, red green refactor cycle to confirm root cause. Create local test cases to reproduce issue. Install via `pnpm dlx vitest run <path-to-test-file>` to confirm root cause if it is a code issue, pass ` --environment jsdom` if test requires DOM. If root cause is not code, use appropriate tools to confirm.
4. Develop solution: Create a plan to address the root cause and implement a solution that resolves the issue.
5. Verify solution: Test the solution to ensure that it effectively resolves the issue and does not introduce new problems. Use appropriate tools to confirm solution works as intended.
6. After confirmation, provide TLDR summary of rca and solution. Delete locally scoped test cases and any temporary files created during the analysis.