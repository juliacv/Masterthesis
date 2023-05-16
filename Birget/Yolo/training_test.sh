#!/bin/bash

#SBATCH --job-name=train_test.job
#SBATCH --time=0-100:00:00
#SBATCH --mem-per-cpu=10GB


training_directory=/Home/siv31/${USER}/Master_Julia/Yolov5_training.py;
hyp_directory=/Home/siv31/${USER}/Master_Julia/Yolov5_randomesearch.py;
save_run=runs1
epochs=3
patience=5

for i in {1..2}; do
    my_tuple=$(python $hyp_directory)
    
    IFS=' '
    read -a strarr<<<"$my_tuple"
    
    lr0=${strarr[0]}
    momentum=${strarr[1]}
    weight_decay=${strarr[2]}
    flipud=${strarr[3]}
    fliplr=${strarr[4]}
   
    #Train the model using the hyperparameters
   python $training_directory hyp yolov5x $lr0 $momentum $weight_decay $flipud $fliplr $save_run/train $epochs $patience
 
    done
