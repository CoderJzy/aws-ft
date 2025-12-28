from swift import Swift, LoRAConfig
from modelscope import Model

# LoRA 参数配置
config = LoRAConfig(
    r=8,
    alpha=32,
    target_modules="all-linear",
    learning_rate=1e-4,
)

# model 可以是本地路径或 modelscope hub id
base_model = "/root/models/Qwen2.5-14B-Instruct"

# 初始化模型进行 LoRA fine-tuning
model = Swift.prepare_model(base_model, config)

# 如附加更多配置可以组合多个 tuners
# model = Swift.prepare_model(base_model, {'lora': config, ...})

# trainer run 类似 CLI
trainer = Swift(
    model=model,
    dataset="/opt/ml/input/data/datasets/alpaca-cleaned",
    output_dir="/opt/ml/input/models/Qwen2.5-14B-Instruct-ft",
    torch_dtype="bfloat16",
    num_train_epochs=1,
    per_device_train_batch_size=1,
    per_device_eval_batch_size=1,
    gradient_accumulation_steps=16,
    eval_steps=50,
    save_steps=50,
    save_total_limit=5,
    logging_steps=5,
    max_length=2048,
    system="You are a helpful assistant.",
    warmup_ratio=0.05,
    dataloader_num_workers=4,
)
trainer.train()
