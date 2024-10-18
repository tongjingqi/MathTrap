{

export CUDA_VISIBLE_DEVICES=6,7
SAVE_PATH="test_output"
MODEL_PATH="../MetaMath-7B-V1.0"
DATA_FILE="data/test/Concept.jsonl"
TEST_NAME=$(basename "$DATA_FILE" .jsonl)  # Extracts the base name without extension
SCRIPT_PATH="eval/eval_True_False.py"
SCRIPT_NAME=$(basename "$SCRIPT_PATH" .py)
OUTPUT_FILE="${SAVE_PATH}/${TEST_NAME}_${SCRIPT_NAME}.txt"
TENSOR_PARALLEL_SIZE=2
python  $SCRIPT_PATH \
--tensor_parallel_size $TENSOR_PARALLEL_SIZE \
--model $MODEL_PATH \
--data_file $DATA_FILE > $OUTPUT_FILE 2>&1


DATA_FILE="data/test/MathTrap_Public.jsonl"
TEST_NAME=$(basename "$DATA_FILE" .jsonl)  # Extracts the base name without extension
SCRIPT_PATH="eval/eval_math_error.py"
SCRIPT_NAME=$(basename "$SCRIPT_PATH" .py)
OUTPUT_FILE="${SAVE_PATH}/${TEST_NAME}_${SCRIPT_NAME}.txt"
python  $SCRIPT_PATH \
--tensor_parallel_size $TENSOR_PARALLEL_SIZE \
--model $MODEL_PATH \
--data_file $DATA_FILE > $OUTPUT_FILE 2>&1


DATA_FILE="data/test/GSM8K-ori.jsonl"
TEST_NAME=$(basename "$DATA_FILE" .jsonl)  # Extracts the base name without extension
SCRIPT_PATH="eval/eval_GSM8K_category.py"
SCRIPT_NAME=$(basename "$SCRIPT_PATH" .py)
OUTPUT_FILE="${SAVE_PATH}/${TEST_NAME}_${SCRIPT_NAME}.txt"
python  $SCRIPT_PATH \
--tensor_parallel_size $TENSOR_PARALLEL_SIZE \
--model $MODEL_PATH \
--data_file $DATA_FILE > $OUTPUT_FILE 2>&1


DATA_FILE="data/test/MATH-ori.jsonl"
TEST_NAME=$(basename "$DATA_FILE" .jsonl)  # Extracts the base name without extension
SCRIPT_PATH="eval/eval_MATH_category2.py"
SCRIPT_NAME=$(basename "$SCRIPT_PATH" .py)
OUTPUT_FILE="${SAVE_PATH}/${TEST_NAME}_${SCRIPT_NAME}.txt"
python  $SCRIPT_PATH \
--tensor_parallel_size $TENSOR_PARALLEL_SIZE \
--model $MODEL_PATH \
--data_file $DATA_FILE > $OUTPUT_FILE 2>&1

#hint prompt

DATA_FILE="data/test/MathTrap_Public.jsonl"
TEST_NAME=$(basename "$DATA_FILE" .jsonl)  # Extracts the base name without extension
SCRIPT_PATH="eval/eval_new_prompt/eval_math_error_hint.py"
SCRIPT_NAME=$(basename "$SCRIPT_PATH" .py)
OUTPUT_FILE="${SAVE_PATH}/${TEST_NAME}_${SCRIPT_NAME}.txt"
python  $SCRIPT_PATH \
--tensor_parallel_size $TENSOR_PARALLEL_SIZE \
--model $MODEL_PATH \
--data_file $DATA_FILE > $OUTPUT_FILE 2>&1


DATA_FILE="data/test/GSM8K-ori.jsonl"
TEST_NAME=$(basename "$DATA_FILE" .jsonl)  # Extracts the base name without extension
SCRIPT_PATH="eval/eval_new_prompt/eval_GSM8K_category_hint.py"
SCRIPT_NAME=$(basename "$SCRIPT_PATH" .py)
OUTPUT_FILE="${SAVE_PATH}/${TEST_NAME}_${SCRIPT_NAME}.txt"
python  $SCRIPT_PATH \
--tensor_parallel_size $TENSOR_PARALLEL_SIZE \
--model $MODEL_PATH \
--data_file $DATA_FILE > $OUTPUT_FILE 2>&1


DATA_FILE="data/test/MATH-ori.jsonl"
TEST_NAME=$(basename "$DATA_FILE" .jsonl)  # Extracts the base name without extension
SCRIPT_PATH="eval/eval_new_prompt/eval_MATH_category2_hint.py"
SCRIPT_NAME=$(basename "$SCRIPT_PATH" .py)
OUTPUT_FILE="${SAVE_PATH}/${TEST_NAME}_${SCRIPT_NAME}.txt"
python  $SCRIPT_PATH \
--tensor_parallel_size $TENSOR_PARALLEL_SIZE \
--model $MODEL_PATH \
--data_file $DATA_FILE > $OUTPUT_FILE 2>&1

#ICL 1-shot

DATA_FILE="data/test/MathTrap_Public.jsonl"
TEST_NAME=$(basename "$DATA_FILE" .jsonl)  # Extracts the base name without extension
SCRIPT_PATH="eval/eval_ICL/eval_math_error_ICL(1shot).py"
SCRIPT_NAME=$(basename "$SCRIPT_PATH" .py)
OUTPUT_FILE="${SAVE_PATH}/${TEST_NAME}_${SCRIPT_NAME}.txt"
python  $SCRIPT_PATH \
--tensor_parallel_size $TENSOR_PARALLEL_SIZE \
--model $MODEL_PATH \
--data_file $DATA_FILE > $OUTPUT_FILE 2>&1


DATA_FILE="data/test/GSM8K-ori.jsonl"
TEST_NAME=$(basename "$DATA_FILE" .jsonl)  # Extracts the base name without extension
SCRIPT_PATH="eval/eval_ICL/eval_GSM8K_category_ICL(1shot).py"
SCRIPT_NAME=$(basename "$SCRIPT_PATH" .py)
OUTPUT_FILE="${SAVE_PATH}/${TEST_NAME}_${SCRIPT_NAME}.txt"
python  $SCRIPT_PATH \
--tensor_parallel_size $TENSOR_PARALLEL_SIZE \
--model $MODEL_PATH \
--data_file $DATA_FILE > $OUTPUT_FILE 2>&1


DATA_FILE="data/test/MATH-ori.jsonl"
TEST_NAME=$(basename "$DATA_FILE" .jsonl)  # Extracts the base name without extension
SCRIPT_PATH="eval/eval_ICL/eval_MATH_category2_ICL(1shot).py"
SCRIPT_NAME=$(basename "$SCRIPT_PATH" .py)
OUTPUT_FILE="${SAVE_PATH}/${TEST_NAME}_${SCRIPT_NAME}.txt"
python  $SCRIPT_PATH \
--tensor_parallel_size $TENSOR_PARALLEL_SIZE \
--model $MODEL_PATH \
--data_file $DATA_FILE > $OUTPUT_FILE 2>&1

#ICL 5-shot

DATA_FILE="data/test/MathTrap_Public.jsonl"
TEST_NAME=$(basename "$DATA_FILE" .jsonl)  # Extracts the base name without extension
SCRIPT_PATH="eval/eval_ICL/eval_ICL_5-shot/eval_math_error_ICL(5shot).py"
SCRIPT_NAME=$(basename "$SCRIPT_PATH" .py)
OUTPUT_FILE="${SAVE_PATH}/${TEST_NAME}_${SCRIPT_NAME}.txt"
python  $SCRIPT_PATH \
--tensor_parallel_size $TENSOR_PARALLEL_SIZE \
--model $MODEL_PATH \
--data_file $DATA_FILE > $OUTPUT_FILE 2>&1


DATA_FILE="data/test/GSM8K-ori.jsonl"
TEST_NAME=$(basename "$DATA_FILE" .jsonl)  # Extracts the base name without extension
SCRIPT_PATH="eval/eval_ICL/eval_ICL_5-shot/eval_GSM8K_category_ICL(5shot).py"
SCRIPT_NAME=$(basename "$SCRIPT_PATH" .py)
OUTPUT_FILE="${SAVE_PATH}/${TEST_NAME}_${SCRIPT_NAME}.txt"
python  $SCRIPT_PATH \
--tensor_parallel_size $TENSOR_PARALLEL_SIZE \
--model $MODEL_PATH \
--data_file $DATA_FILE > $OUTPUT_FILE 2>&1


DATA_FILE="data/test/MATH-ori.jsonl"
TEST_NAME=$(basename "$DATA_FILE" .jsonl)  # Extracts the base name without extension
SCRIPT_PATH="eval/eval_ICL/eval_ICL_5-shot/eval_MATH_category2_ICL(5shot).py"
SCRIPT_NAME=$(basename "$SCRIPT_PATH" .py)
OUTPUT_FILE="${SAVE_PATH}/${TEST_NAME}_${SCRIPT_NAME}.txt"
python  $SCRIPT_PATH \
--tensor_parallel_size $TENSOR_PARALLEL_SIZE \
--model $MODEL_PATH \
--data_file $DATA_FILE > $OUTPUT_FILE 2>&1

}