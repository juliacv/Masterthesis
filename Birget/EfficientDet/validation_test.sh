#!/bin/bash

#SBATCH --job-name=val_test.job
#SBATCH --time=0-100:00:00
#SBATCH --mem-per-cpu=10GB

#Run nummer
run=run_test_3

#Validation files
validation_directory=/Home/siv31/${USER}/Master_EfficientDet/Effdet_val.py;
mkdir /Home/siv31/${USER}/Master_EfficientDet/val/$run/
save_txt=/Home/siv31/${USER}/Master_EfficientDet/val/$run/val_output.txt
compound_directory=/Home/siv31/${USER}/Master_EfficientDet/Effdet_compound.py;
compound_file=/Home/siv31/${USER}/Master_EfficientDet/logs/$run/Request/Effdet_compound.txt;

array=()
array_2=()

cd "logs"
cd "$run"
cd "Request"

for f in *.pth; do
    echo $f
    directory=/Home/siv31/${USER}/Master_EfficientDet/logs/$run/Request/$f
    array+=($directory)
    
    python $compound_directory $f
    
    #The directory to the best model
    comp=$(head -n 1 $compound_file)
    array_2+=($comp)
    done

cd ".."
cd ".."
cd ".."

#Find compound_coeff

echo $array

for dir in "${!array[@]}"; do
    echo ${array[dir]} >> $save_txt
    python $validation_directory ${array[dir]} ${array_2[dir]} >> $save_txt
    done
    

exit 0