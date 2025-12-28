#!/bin/bash

aws s3 cp data/ s3://ictrekbucket1/qwen3/data/ --recursive
aws s3 cp code/ s3://ictrekbucket1/qwen3/code/ --recursive

python3 launch_training.py

