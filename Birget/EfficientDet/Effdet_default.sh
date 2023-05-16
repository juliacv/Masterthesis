#!/bin/bash

#SBATCH --job-name=d_effdet_train.job
#SBATCH --time=0-200:00:00
#SBATCH --mem-per-cpu=100GB

training_directory=/Home/siv31/${USER}/Master_EfficientDet/Effdet_train.py;
hyp_directory=/Home/siv31/${USER}/Master_EfficientDet/Effdet_random_hyp.py;

save_run=run_test_default
epochs=100
min_delta=0.005
patience=5

lr=0.00001 
batch_size=12

#Train the model using the hyperparameters
python $training_directory $save_run $epochs $batch_size $lr 0 $min_delta $patience efficientdet-d0.pth
python $training_directory $save_run $epochs $batch_size $lr 1 $min_delta $patience efficientdet-d1.pth
python $training_directory $save_run $epochs $batch_size $lr 2 $min_delta $patience efficientdet-d2.pth
#python $training_directory $save_run $epochs $batch_size $lr 3 $min_delta $patience efficientdet-d3.pth

#python $training_directory $save_run $epochs $batch_size $lr 4 $min_delta $patience efficientdet-d4.pth
#python $training_directory $save_run $epochs $batch_size $lr 5 $min_delta $patience efficientdet-d5.pth
#python $training_directory $save_run $epochs $batch_size $lr 6 $min_delta $patience efficientdet-d6.pth
#python $training_directory $save_run $epochs $batch_size $lr 7 $min_delta $patience efficientdet-d7.pth
#python $training_directory $save_run $epochs $batch_size $lr 8 $min_delta $patience efficientdet-d8.pth

 