import pandas as pd
import sys
import numpy as np
dir_res = sys.argv[1]
year = sys.argv[2]
dirs = ['cgb', 'es', 'fce', 'fdx', 'ffi', 'fgbl', 'fgbm', 'flg', 'fv', 'hsi', 'jgb', 'mc', 'mfxi', 'nq', 're', 'ssi', 'stxe', 'ty', 'us', 'ym']
y = pd.DataFrame()

for ds in dirs:
	x = pd.read_csv('../Results/'+dir_res+'/'+ds+'/Output_Predictions_00-04_full_'+ds+'.log', sep = '\t', header = True, usecols = ['Date', 'Predictions', 'Original'])
	x['instr'] = [ds]*len(x)
	y = pd.concat([y,x])

y.to_csv('../Results/final_data_'+ year+'ALL.csv', index = False)
