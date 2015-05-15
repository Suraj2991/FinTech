#!/bin/bash


#
for i in 20
do
	echo $i
	for j in 'cgb' 'es' 'fce' 'fdx' 'ffi' 'fgbl' 'fgbm' 'flg' 'fv' 'hsi' 'jgb' 'mc' 'mfxi' 'nq' 're' 'ssi' 'stxe' 'ty' 'us' 'ym'
	do
		th do_all.lua -trainD Train_1989-1999_ -validD Valid_2000-2004_ -trainP Train_Pred_1989-1999_ -validP Valid_Pred_2000-2004_ -instr $j -layers 1 -nhidden1 $i -epoch 33 -batchSize 60
	done
done
