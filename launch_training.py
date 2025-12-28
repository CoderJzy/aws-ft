from sagemaker.huggingface import HuggingFace
from sagemaker.pytorch import PyTorch
import sagemaker

role = "arn:aws:iam::111490975521:role/service-role/AmazonSageMaker-ExecutionRole-20250723T143035"
bucket = "ictrekbucket1"
prefix = "qwen3"
instance_type="ml.g5.xlarge"

sess = sagemaker.Session()
# 需要上脚本上传时再上传
sess.upload_data(path="data", bucket=bucket, key_prefix=f"{prefix}/data")
sess.upload_data(path="code", bucket=bucket, key_prefix=f"{prefix}/code")

estimator = PyTorch(
    entry_point="train_qwen3_lora.py",
    source_dir=f"./code",
    role=role,
    framework_version="2.7.1",
    py_version="py312",
    instance_type="ml.g5.xlarge",  # 測试用
    instance_count=1,
    hyperparameters={"MODEL_ID": "Qwen/Qwen2.5-1.5B"},
    output_path="s3://ictrekbucket1/qwen3/output/"
)

estimator.fit({"train": f"s3://{bucket}/{prefix}/data"})