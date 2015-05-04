#!/bin/bash

for j in 5 10 20 35 40 50 60 
do 
	i=`python trial.py $j`
	echo $i
	th do_all.lua -seed 10 -layers 1 -nhidden1 $j -nhidden2 35 -batchSize 7 -learningRate 0.001 -trainD ../Data/1989_2001.csv -validD ../Data/Test_2002_2003_2004_2005_.csv  -epoch $i

done
