def random_hyp():
    import random
    import numpy.random as nr
    

    lr_range = [0.000001, 0.00001, 0.0001, 0.001]
    batch_size_range = [8, 16, 32, 64]
    
    lr = random.choice(lr_range)
    batch_size = random.choice(batch_size_range)
    steps = int(14364/batch_size)
    
    return lr, batch_size, steps

lr, batch_size, steps = random_hyp()
print(lr, batch_size, steps)