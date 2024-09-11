# MathTrap Dataset

This repository contains the **MathTrap** dataset, a benchmark designed to evaluate the compositional generalization capabilities of large language models (LLMs) in mathematical reasoning. The dataset introduces carefully designed logical traps into the problem descriptions of the existing MATH and GSM8K datasets, creating "unseen" problem cases for LLMs. 

## Paper

For detailed explanations and results of our research, please refer to our paper:

> **Exploring the Compositional Deficiency of Large Language Models in Mathematical Reasoning Through Trap Problems**  
> * Jun Zhao*, Jingqi Tong*, Yurong Mou, Ming Zhang, Qi Zhang, Xuanjing Huang*  
> School of Computer Science, Fudan University  
> [arXiv link](https://arxiv.org/abs/2405.06680v2)

## Dataset Overview

The **MathTrap** dataset consists of three types of problems:
1. **Original Problems**: Derived from the MATH and GSM8K datasets.
2. **Trap Problems**: Original problems modified to include logical traps, requiring compositional generalization to solve.


### Trap Categories

The dataset introduces five types of traps:
1. **Concept Undefined**: The problem involves undefined mathematical concepts.
2. **Missing Condition**: A necessary condition for solving the problem is omitted.
3. **Direct Contradiction**: The problem contains direct contradictions in its description.
4. **Indirect Contradiction**: Contradictions that can only be discovered during the reasoning process.
5. **Violating Common Sense**: The problem violates basic common-sense reasoning.

## Key Findings

Our experiments show that while LLMs possess the necessary knowledge to solve mathematical problems, they struggle to combine this knowledge effectively when faced with novel trap problems. In contrast, human participants demonstrate much stronger compositional generalization abilities when solving these same trap problems.

## Repository Structure

- `data/`: Contains the MathTrap dataset in both its public and non-public sections.
- `README.md`: This file.
- `paper.pdf`: The paper associated with this dataset.

## How to Use the Dataset

1. Download the dataset from the `data/` directory.
2. Refer to the paper for evaluation protocols and methods.
3. Use the dataset to test LLM performance on original, trap, and conceptual problems.

## Dataset Sample Structure

Each sample in the **MathTrap** dataset includes several attributes that describe the original problem, the trap problem, annotations, and solutions. Below is a detailed explanation of each attribute, using a specific sample as an example:

### Sample Example:
```json
{
    "category": "GSM8K",
    "trap_problem": "A gumball machine has red, green, black and 24 blue gumballs. The machine has half as many blue gumballs as red gumballs. For each blue gumball, the machine has 4 times as many green gumballs. For each black gumball, the machine has 2 times as many blue gumballs. If the machine has x red gumballs, 10 black gumballs, what's the value of x?",
    "human_annotation": "The condition that the blue ball is twice of the black ball is contradictory to the given numbers of these two color balls.",
    "trap_type": "Direct Contradiction",
    "original_problem": "A gumball machine has red, green, and blue gumballs. The machine has half as many blue gumballs as red gumballs. For each blue gumball, the machine has 4 times as many green gumballs. If the machine has 16 red gumballs how many gumballs are in the machine?",
    "gpt4_annotation": "Sure, let's try to solve the problem step by step.\n\nFrom the given problem, we have 24 blue gumballs and the machine has half as many blue gumballs as red gumballs. Thus, we can express the number of red gumballs as 2 * 24 = 48 red gumballs. This would satisfy the first condition.\n\nFor the green gumballs, for each blue gumball, the machine has 4 times as many green gumballs. Therefore, we have 4 * 24 = 96 green gumballs. This settles the second condition.\n\nNow, we're given that the machine has 10 black gumballs. The problem states that for each black gumball, the machine has 2 times as many blue gumballs. From this, we would expect to have 2 * 10 = 20 blue gumballs. However, we have already established from the given information that there are 24 blue gumballs in the machine.\n\nThis presents a contradiction because the number of blue gumballs we calculated based on the number of black gumballs (20) does not match with the given number of blue gumballs (24). Thus, with the conditions provided, the problem cannot be solved as it presents conflicting information.",
    "original_solution": "There are 16/2=<<16/2=8>>8 blue gumballs.\nThere are 8*4=<<8*4=32>>32 green gumballs.\nThere are 16+32+8=<<16+32+8=56>>56 total gumballs.\n#### 56"
}
```

### Attribute Descriptions:

- **`category`**: Refers to the source of the **original problem**. For example, "GSM8K" indicates that the original problem comes from the GSM8K dataset. This attribute helps track the origin of each problem.
  
- **`trap_problem`**: This is the modified version of the **original problem** and is the core content of the dataset. Logical traps are introduced into the problem description to create a more complex or misleading scenario that challenges large language models (LLMs) to exhibit compositional reasoning.

- **`human_annotation`**: This provides the explanation or reasoning from the dataset's creators (humans) regarding the nature of the trap in the **trap_problem**. This annotation describes why the problem contains a logical flaw or contradiction, helping to highlight the core difficulty of the trap.

- **`trap_type`**: Indicates the type of logical trap introduced in the **trap_problem**. In this example, "Direct Contradiction" means that the problem contains directly conflicting information that makes the problem unsolvable.

- **`original_problem`**: The original, unmodified problem from the source dataset (e.g., GSM8K or MATH). The **trap_problem** is based on this, but with additional logical traps introduced. This problem typically does not contain any logical contradictions and is solvable through standard reasoning.

- **`gpt4_annotation`**: Provides a detailed step-by-step explanation generated by GPT-4. It analyzes the **trap_problem** and elaborates on the **human_annotation**, explaining why the problem presents a contradiction or is unsolvable. The input for GPT-4 includes both the **trap_problem** and the corresponding **human_annotation**.

- **`original_solution`**: This field contains the solution to the **original_problem** as found in the original dataset (e.g., GSM8K). It shows the correct mathematical steps or reasoning required to solve the original, unmodified problem.

---

### Example Breakdown:

- **Category**: This sample is from the GSM8K dataset, a well-known dataset for evaluating LLMs' mathematical reasoning abilities.

- **Trap Problem**: The problem asks for the number of red gumballs, but the given conditions regarding the number of blue and black gumballs create a direct contradiction.

- **Human Annotation**: The human annotator points out that the condition for blue gumballs being twice the number of black gumballs conflicts with the numbers given in the problem.

- **Trap Type**: This is a "Direct Contradiction" because two pieces of information directly conflict with each other, making the problem unsolvable.

- **Original Problem**: In the original version of the problem, there are no contradictions, and it is solvable with the given numbers.

- **GPT-4 Annotation**: GPT-4 walks through the problem step by step and points out where the contradiction occurs, confirming that the problem cannot be solved due to conflicting information about the blue and black gumballs.

- **Original Solution**: For the original problem, the solution shows how to calculate the total number of gumballs by determining the number of blue and green gumballs based on the red ones.



## License

This dataset is provided for research purposes only. Please cite our paper if you use the dataset in your work.

## Citation

```
@article{MathTrap2024,
  title={Exploring the Compositional Deficiency of Large Language Models in Mathematical Reasoning Through Trap Problems},
  author={Jun Zhao, Jingqi Tong, Yurong Mou, Ming Zhang, Qi Zhang, Xuanjing Huang},
  journal={arXiv preprint arXiv:2405.06680v2},
  year={2024}
}
```

---

Feel free to copy and modify the content based on any specific additions you want to make!
