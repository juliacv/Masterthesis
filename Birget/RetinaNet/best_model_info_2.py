import csv
import sys

run = sys.argv[1]
csv_dir = sys.argv[2] #/Home/siv31/jng001/Master_RetinaNet/RetinaNet_val_results.csv

#Read test file
test_file_dir = f"/Home/siv31/jng001/Master_RetinaNet/Results/val/{run}/val_txt.txt"
with open(f"{test_file_dir}", "r") as test_file:
    line_array = test_file.readlines()
    
    model_array = line_array[0].replace("\n","").split("/")
    model = model_array[9]
    best_epoch = model_array[8]
    
    mAP_wap_array = line_array[2].replace("\n","").replace(" ", "").split(":")
    mAP_wap = float(mAP_wap_array[1])
    
    mAP_array = line_array[3].replace("\n","").replace(" ", "").split(":")
    mAP = float(mAP_array[1])
test_file.close()


#FINN NUMBER fra MODEL ex. resnet50_csv_01.h5
#num = model.split(".")
#num_2 = num[0].split("_")
#number = int(num_2[2])

#Read hyp file
hyp_dir = f"/Home/siv31/jng001/Master_RetinaNet/snapshots/{run}/hyp_{best_epoch}.txt"
    
with open (f"{hyp_dir}", "r") as hyp_file:
    line = hyp_file.readlines()
    print(line)
    line = line[0].replace("\n","").replace("[","").replace("]","").replace("'", "").split(" ")
    print(line)
    lr = float(line[0])
    batch = line[1]
    steps = line[2]

#Text file with information
train_line = f"The model that had the best results was {model} on run {run} on epoch number {best_epoch}"
hyperparameter_line = f"The hyperparameters tuned was, learning rate lr: {lr}, \n batch size: {batch}, \n and steps in each epoch: {steps}"
results_line = f"For the best model mAP with weighted average precision was {mAP_wap} and mAP was {mAP}.\n"


#Write everything to file
info_file = open(f"/Home/siv31/jng001/Master_RetinaNet/Results/test/{run}/RetinaNet_val_results.txt", "w")
info_file.write(train_line)
info_file.write("\n")
info_file.write(hyperparameter_line)
info_file.write("\n")
info_file.write(results_line)
info_file.close()

#CSV file with the information
Header = ["Runs", "best_epoch", "Best model", "lr", "Batch", "Steps", "mAp_wap", "mAP"]
data = [run, best_epoch, model, lr, batch, steps, mAP_wap, mAP]

with open(f"{csv_dir}", "a") as csv_file:
    writer = csv.writer(csv_file)
    #writer.writerow(Header)
    writer.writerow(data)
    
    csv_file.close()
    




