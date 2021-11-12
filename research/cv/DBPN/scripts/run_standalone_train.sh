#!/bin/bash
# Copyright 2021 Huawei Technologies Co., Ltd
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
if [ $# != 6 ]
then
  echo "==========================================================================="
  echo "Please run the script as: "
  echo "For example:"
  echo "cd DBPN"
  echo "bash scripts/run_standalone_train.sh [DEVICE_ID] [MODEL_TYPE] [TRAIN_GT_PATH] [VAL_GT_PATH] [VAL_LR_PATH] [MODE]"
  echo "bash scripts/run_standalone_train.sh 0 DDBPN /data/DBPN_data/DIV2K_train_HR /data/DBPN_data/Set5/HR /data/DBPN_data/Set5/LR False"
  echo "MODE control the way of trian gan network or only train generator"
  echo "Using absolute path is recommended"
  echo "==========================================================================="
  exit 1
fi

export RANK_ID=0
export RANK_SIZE=1
export SLOG_PRINT_TO_STDOUT=0

mkdir -p ./ckpt/gan
mkdir -p ./ckpt/gen


if [ $6 == "False" ]
then
   python ../train_dbpn.py --device_id=$1  --model_type=$2 --train_GT_path=$3 --val_GT_path=$4 \
                        --val_LR_path=$5 > train.log 2>&1 &
else
   python ../train_dbpngan.py --model_type=DBPN --device_id=$1 --model_type=$2 --train_GT_path=$3 --val_GT_path=$4 \
                         --val_LR_path=$5 > train.log 2>&1 &
fi

