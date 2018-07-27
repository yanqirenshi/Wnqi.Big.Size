# Wnqi-Big-Size

## Model

```
- project
- wbs
- artifacts

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
