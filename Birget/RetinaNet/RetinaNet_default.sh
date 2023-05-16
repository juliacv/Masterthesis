#!/bin/bash

#SBATCH --job-name=d_RetinaNet_default.job
#SBATCH --time=0-200:00:00
#SBATCH --mem-per-cpu=100GB

run=run_default_8

#Training with hyperparameter evolution
training_directory=/Home/siv31/${USER}/Master_RetinaNet/RetinaNet_training.py;
#hyp_directory=/Home/siv31/${USER}/Master_RetinaNet/random_hyp.py;
epochs=500
snapshots=/Home/siv31/${USER}/Master_RetinaNet/snapshots/$run
mkdir $snapshots

    
lr=0.00001
batch_size=16
steps=897

#Train using the hyperparameters
echo $lr $batch_size $steps >> $snapshots/hyp_1.txt
python $training_directory $snapshots/1 $epochs $batch_size $lr $steps
#done

#Convert models to Inference model
Inference_Path=/Home/siv31/${USER}/Master_RetinaNet/to_inference_model.py;
Save_Path=/Home/siv31/${USER}/Master_RetinaNet/snapshots/Inference_model/$run
array=()
array_2=()

#Training to Inference
cd "snapshots"
cd "$run"

for epoch in */; do
    cd "$epoch"
    for model in *; do
        if [[ $model == resnet50* ]]; then
            echo $model
        
            directory="$snapshots/$epoch/$model"
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



#Evaluate the model with the validation set
Evaluate_Path=/Home/siv31/${USER}/Master_RetinaNet/RetinaNet_evaluate.py;
Validation_Path=/Home/siv31/${USER}/Master_RetinaNet/keras-retinanet/datasets/val_annotations_1.csv

val_save_Path=/Home/siv31/${USER}/Master_RetinaNet/Results/val/$run;
mkdir $val_save_Path
val_file=/Home/siv31/${USER}/Master_RetinaNet/Results/val/$run/val_txt.txt;

cd "snapshots"
cd "Inference_model"
cd "$run"

for epoch in */; do
    cd "$epoch"

    for model in *; do
        echo $model
        directory_1="$Save_Path/$epoch/$model"
        echo $directory_1 >> $val_file
        python $Evaluate_Path $val_save_Path/$epoch $directory_1 $Validation_Path >> $val_file
        done
    cd ".."
    done

cd ".."
cd ".."


#Find the model with highest mAP using weighted average precision
modelselection_Path=/Home/siv31/${USER}/Master_RetinaNet/RetinaNet_modelselection.py

python $modelselection_Path $run $val_file

#The directory to the best model
directory_file=/Home/siv31/jng001/Master_RetinaNet/Results/test/$run/detect_info.txt
model_dir_test=$(head -n 1 $directory_file)


#Save the results in a csv file
csv_dir=/Home/siv31/${USER}/Master_RetinaNet/RetinaNet_val_results.csv
best_model_dir=/Home/siv31/${USER}/Master_RetinaNet/best_model_info_2.py

python $best_model_dir $run $csv_dir

