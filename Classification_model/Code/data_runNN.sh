#!/bin/bash

python create_train_valid.py 4,3,2,1991,1992,1993,1994,1995,1996,1997,1998,1999

th do_all.lua -seed 10 -layers 2 -nhidden1 10 -nhidden2 35 -batchSize 500 -learningRate 0.001 -trainD ../Data/Train_1989_1990_1991_1992_1993_.csv -validD ../Data/Valid_1994_1995_1996_1997_1998.csv -testD ../Data/Test_1999_2000_2001_2002.csv
