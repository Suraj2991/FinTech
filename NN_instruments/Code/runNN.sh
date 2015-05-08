#!/bin/bash

for i in 5 10 15 20
do
	echo $i
	for j in 'cgb' 'es' 'fce' 'fdx' 'ffi' 'fgbl' 'fgbm' 'flg' 'fv' 'hsi' 'jgb' 'mc' 'mfxi' 'nq' 're' 'ssi' 'stxe' 'ty' 'us' 'ym'
	do
		th do_all.lua -trainD ../Data/Train_1989-1999_ -validD ../Data/Valid_2000-2004_ -trainP ../Data/Train_Pred_1989-1999_ -validP ../Data/Valid_Pred_2000-2004_ -instr $j -layers 1 -nhidden1 $i -epoch 300
	done
done
