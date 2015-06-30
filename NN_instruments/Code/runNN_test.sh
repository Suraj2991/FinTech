#!/bin/bash

th do_all.lua -trainD Train_1989-2004_ -validD Valid_2005-2007_ -trainP Train_Pred_1989-2004_ -validP Valid_Pred_2005-2007_ -instr 'cgb' -layers 1 -nhidden1 45 -epoch 3

th do_all.lua -trainD Train_1989-2004_ -validD Valid_2005-2007_ -trainP Train_Pred_1989-2004_ -validP Valid_Pred_2005-2007_ -instr 'es' -layers 1 -nhidden1 80 -epoch 1

th do_all.lua -trainD Train_1989-2004_ -validD Valid_2005-2007_ -trainP Train_Pred_1989-2004_ -validP Valid_Pred_2005-2007_ -instr 'fce' -layers 1 -nhidden1 45 -epoch 300

th do_all.lua -trainD Train_1989-2004_ -validD Valid_2005-2007_ -trainP Train_Pred_1989-2004_ -validP Valid_Pred_2005-2007_ -instr 'fdx' -layers 1 -nhidden1 80 -epoch 255

th do_all.lua -trainD Train_1989-2004_ -validD Valid_2005-2007_ -trainP Train_Pred_1989-2004_ -validP Valid_Pred_2005-2007_ -instr 'ffi' -layers 1 -nhidden1 5 -epoch 14

th do_all.lua -trainD Train_1989-2004_ -validD Valid_2005-2007_ -trainP Train_Pred_1989-2004_ -validP Valid_Pred_2005-2007_ -instr 'fgbl' -layers 1 -nhidden1 45 -epoch 3

th do_all.lua -trainD Train_1989-2004_ -validD Valid_2005-2007_ -trainP Train_Pred_1989-2004_ -validP Valid_Pred_2005-2007_ -instr 'fgbm' -layers 1 -nhidden1 45 -epoch 3

th do_all.lua -trainD Train_1989-2004_ -validD Valid_2005-2007_ -trainP Train_Pred_1989-2004_ -validP Valid_Pred_2005-2007_ -instr 'flg' -layers 1 -nhidden1 60 -epoch 52

th do_all.lua -trainD Train_1989-2004_ -validD Valid_2005-2007_ -trainP Train_Pred_1989-2004_ -validP Valid_Pred_2005-2007_ -instr 'fv' -layers 1 -nhidden1 45 -epoch 3

th do_all.lua -trainD Train_1989-2004_ -validD Valid_2005-2007_ -trainP Train_Pred_1989-2004_ -validP Valid_Pred_2005-2007_ -instr 'hsi' -layers 1 -nhidden1 10 -epoch 125

th do_all.lua -trainD Train_1989-2004_ -validD Valid_2005-2007_ -trainP Train_Pred_1989-2004_ -validP Valid_Pred_2005-2007_ -instr 'jgb' -layers 1 -nhidden1 25 -epoch 142

th do_all.lua -trainD Train_1989-2004_ -validD Valid_2005-2007_ -trainP Train_Pred_1989-2004_ -validP Valid_Pred_2005-2007_ -instr 'mc' -layers 1 -nhidden1 10 -epoch 27

th do_all.lua -trainD Train_1989-2004_ -validD Valid_2005-2007_ -trainP Train_Pred_1989-2004_ -validP Valid_Pred_2005-2007_ -instr 'mfxi' -layers 1 -nhidden1 40 -epoch 126

th do_all.lua -trainD Train_1989-2004_ -validD Valid_2005-2007_ -trainP Train_Pred_1989-2004_ -validP Valid_Pred_2005-2007_ -instr 'nq' -layers 1 -nhidden1 10 -epoch 8

th do_all.lua -trainD Train_1989-2004_ -validD Valid_2005-2007_ -trainP Train_Pred_1989-2004_ -validP Valid_Pred_2005-2007_ -instr 're' -layers 1 -nhidden1 40 -epoch 2

th do_all.lua -trainD Train_1989-2004_ -validD Valid_2005-2007_ -trainP Train_Pred_1989-2004_ -validP Valid_Pred_2005-2007_ -instr 'ssi' -layers 1 -nhidden1 10 -epoch 167

th do_all.lua -trainD Train_1989-2004_ -validD Valid_2005-2007_ -trainP Train_Pred_1989-2004_ -validP Valid_Pred_2005-2007_ -instr 'stxe' -layers 1 -nhidden1 80 -epoch 159

th do_all.lua -trainD Train_1989-2004_ -validD Valid_2005-2007_ -trainP Train_Pred_1989-2004_ -validP Valid_Pred_2005-2007_ -instr 'ty' -layers 1 -nhidden1 45 -epoch 3

th do_all.lua -trainD Train_1989-2004_ -validD Valid_2005-2007_ -trainP Train_Pred_1989-2004_ -validP Valid_Pred_2005-2007_ -instr 'us' -layers 1 -nhidden1 45 -epoch 3

th do_all.lua -trainD Train_1989-2004_ -validD Valid_2005-2007_ -trainP Train_Pred_1989-2004_ -validP Valid_Pred_2005-2007_ -instr 'ym' -layers 1 -nhidden1 80 -epoch 64

