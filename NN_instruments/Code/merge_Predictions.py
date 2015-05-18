import pandas as pd
import numpy as np
dirs = ['cgb', 'es', 'fce', 'fdx', 'ffi', 'fgbl', 'fgbm', 'flg', 'fv', 'hsi', 'jgb', 'mc', 'mfxi', 'nq', 're', 'ssi', 'stxe', 'ty', 'us', 'ym']
y = pd.DataFrame()
for ds in dirs:
	x = pd.read_csv(ds+'/Output_Predictions_00-04_full_'+ds+'.log', sep = '\t', header = True, usecols = ['Date', 'Predictions', 'Original'])
	x['instr'] = [ds]*len(x)
	y = pd.concat([y,x])

y.to_csv('final_data_all_00-04.csv', index = False)
