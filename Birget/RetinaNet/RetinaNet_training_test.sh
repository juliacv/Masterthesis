#!/bin/bash

#SBATCH --job-name=RetinaNet_training.job
#SBATCH --time=0-100:00:00
#SBATCH --mem-per-cpu=64GB

run=run_test_3
training_directory=/Home/siv31/${USER}/Master_RetinaNet/RetinaNet_training.py;
hyp_directory=/Home/siv31/${USER}/Master_RetinaNet/random_hyp.py;
epochs=2
snapshots=/Home/siv31/${USER}/Master_RetinaNet/snapshots/$run
mkdir $snapshots

#Random hyperparameters
for i in {1..3}; do
    my_tuple=$(python $hyp_directory)
    
    IFS=' '
    read -a strarr<<<"$my_tuple"
    
    lr=${strarr[0]}
    batch_size=${strarr[1]}
    steps=2
    
    snap_save=$snapshots/$i

    #Train using the hyperparameters
    python $training_directory $snap_save $epochs $batch_size $lr $steps 
    echo $lr $batch_size $steps >> $snapshots/hyp_$i.txt

    done
    
exit 0