export CUDA_VISIBLE_DEVICES=1,2
MODEL_PATH="/mnt/data/user/zhao_jun/MetaMath-Llemma-7B"
SAVE_PATH="/mnt/data/user/zhao_jun/MetaMath-Llemma-7B/hint_prompt_eval"
DATA_FILE="/mnt/data/user/zhao_jun/MetaMath/data/test/ICF_GSM8K_init.jsonl"
TEST_NAME=$(basename "$DATA_FILE" .jsonl)  # Extracts the base name without extension
OUTPUT_FILE="${SAVE_PATH}/${TEST_NAME}_output.txt"

python /mnt/data/user/zhao_jun/MetaMath/eval/eval_new_prompt/eval_gsm8k.py \
    --tensor_parallel_size 2 \
    --model $MODEL_PATH \
    --data_file ./data/test/GSM8K_test.jsonl >> ${SAVE_PATH}/train_output.txt 2>&1

python /mnt/data/user/zhao_jun/MetaMath/eval/eval_new_prompt/eval_math.py \
    --tensor_parallel_size 2 \
    --model $MODEL_PATH \
    --data_file ./data/test/MATH_test.jsonl >> ${SAVE_PATH}/train_output.txt 2>&1

python /mnt/data/user/zhao_jun/MetaMath/eval/eval_new_prompt/eval_gsm8k.py  \
--tensor_parallel_size 2 \
--model $MODEL_PATH \
--data_file $DATA_FILE > $OUTPUT_FILE 2>&1

DATA_FILE="/mnt/data/user/zhao_jun/MetaMath/data/test/ICF_MATH_init.jsonl"
TEST_NAME=$(basename "$DATA_FILE" .jsonl)  # Extracts the base name without extension
OUTPUT_FILE="${SAVE_PATH}/${TEST_NAME}_output.txt"

python /mnt/data/user/zhao_jun/MetaMath/eval/eval_new_prompt/eval_math.py \
--tensor_parallel_size 2 \
--model $MODEL_PATH \
--data_file $DATA_FILE > $OUTPUT_FILE 2>&1

DATA_FILE="/mnt/data/user/zhao_jun/MetaMath/data/test/ICF_test.jsonl"
TEST_NAME=$(basename "$DATA_FILE" .jsonl)  # Extracts the base name without extension
OUTPUT_FILE="${SAVE_PATH}/${TEST_NAME}_output.txt"

python /mnt/data/user/zhao_jun/MetaMath/eval/eval_new_prompt/eval_ICF.py \
--tensor_parallel_size 2 \
--model $MODEL_PATH \
--data_file $DATA_FILE > $OUTPUT_FILE 2>&1

DATA_FILE="/mnt/data/user/zhao_jun/MetaMath/data/test/standardized_ICF_train2_modified.jsonl"
TEST_NAME=$(basename "$DATA_FILE" .jsonl)  # Extracts the base name without extension
OUTPUT_FILE="${SAVE_PATH}/${TEST_NAME}_output.txt"

python /mnt/data/user/zhao_jun/MetaMath/eval/eval_new_prompt/eval_ICF.py \
--tensor_parallel_size 2 \
--model $MODEL_PATH \
--data_file $DATA_FILE > $OUTPUT_FILE 2>&1

DATA_FILE="/mnt/data/user/zhao_jun/MetaMath/data/test/ICF_test2.jsonl"
TEST_NAME=$(basename "$DATA_FILE" .jsonl)  # Extracts the base name without extension
OUTPUT_FILE="${SAVE_PATH}/${TEST_NAME}_output.txt"

python /mnt/data/user/zhao_jun/MetaMath/eval/eval_new_prompt/eval_ICF.py \
--tensor_parallel_size 2 \
--model $MODEL_PATH \
--data_file $DATA_FILE > $OUTPUT_FILE 2>&1

