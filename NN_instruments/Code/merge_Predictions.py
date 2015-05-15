import pandas as pd
import numpy as np
dirs = ['cgb', 'es', 'fce', 'fdx', 'ffi', 'fgbl', 'fgbm', 'flg', 'fv', 'hsi', 'jgb', 'mc', 'mfxi', 'nq', 're', 'ssi', 'stxe', 'ty', 'us', 'ym']
y = pd.DataFrame()
for ds in dirs:
	x = pd.read_csv(ds+'/Output_Predictions_05-07'+ds+'.log', sep = '\t', header = True, usecols = ['Date', 'Predictions', 'Original'])
	x['instr'] = [ds]*len(x)
	y = pd.concat([y,x])
import pdb; pdb.set_trace()	
