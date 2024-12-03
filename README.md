# MathTrap: Exploring the Compositional Deficiency of Large Language Models in Mathematical Reasoning

[![Code License](https://img.shields.io/badge/Code%20License-Apache_2.0-green.svg)](CODE_LICENSE)
[![Python 3.9+](https://img.shields.io/badge/python-3.9+-blue.svg)](https://www.python.org/downloads/release/python-390/)

## Paper

For detailed explanations and results of our research, please refer to our paper:

> **Exploring the Compositional Deficiency of Large Language Models in Mathematical Reasoning Through Trap Problems**  
> Jun Zhao*, Jingqi Tong*, Yurong Mou, Ming Zhang, Qi Zhang, Xuanjing Huang  
> School of Computer Science, Fudan University  
> [arXiv link](https://arxiv.org/pdf/2405.06680)

## MathTrap Dataset

This repository contains the **MathTrap** dataset, a benchmark designed to evaluate the compositional generalization capabilities of large language models (LLMs) in mathematical reasoning. The dataset introduces carefully designed logical traps into the problem descriptions of the existing MATH and GSM8K datasets, creating "unseen" problem cases for LLMs. 


## Example Trap Problems

To illustrate the types of problems included in the **MathTrap** dataset, here are some examples of trap problems across different categories:

| **Type**                  | **Trap Problem**                                                                                                                                      | **Explanation**                                                                                                   |
|---------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------|
| **Concept Undefined**     | In right triangle XYZ with ∠YXZ = 90°, we have XY = 24 and YZ = 25. Find **tan X**.            | ∠YXZ = 90°, so **tan X = tan(π/2)** is undefined.                                             |
| **Missing Condition**     | Natalia sold 48 clips in April and half as many clips in May. How many clips did Natalia sell altogether in April and **June**? | We don't know anything about June, so it's impossible to calculate the sum of the sales for April and June.      |
| **Direct Contradiction**  | An equilateral triangle has a perimeter of 30 centimeters **and a height of 10 centimeters**. Calculate the area of the triangle. | The height of the equilateral triangle and its side length are both 10 centimeters, which is contradictory and impossible. |
| **Indirect Contradiction**| Find the **integer** solution of the equation \(x^2+x=3\).                                                                        | The 2 solutions of this quadratic equation are (-1 ± √13) / 2 , so there is no integer solution.| 
| **Violating Common Sense**| Max picks **5** different cards without replacement from a standard 52-card deck. What is the probability that the cards are of different suits? | There are only 4 suits in a deck, so it's impossible for 5 cards to be of different suits.                       |

*Table: Explanation of examples of trap problems for each category.*

---

## Evaluation Results

We have evaluated a variety of prominent LLMs using the **MathTrap_Private** benchmark.




| Model                   | Conceptual      | Original     | Trap      | Ratio     |
|-------------------------|-----------------|--------------|-----------|-----------|
| Gemini-Pro               | 70.0            | 36.9         | 8.30      | 22.5      |
| Claude3-Opus             | 87.7            | 68.5         | 19.0      | 27.7      |
| Claude-3.5-Sonnet        | 93.9            | 75.0         | 19.4      | 25.9      |
| GPT-3.5-turbo-0125       | 74.6            | 40.5         | 7.60      | 18.8      |
| GPT-4-0125-preview       | 90.0            | 70.3         | 36.0      | 51.2      |
| **o1-preview(API)**      | **96.2**        | **88.3**     | **38.1**  | **43.1**  |
| **o1-preview(Web)**      | **92.3**        | **87.5**     | **67.7**  | **77.4**  |
| Kimi                     | 71.5            | 46.1         | 19.6      | 42.5      |
|-------------------------|-----------------|--------------|-----------|-----------|
| Llemma-MetaMath-7B       | 55.2            | 41.4         | 6.40      | 15.5      |
| MetaMath-7B              | 43.2            | 32.5         | 1.90      | 5.84      |
| MetaMath-13B             | 37.8            | 37.5         | 3.90      | 10.4      |
| MetaMath-70B             | 57.6            | 34.2         | 6.50      | 19.0      |
| Llama3-8B                | 70.5            | 33.3         | 6.45      | 19.4      |
| Llama3-8B-Base           | 44.7            | 33.3         | 6.45      | 19.4      |
| Llama3-70B               | 88.5            | 61.7         | 7.74      | 12.5      |
| Llama3-70B-Base          | 53.8            | 37.5         | 7.74      | 20.6      |
| Llama3.1-8B              | 70.8            | 61.7         | 13.5      | 21.9      |
| Llama3.1-70B             | 88.5            | 69.2         | 19.4      | 28.0      |



*Table: Accuracy (%) of various models on three types of MathTrap problems. 'Conceptual' represents Conceptual problems, 'Original' refers to the original problems, and 'Trap' denotes the trap problems. 'Ratio' refers to the ratio of the accuracy on Trap problems to the accuracy on Original problems. It reflects the degree to which performance is maintained when facing problems with traps, relative to the original problems.*

## Key Findings

Our experiments show that while LLMs possess both components of requisite knowledge, they do not spontaneously combine them to handle these novel cases. We explore several methods to mitigate this deficiency, such as natural language prompts, few-shot demonstrations, and fine-tuning. Additionally, we test the recently released OpenAI o1 model and find that human-like ‘slow thinking’ helps improve the compositionality of LLMs.

## Installation

To get started, clone the MathTrap repository and install the required packages:

```bash
git clone https://github.com/tongjingqi/MathTrap
cd MathTrap
pip install -r requirements.txt
```

If you encounter any issues with Ray installation, please run:

```bash
pip install --upgrade ray
pip install --upgrade pyarrow
pip install pandas
```


## Evaluation

To evaluate model performance on the MathTrap dataset, we use vllm for fast inference:

```bash
bash infer.sh
```

## Training

To train models using the **MathTrap** dataset, follow the steps below. You will need to prepare the **LLaMA-2** base model:

```bash
bash run.sh
```



## Acknowledgements

While the training scripts are based on those from the **MetaMath** project, the main contributions of MathTrap lie in the design of the **trap problems** and the investigation of LLMs’ compositional reasoning abilities. We would like to thank the MetaMath team for their open-source work, which has supported the technical foundation of this project. For more information on MetaMath, please visit their [repository](https://github.com/meta-math/MetaMath).

## Citation

If you use MathTrap in your work, please cite our paper:

```
@inproceedings{zhao-etal-2024-exploring-compositional,
    title = "Exploring the Compositional Deficiency of Large Language Models in Mathematical Reasoning Through Trap Problems", 
    author = "Zhao, Jun  and
      Tong, Jingqi  and
      Mou, Yurong  and
      Zhang, Ming  and
      Zhang, Qi  and
      Huang, Xuanjing",
    editor = "Al-Onaizan, Yaser  and
      Bansal, Mohit  and
      Chen, Yun-Nung",
    booktitle = "Proceedings of the 2024 Conference on Empirical Methods in Natural Language Processing",
    month = nov,
    year = "2024",
    address = "Miami, Florida, USA",
    publisher = "Association for Computational Linguistics",
    url = "https://aclanthology.org/2024.emnlp-main.915",
    pages = "16361--16376",
    abstract = "Human cognition exhibits systematic compositionality, the algebraic ability to generate infinite novel combinations from finite learned components, which is the key to understanding and reasoning about complex logic. In this work, we investigate the compositionality of large language models (LLMs) in mathematical reasoning. Specifically, we construct a new dataset MathTrap by introducing carefully designed logical traps into the problem descriptions of MATH and GSM8K. Since problems with logical flaws are quite rare in the real world, these represent {``}unseen{''} cases to LLMs. Solving these requires the models to systematically compose (1) the mathematical knowledge involved in the original problems with (2) knowledge related to the introduced traps. Our experiments show that while LLMs possess both components of requisite knowledge, they do not \textbf{spontaneously} combine them to handle these novel cases. We explore several methods to mitigate this deficiency, such as natural language prompts, few-shot demonstrations, and fine-tuning. We find that LLMs{'} performance can be improved through the above external intervention. Overall, systematic compositionality remains an open challenge for large language models.",
}
```


