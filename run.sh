{
export MODEL_PATH='../MetaMath-7B-V1.0'
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
export DATA_PATH="data/train/MATH_train.jsonl"
MODEL_NAME=$(basename $MODEL_PATH)
DATA_NAME=$(basename $DATA_PATH)
export SAVE_PATH="train_output/${MODEL_NAME}_${DATA_NAME}-${TIMESTAMP}"
export MASTER_ADDR="localhost"
export MASTER_PORT="1231"
export GLOO_SOCKET_IFNAME="lo"
export NCCL_SOCKET_IFNAME="lo"
export WANDB_DISABLED=true
export CUDA_VISIBLE_DEVICES=0,1,2,3
#记得同步改nproc_per_node
wandb offline

mkdir -p $SAVE_PATH
python3 -m torch.distributed.launch --master_addr ${MASTER_ADDR} --master_port ${MASTER_PORT} --nproc_per_node=4 --use_env train_math.py \
    --model_name_or_path $MODEL_PATH \
    --data_path $DATA_PATH \
    --data_length 10000000 \
    --bf16 True \
    --output_dir $SAVE_PATH \
    --num_train_epochs 3 \
    --per_device_train_batch_size 4 \
    --per_device_eval_batch_size 4 \
    --gradient_accumulation_steps 8 \
    --evaluation_strategy "no" \
    --save_strategy "steps" \
    --save_steps 1000 \
    --save_total_limit 2 \
    --learning_rate 2e-5 \
    --weight_decay 0. \
    --warmup_ratio 0.03 \
    --lr_scheduler_type "cosine" \
    --logging_steps 1 \
    --fsdp "full_shard auto_wrap" \
    --fsdp_transformer_layer_cls_to_wrap 'LlamaDecoderLayer' \
    --tf32 True > ${SAVE_PATH}/train_output.txt 2>&1

DATA_FILE="data/test/GSM8K_test.jsonl"
TEST_NAME=$(basename "$DATA_FILE" .jsonl)  # Extracts the base name without extension
OUTPUT_FILE="${SAVE_PATH}/${TEST_NAME}_output.txt"

python eval/eval_gsm8k.py \
--tensor_parallel_size 2 \
--model $SAVE_PATH \
--data_file $DATA_FILE > $OUTPUT_FILE 2>&1

DATA_FILE="data/test/MATH_test.jsonl"
TEST_NAME=$(basename "$DATA_FILE" .jsonl)  # Extracts the base name without extension
OUTPUT_FILE="${SAVE_PATH}/${TEST_NAME}_output.txt"

python eval/eval_math.py \
--tensor_parallel_size 2 \
--model $SAVE_PATH \
--data_file $DATA_FILE > $OUTPUT_FILE 2>&1

}