import argparse
import json
import re
import jsonlines
from fraction import Fraction
from vllm import LLM, SamplingParams
import sys
MAX_INT = sys.maxsize

def is_number(s):
    try:
        float(s)
        return True
    except ValueError:
        pass
    try:
        import unicodedata
        unicodedata.numeric(s)
        return True
    except (TypeError, ValueError):
        pass
    return False

def extract_answer_number(completion):
    text = completion.split('The answer is: ')
    if len(text) > 1:
        extract_ans = text[-1].strip()
        match = re.search(r'[\-+]?\d*[\.,/]?\d+', extract_ans)
        if match:
            if '/' in match.group():
                denominator = match.group().split('/')[1]
                numerator = match.group().split('/')[0]
                if is_number(denominator) == True and is_number(numerator) == True:
                    if denominator == '0':
                        return round(float(numerator.replace(',', '')))
                    else:
                        frac = Fraction(match.group().replace(',', ''))
                        num_numerator = frac.numerator
                        num_denominator = frac.denominator
                        return round(float(num_numerator / num_denominator))
                else:
                    return None
            else:
                if float(match.group().replace(',', '')) == float('inf'):
                    return None
                return round(float(match.group().replace(',', '')))
        else:
            return None
    else:
        return None

def batch_data(data_list, batch_size=1):
    n = len(data_list) // batch_size
    batch_data = []
    for i in range(n-1):
        start = i * batch_size
        end = (i+1)*batch_size
        batch_data.append(data_list[start:end])

    last_start = (n-1) * batch_size
    last_end = MAX_INT
    batch_data.append(data_list[last_start:last_end])
    return batch_data


