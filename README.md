# Master thesis
This repository includes code and examples for Julia Nguyen's master thesis. The description of how to run the codes and the data of the codes is explained in Appendix A in the master thesis. 

## Preprocessing Folder 
The preprocessing folder includes codes for transformations of annotations for each of the models. For Yolo, the file *Final_data.ipynb* includes data augmentation, upscaling and resizing the data as well. 

## Birget Folder 
The folder includes all codes for running Yolov5, RetinaNet and EfficientDet on Birget slurm controller. *yolo_env.yml*, *ret_env.yml* and *eff_env.yml* are the conda enviroments used for each object detection model. 

The training, validation and detection python files uses the belonging training, validation and detection files of the original repositories and are meant to be used together with the bash files. The parameter run/save_run/direct in the different files, are the name of the folder where the results will be saved. This should be changed for each run of the code. 

### Yolo
For Yolo the files *Yolov5_loop_trainval.sh*, *Yolov5_defaultvalues.sh* and *Yolov5_finalmodel.sh* are the most important files to run for a full model selection and model evaluation process. 
- *Yolov5_loop_trainval.sh* includes a loop with training of the five different pretrained weights, random search of hyperparameters, validation of the the models with validation data, and detection on the validation data.
- *Yolov5_defaultvalues.sh* is the same loop, but default values of the hyperparameters (the flipping hyperparameters are still set to 0)
- *Yolov5_finalmodel.sh* is the validation and detection process for the final model on the test set. 

Yolo has a folder named "Other" as well. This folder contains the sligthly changed validation code for Yolov5, *val.py*,to be able to print out the metrics and use the metrics further into the training and validation loop. The folder also includes the files *request_1.yaml* and *hyp.scratch-low.yaml*. The first file is the yaml file for the Request dataset with paths to the images, labels and the number of classes with names. This files should be moved to *yolov5/data* after the original repository is cloned. The second file, is the file with the default hyperparameters used in this thesis. 

### RetinaNet
For RetinaNet the *csv_path.ipynb* is a notebook to change the path to the images in the label csv files. This should be ran first, to make sure the labels are right. The validation/evaluation code for RetinaNet has also been slightly changed to print out the values to do model selection, *evaluate.py* can be used instead of the file from the original repository. 

The files *RetinaNet_loop_trainval.sh* and *RetinaNet_defualt.sh* are the most important files in this folder.
- *RetinaNet_loop_trainval.sh* includes the loop with training, inference and validation on the validation data. 
- *RetinaNet_defualt.sh* is the same loop but with default hyperparameters. 

### EfficientDet
For EfficientDet a loop with both training and validation was not implemented. Training and validation must therefore be ran individually. 
- *training_test.sh* and *Effdet_default.sh* are the training codes for random hyperparameter search and defaultvalues. The eight different pretrained weights are included, but only the three first was used. 
- *validation_test.sh* is the validation file to use after the training.

## Exploratory Data Analysis Folder 
This folder includes code for plotting and analysis of the data. There are different jupyter notebooks for the different plots. 
- *Data_aug_test.ipynb* is for testing different data augmentation methods on one ultrasound image.
- *Upscale_test.ipynb* is for checking if the annotations is right after upscaling and resizing the images.
- *Visualiza_bboxes.ipynb* visualizes the boxes, after data augmentation with annotations from Medistim and annotations after Yolo convertion. 
- *plots.ipynb* is used for data exploration. The numbers can be found after running the *Final_data.ipynb* in the preprocessing folder for Yolo.
- *test_of_plot.ipynb* This was used for testing plotting ground truth from Yolo labels.
- *truth_predicted.ipynb* is the notebook used to plot the ground truth and predicted bounding boxes side by side after model evaluation. 

