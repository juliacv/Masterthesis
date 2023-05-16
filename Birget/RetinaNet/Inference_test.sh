#!/bin/bash

#SBATCH --job-name=Inference_test.job
#SBATCH --time=0-100:00:00
#SBATCH --mem-per-cpu=50GB

run=run_test_3

Inference_Path=/Home/siv31/${USER}/Master_RetinaNet/to_inference_model.py;
Model_Path=/Home/siv31/${USER}/Master_RetinaNet/snapshots/$run #resnet50_csv_03.h5;
Save_Path=/Home/siv31/${USER}/Master_RetinaNet/snapshots/Inference_model/$run #/resnet50_csv_03.h5;
array=()
array_2=()

#Training to Inference
cd "snapshots"
cd "$run"

for epoch in *; do
    cd "$epoch"
    for model in *; do
        if [[ $model == resnet50* ]]; then
            echo $model
        
            directory="$Model_Path/$epoch/$model"
            save_dir="$Save_Path/$epoch/$model"
            array+=($directory)
            array_2+=($save_dir)
            fi
        done
    cd ".."
    done

cd ".."
cd ".."

for dir in "${!array[@]}"; do
    echo ${array[dir]}, ${array_2[dir]}
    python $Inference_Path ${array[dir]} ${array_2[dir]}
    done