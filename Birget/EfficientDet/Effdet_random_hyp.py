def random_hyp():
    import random
    
    lr_range = [0.000001, 0.00001, 0.0001, 0.001]
    lr = random.choice(lr_range)
    
    batch_size_range = [4, 8, 12, 16]
    batch_size = random.choice(batch_size_range)
   
    return lr, batch_size

lr, batch_size = random_hyp()
print(lr, batch_size)