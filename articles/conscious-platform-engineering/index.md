---
layout: page
title: "Intentional Platform Engineering"
toc: true
---

## Core Idea

Developer attention is a scarce organizational resource. A well-designed platform automates routine decisions, makes consequential choices explicit, and directs human attention toward the risks that genuinely require judgment.

This provides a practical model for deciding what a golden path should do.

| Decision type | Platform response | Example |
| --- | --- | --- |
| Routine and well understood | Automate it | Standard builds, dependency scanning, and deployment records |
| Context-dependent and consequential | Surface it clearly | Data classification, availability requirements, and regional deployment |
| Exceptional or high risk | Escalate it | Disabling a security control, using unsupported infrastructure, or permitting unusual data access |

This distinction matters because many organizations try to automate all three categories. That produces either rigid platforms or controls that generate so much noise that developers stop paying attention.

## A Consultancy Doctrine

### 1. Protect Developer Attention

Cognitive load should be treated as an operational cost. Every warning, approval, configuration choice, and policy failure consumes attention. Controls should earn that cost by reducing a meaningful risk.

### 2. Apply Controls in Proportion to Risk

A documentation correction should not encounter the same process as a database migration involving regulated data. The platform should adjust its controls according to change type, system criticality, data sensitivity, and reversibility.

### 3. Separate Organizational Intent from Technical Mechanism

The organization may require customer data to remain protected. That is the intent. Mandating one specific implementation in every system is a mechanism. Keeping those separate allows teams to satisfy the policy through an appropriate, verifiable design.

### 4. Design for Progressive Disclosure

The common path should require very little platform knowledge. Additional complexity should appear only when the developer's choices introduce additional risk or capability.

### 5. Make Exceptions Part of the System

Exceptions are not necessarily platform failures. They reveal where the organization's assumptions do not match reality. A good exception process is visible, documented, time-limited, and reviewed for patterns.

Golden paths should be strongly preferred, but they should not become golden cages.

### 6. Give Controls a Lifecycle

Every control should have:

- An owner
- A rationale
- A success measure
- A review date
- A removal condition

Without these elements, governance only accumulates.

### 7. Measure Flow and Risk Together

Deployment speed alone can hide unacceptable risk. Compliance counts alone can hide debilitating friction. The platform should be evaluated using paired measures such as:

- Lead time and change-failure rate
- Developer wait time and risk reduction
- Exception frequency and exception outcomes
- Policy failure rate and false-positive rate
- Platform adoption and successful off-path delivery
- Time to remediation and recurrence rate

If controls increase friction without reducing meaningful risk, the platform team should simplify them.

## The Diagnostic Question

> At each point in the delivery process, are we automating a routine decision, enabling a conscious decision, or imposing an inherited decision whose value is no longer understood?

This question can uncover obsolete approvals, redundant tools, hidden organizational preferences, and controls that have become detached from their original risks.

## A Four-Stage Consulting Framework

### 1. Map the Delivery Journey

Identify the important decision points throughout product development, build, release, deployment, and operation.

### 2. Classify Each Decision

Classify each decision as:

- Automated
- Conscious
- Escalated

Determine whether the current treatment is appropriate for the decision's actual risk and complexity.

### 3. Measure Attention Cost and Risk Value

Evaluate how much delay, cognitive load, and organizational effort each control creates. Compare that cost with the meaningful risk reduction the control provides.

### 4. Redesign the Golden Path

Redesign the delivery experience around the organization's actual priorities. Automate routine decisions, clearly present consequential tradeoffs, and provide a visible path for legitimate exceptions.

## Codifying Organizational Preferences

An organization can make its architectural preferences explicit across dimensions such as:

- Security
- Resilience
- Delivery speed
- Cost
- Operability
- Developer autonomy

The goal should not be to produce a single abstract maturity score or pretend that every architectural decision can be automated. The goal is to expose tradeoffs, make disagreement visible, and help teams make choices that are consistent with the organization's priorities.

## Measures to Watch

Useful measures include:

- Developer wait time
- Deployment lead time
- Exception frequency
- Exception outcomes
- False-positive rate
- Policy failure rate
- Change-failure rate
- Time to remediation
- Control recurrence rate
- Platform adoption

These measures should help answer a central question:

> Is the platform reducing meaningful risk and systemic friction, or is it becoming another layer of institutional overhead?

## Working Position

Platform engineering should automate routine decisions, make consequential tradeoffs explicit, and protect developer attention as carefully as it protects infrastructure.

## Signature Principles

> Automate the obvious decisions, progressively disclose complexity, and reserve human attention for choices that genuinely require judgment.

> Remove decisions that do not deserve human attention. Improve the decisions that do.
