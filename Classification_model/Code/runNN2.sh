#!/bin/bash

for i in 70 80 90 100 110 120 130 
do
	th do_all.lua -seed 10 -layers 2 -nhidden1 $i -nhidden2 35 -batchSize 7 -learningRate 0.001 -trainD ../Data/Train_1989_1990_1991_1992_1993_1994_1995_1996_.csv -validD ../Data/Valid_1997_1998_1999_2000_2001_.csv  -epoch 200

done
