import pandas as pd
import numpy as np

dirs = ['cgb', 'es', 'fce', 'fdx', 'ffi', 'fgbl', 'fgbm', 'flg', 'fv', 'hsi', 'jgb', 'mc', 'mfxi', 'nq', 're', 'ssi', 'stxe', 'ty', 'us', 'ym']
l = ['5_Metrics.log', '10_Metrics.log']
i = 0
n_array = []
for ds in dirs:
	values = []
	argies = []
	
	for files in l:
		x = pd.read_csv(ds+'/'+files)
		argm = np.argmax(np.array(x))
		maxx = x.iloc[argm]
		values.append(maxx)
		argies.append(argm)
	v = np.argmax(values)
	n_array.append((ds, l[v], argies[v] +1, values[v][0]))
	i += 1

y = pd.DataFrame(n_array, columns=['instrument', 'file', 'epochs', 'accuracy'])

y.to_csv('File_Model.csv', index = False)

