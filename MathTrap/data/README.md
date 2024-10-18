# README: Dataset Overview

This document provides a brief overview of the various datasets used in our project.

## MathTrap_Public

- **MathTrap_Public.json**: This file contains the entire content of the MathTrap_Public dataset, including the Trap Problems, corresponding Original Problems, and their respective annotated responses.

## train

- **GSM8K_train.jsonl**: This is the training set for the GSM8K dataset, designed for solving math word problems.

- **MATH_train.jsonl**: This dataset serves as the training set for MATH, focusing on mathematical reasoning tasks.

- **MetaMathQA-395K.jsonl**: This is the MetaMath training set containing a diverse range of mathematical questions for enhanced learning.

## test

- **Concept.jsonl**: Corresponds to the MathTrap_Private dataset, consisting of concept questions formatted as true/false statements.

- **GSM8K-ori.jsonl**: A subset of the GSM8K dataset, adapted to create a smaller version of MathTrap_Private for performance comparison.

- **GSM8K_test.jsonl**: The test set for the GSM8K dataset, used for evaluating model performance.

- **MATH-ori.jsonl**: A subset of the MATH dataset, adapted to create a smaller version of MathTrap_Private for performance comparison.

- **MATH_test.jsonl**: The test set for the MATH dataset, designed to assess model capabilities.

- **MathTrap_Public_aug.jsonl**: This dataset expands MathTrap_Public by generating ten variations of answers using GPT-4.

- **MathTrap_Public.jsonl**: Contains the same questions as MathTrap_Public_aug.jsonl but without the augmented answers.

**Note**: No train-test split has been performed on MathTrap_Public; users may need to divide it accordingly for training and evaluation. Incorporating MathTrap into training may lead to decreased accuracy on standard questions, so it's advised to limit the inclusion of MathTrap problems.