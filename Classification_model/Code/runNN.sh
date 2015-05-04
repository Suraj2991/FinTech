#!/bin/bash

for i in 5 10 20 30 40 50 60 70 80 90 100 
do
	th do_all.lua -seed 10 -layers 3 -nhidden1 5 -nhidden2 40 -nhidden3 $i  -batchSize 128 -learningRate 0.001 -trainD ../../TCNN_model/Data/Train_1989_1990_1991_1992_1993_1994_1995_1996_.csv -validD ../../TCNN_model/Data/Valid_1997_1998_1999_2000_2001_.csv  -epoch 75

done
