#!/bin/bash

#SBATCH --job-name=RetinaNet_loop.job
#SBATCH --time=0-100:00:00
#SBATCH --mem-per-cpu=4GB

run=run_default_8
csv_dir=/Home/siv31/${USER}/Master_RetinaNet/RetinaNet_val_results.csv
best_model_dir=/Home/siv31/${USER}/Master_RetinaNet/best_model_info_2.py


python $best_model_dir $run $csv_dir