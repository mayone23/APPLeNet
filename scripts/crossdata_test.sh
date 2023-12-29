#!/bin/bash

cd ../..

# custom config
DATA=/Data
TRAINER=AppleNet

DATASET=$1
SEED=$2

CFG=vit_b16_c4
SHOTS=16
SUB=all

#--load-epoch 50 \

DIR=outputs/crosstransfer/tests/${TRAINER}/${CFG}_shots${SHOTS}/${DATASET}/seed${SEED}
if [ -d "$DIR" ]; then
    echo "The results already exist in ${DIR}"
else
    python train.py \
    --root ${DATA} \
    --seed ${SEED} \
    --trainer ${TRAINER} \
    --dataset-config-file yaml/datasets/${DATASET}.yaml \
    --config-file yaml/trainers/${TRAINER}/${CFG}.yaml \
    --output-dir ${DIR} \
    --model-dir outputs/crosstransfer/patternnet/${TRAINER}/${CFG}_shots${SHOTS}/seed${SEED} \
    --eval-only \
    DATASET.NUM_SHOTS ${SHOTS} \
    DATASET.SUBSAMPLE_CLASSES ${SUB}
fi