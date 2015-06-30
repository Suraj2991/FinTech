import pandas as pd
import numpy as np

#dirs = ['cgb', 'es', 'fce', 'fdx', 'ffi', 'fgbl', 'fgbm', 'flg', 'fv', 'hsi', 'jgb', 'mc', 'mfxi', 'nq', 're', 'ssi', 'stxe', 'ty', 'us', 'ym']
import sys
dir_res = sys.argv[1]
year = sys.argv[2]
dirs = ['all']
#l = ['5_Metrics_test','15_Metrics_test','10_Metrics_test','20_Metrics_test']
l = ['5_Metrics_test','15_Metrics_test','10_Metrics_test','20_Metrics_test','25_Metrics_test', '30_Metrics_test', '35_Metrics_test', '40_Metrics_test', '45_Metrics_test', '50_Metrics_test', '60_Metrics_test', '70_Metrics_test', '80_Metrics_test', '90_Metrics_test', '100_Metrics_test' ]
i = 0
n_array = []
for ds in dirs:
	values = []
	argies = []
	
	for files in l:
		x = pd.read_csv('../Results/' + dir_res+'/'+ds+'/'+files+year+'.log')
		argm = np.argmax(np.array(x))
		maxx = x.iloc[argm]
		values.append(maxx)
		argies.append(argm)
	print ds
	print values
	v = np.argmax(values)
	n_array.append((ds, l[v], argies[v] +1, values[v][0]))
	i += 1

y = pd.DataFrame(n_array, columns=['instrument', 'file', 'epochs', 'accuracy'])

y.to_csv('../Results/' + dir_res + '/'+ 'File_ModelALL.csv', index = False)

