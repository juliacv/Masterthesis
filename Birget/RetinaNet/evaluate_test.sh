#!/bin/bash

#SBATCH --job-name=Evaluate_test.job
#SBATCH --time=0-100:00:00
#SBATCH --mem-per-cpu=50GB
run=run_3

mkdir /Home/siv31/${USER}/Master_RetinaNet/Results/val/$run;

#Evaluate the model with the validation set
Evaluate_Path=/Home/siv31/${USER}/Master_RetinaNet/RetinaNet_evaluate.py;
Validation_Path=/Home/siv31/${USER}/Master_RetinaNet/keras-retinanet/datasets/val_annotations_1.csv

val_save_Path=/Home/siv31/${USER}/Master_RetinaNet/Results/val/$run;
val_file=/Home/siv31/${USER}/Master_RetinaNet/Results/val/$run/val_txt.txt;
Model_Path=/Home/siv31/${USER}/Master_RetinaNet/snapshots/Inference_model/$run;
array=()

cd "snapshots"
cd "Inference_model"
cd "$run"

for epoch in *; do
    cd "$epoch"

    for model in *; do
        echo $model
        directory="$Model_Path/$epoch/$model"
        echo $directory >> $val_file
        python $Evaluate_Path $val_save_Path/$epoch $directory $Validation_Path >> $val_file
        array+=($directory)
        done
    cd ".."
    done

cd ".."
cd ".."
cd ".."

