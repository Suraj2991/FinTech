import os
import sys
import matplotlib.pyplot as plt
import pandas as pd
import glob

args_in = (sys.argv)
print args_in
name_file = args_in[1]
base_d = args_in[2]

basedir = '/home/suraj2991/Deeper/Results/'+base_d
print basedir
X_val, Y_val = [], []
df = []
for root, dirs, files in os.walk(basedir):
	files = glob.glob(os.path.join(root, '*.log'))
	for f in files:
		file_log = open(f, 'r')
		results = file_log.readlines()
		layer3 = f.split('_')[-1]
		file_log.close()
		print layer3
		print '---'
		df.append((float(results[1]), float(results[2]), float(results[3]), float(results[4]), float(layer3.split('.')[0])))
print df
fin_data = pd.DataFrame(df, columns = ['error', 'layer1', 'layer2', 'epochs', 'layer3'] )
new_data = fin_data.sort(columns = 'layer2')
print new_data.sort(columns = 'error')
ax = new_data.plot(x = 'layer2', y ='error')
plt.ylim([min(new_data['error']), max(new_data['error'])])
new_data.to_csv(basedir+'/'+name_file, index=False)
plt.xlabel('Complexity')
plt.title('Error-complexity')
fig = ax.get_figure()
fig.savefig(basedir+'/'+base_d+'.png')
print 'Minimum error'
print new_data[new_data['error'] == min(new_data['error'])]





