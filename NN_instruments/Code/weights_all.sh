#!/bin/bash
for j in 'cgb'  'es' 'fce' 'fdx' 'ffi' 'fgbl' 'fgbm' 'flg' 'fv' 'hsi' 'jgb' 'mc' 'mfxi' 'nq' 're' 'ssi' 'stxe' 'ty' 'us' 'ym'
do
	th createWeights.lua -layers 1 -instrument $j
done

