# Wnqi-Big-Size

## Model

```
- project-owner
- project
- wbs
- artifacts
- resource

- project-owner ---------> project

- project ---edge, :have-to-[1:n]-------> wbs
- wbs -------edge, :have-to-[1:n]-------> wbs
- wbs -------edge, :have-to-[1:1?]------> artifacts

- project ---edge,      :attribute-[1:1]-------> term
- project ---edge-past, :attribute-[1:n]-------> term
- wbs -------edge,      :attribute-[1:1]-------> term
- wbs -------edge-past, :attribute-[1:n]-------> term
```

## Usage

## Installation
