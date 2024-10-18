# README: Scripts Overview

This repository contains various scripts to evaluate model performance on multiple datasets, with a focus on In-Context Learning (ICL) and specific prompt variations. Below is a brief explanation of each folder and script:

## Folder: `eval_ICL`
This folder contains scripts that evaluate the performance of In-Context Learning on various datasets based on different prompt settings.

## Folder: `eval_new_prompt`
This folder contains scripts that evaluate the performance of models on various datasets using prompts that explicitly inform the presence of traps (potential pitfalls in the questions or tasks).

## Scripts:

### `eval_GSM8K_category.py`
This script evaluates the GSM8K dataset, saving the model outputs for further analysis.

### `eval_MATH_category2.py`
This script evaluates the MATH dataset, assessing the accuracy by different knowledge categories and saving the model's output for further analysis.

### `eval_True_False.py`
This script evaluates the model's performance on True/False concept questions, saving the model outputs for review.

### `eval_gsm8k.py`
This script evaluates the GSM8K dataset, reporting the final accuracy.

### `eval_math.py`
This script evaluates the MATH dataset and reports the final accuracy.

### `eval_math_error.py`
This script evaluates the MathTrap dataset, saving the model's output to analyze error cases.

### `util.py`
This script provides various utility functions to support the evaluations across different scripts.