def gsm8k_test(model, data_path, start=0, end=MAX_INT, batch_size=1, tensor_parallel_size=1):
    INVALID_ANS = "[invalid]"
    gsm8k_ins = []
    gsm8k_answers = []
    problem_prompt = (
        "Below is an instruction that describes a task. "
        "Write a response that appropriately completes the request.\n\nPlease solve the following problem. Note that this problem may be unsolvable or has no solution.\nThe problem is unsolvable.\n"
        "### Instruction:\nIf $r$ is a negative integer, and the maximum value of the expression $5r^2 + br - 12$ is 36, what's the value of b?\n### Response: Let's think step by step. Given the equation $5r^2 + br - 12$ and the constraint that $r$ is a negative integer, we are asked to find the maximum value of the expression and equate it to 36 to solve for $b$.\n\nLet's first understand the structure of our equation. It is a quadratic equation of the form $ax^2 + bx + c$. The graph of a quadratic equation is a parabola. The direction of the parabola (whether it opens upwards or downwards) is determined by the sign of the coefficient of $r^2$ (which is equivalent to $a$ in our standard form). \n\nSince the coefficient of $r^2$ is 5, which is positive, our parabola opens upwards.\n\nBut here's where we run into a problem. A parabola that opens upwards does not have a maximum value, it has a minimum value. This is because as $r$ moves either positively or negatively away from the vertex (the peak or trough of the parabola), the value of the expression $5r^2 + br - 12$ increases.\n\nFurthermore, the constraint that $r$ is a negative integer doesn't affect this conclusion. Regardless of whether $r$ is positive or negative, a parabola that opens upwards does not have a maximum value.\n\nTherefore, it is impossible to equate the maximum value of the expression to 36 as the problem initially asks, and we cannot solve for $b$ under these conditions. The question has posed an unsolvable scenario.\nThe problem is unsolvable.\n"
        "### Instruction:\nHow many prime numbers can be divided by 39?\n### Response: Let's think step by step. No prime numbers can be divided by 39. By definition, a prime number is a natural number greater than 1 that has no positive divisors other than 1 and itself. Since 39 is composed of the factors 3 and 13 (both of which are prime numbers themselves), any number that can be divided by 39 cannot be a prime number, as it would have to at least include 3 and 13 as factors besides 1 and itself.\nTherefore, there are \\boxed{{0}} prime numbers that can be divided by 39. The answer is: 0\n"
        "### Instruction:\nIf odd integers $x y$ satisfies $\\\\frac{{1}}{{2}}-\\\\frac{{1}}{{3}}=\\\\frac{{x}}{{y}}$, then what is the value of $x$?\n### Response: Let's think step by step. To solve this problem, we must first simplify the left-hand side of the equation, $\\frac{{1}}{{2}}-\\frac{{1}}{{3}}$. This simplifies to $\\frac{{1}}{{6}}$. So the equation becomes $\\frac{{1}}{{6}}=\\frac{{x}}{{y}}$.\n\nWe can cross multiply to get $x = \\frac{{1}}{{6}}y$. \n\nThe problem arises from the requirement that both $x$ and $y$ be odd integers. If we multiply an odd number $y$ by $\\frac{{1}}{{6}}$, we would not yield an odd integer for $x$. This is because a fraction of an odd integer doesn't result in an integer, let alone an odd integer.\n\nFurthermore, to produce $\\frac{{1}}{{6}}$, $y$ would have to be a multiple of 6, which means $y$ would be even. This contradicts the original stipulation that $y$ should be an odd integer.\n\nTherefore, under the given conditions, there is no solution to this problem. The constraints on $x$ and $y$ being odd integers and the equation $\\frac{{1}}{{2}}-\\frac{{1}}{{3}}=\\frac{{x}}{{y}}$ cannot hold true simultaneously.\nThe problem is unsolvable.\n"
        "### Instruction:\nIf a triangle has two sides of lengths 5 and 7 units, then how many different integer lengths can the third side be?\n### Response: Let's think step by step. Let the two given sides be $a$ and $b$.\nFor a triangle to be formed, the third side must satisfy the triangle inequality, which states that the sum of the lengths of any two sides of a triangle must be greater than the length of the remaining side.\nSo for the third side, we have the inequalities $|a-b| < c < a+b$.\nIn this case, $a=5$ and $b=7$, so the inequalities become $|5-7| < c < 5+7$, which simplify to $2 < c < 12$.\nSince $c$ must be an integer, the possible integer lengths for the third side are 3, 4, 5, 6, 7, 8, 9, 10, and 11.\nTherefore, there are $\\boxed{{9}}$ different integer lengths the third side can be.\nThe answer is: 9\n"
        "### Instruction:\nFind p if the focus of the parabola $x + x^2 = -\\\\frac{{p}}{{12}} y^2.$ is (-1/2,1).\n### Response: Let's think step by step. To begin solving this problem, we first need to express the equation in the standard form of a parabola. The standard forms are either $y^2 = 4ax$ or $x^2 = 4ay$ where (a,0) is the focus for the first case, and (0,a) is the focus for the second case. Let's try to manipulate the given equation into one of these forms.\n\nThe given equation is $x+x^2=-\\frac{{p}}{{12}}y^2$. Rearranging this equation, we have $x^2 + x + \\frac{{p}}{{12}}y^2 = 0$.\n\nThis equation does not align with the standard form of a parabola equation. The standard form of the equation of a parabola should only have the square of one variable, either $x$ or $y$. However, in our equation, $x$ is squared, and there is also a term involving $y^2$.\n\nTherefore, we can't express the equation in the standard form of a parabola, which indicates that the equation does not represent a parabola. Consequently, we cannot find a focus for a parabola because the given equation does not describe a parabola. The initial assumption that we are dealing with a parabola is incorrect.\nThe problem is unsolvable."
        "### Instruction:\n{instruction}\n\n### Response: Let's think step by step."
    )
    print('promt =====', problem_prompt)
    with open(data_path,"r+", encoding="utf8") as f:
        for idx, item in enumerate(jsonlines.Reader(f)):
            temp_instr = problem_prompt.format(instruction=item["question"])
            gsm8k_ins.append(temp_instr)
            temp_ans = item['answer'].split('#### ')[1]
            temp_ans = int(temp_ans.replace(',', ''))
            gsm8k_answers.append(temp_ans)

    gsm8k_ins = gsm8k_ins[start:end]
    gsm8k_answers = gsm8k_answers[start:end]
    print('lenght ====', len(gsm8k_ins))
    batch_gsm8k_ins = batch_data(gsm8k_ins, batch_size=batch_size)

    stop_tokens = ["Question:", "Question", "USER:", "USER", "ASSISTANT:", "ASSISTANT", "Instruction:", "Instruction", "Response:", "Response"]
    sampling_params = SamplingParams(temperature=0.0, top_p=1, max_tokens=512, stop=stop_tokens)
    print('sampleing =====', sampling_params)
    llm = LLM(model=model,tensor_parallel_size=tensor_parallel_size)
    result = []
    res_completions = []
    for idx, (prompt, prompt_answer) in enumerate(zip(batch_gsm8k_ins, gsm8k_answers)):
        if isinstance(prompt, list):
            pass
        else:
            prompt = [prompt]

        completions = llm.generate(prompt, sampling_params)
        for output in completions:
            prompt = output.prompt
            generated_text = output.outputs[0].text
            res_completions.append(generated_text)

    invalid_outputs = []
    valid_outputs=[]
    for idx, (prompt, completion, prompt_answer) in enumerate(zip(gsm8k_ins, res_completions, gsm8k_answers)):
        doc = {'question': prompt}
        y_pred = extract_answer_number(completion)
        if y_pred != None:
            result.append(float(y_pred) == float(prompt_answer))
            temp = {'question': prompt, 'output': completion, 'answer': prompt_answer}
            valid_outputs.append(temp)
        else:
            result.append(False)
            temp = {'question': prompt, 'output': completion, 'answer': prompt_answer}
            invalid_outputs.append(temp)
    acc = sum(result) / len(result)
    print('len invalid outputs ====', len(invalid_outputs), ', invalid_outputs===', invalid_outputs)
    print('len valid outputs ====', len(valid_outputs), ', valid_outputs===', valid_outputs)
    print('start===', start, ', end====', end)
    print('gsm8k length====', len(result), ', gsm8k acc====', acc)


def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument("--model", type=str)  # model path
    parser.add_argument("--data_file", type=str, default='')  # data path
    parser.add_argument("--start", type=int, default=0) #start index
    parser.add_argument("--end", type=int, default=MAX_INT)  # end index
    parser.add_argument("--batch_size", type=int, default=400)  # batch_size
    parser.add_argument("--tensor_parallel_size", type=int, default=8)  # tensor_parallel_size
    return parser.parse_args()
if __name__ == "__main__":
    args = parse_args()
    gsm8k_test(model=args.model, data_path=args.data_file, start=args.start, end=args.end, batch_size=args.batch_size, tensor_parallel_size=args.tensor_parallel_size)
