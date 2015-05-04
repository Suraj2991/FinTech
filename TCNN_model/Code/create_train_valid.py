import pandas as pd
import numpy as np
import sys

def class1(x):
	if x >= 0:
		return 2
	else:
		return 1
# up  and down
#6628 and 5947
#7153 and 5729
def class0(x):
	if x >= 0:
		return 1
	else:
		return 0

if len(sys.argv)>1:
	y = sys.argv[1]

	#input 
	# python create_train_valid.py (no. of training years),(no.of test years),yr1,yr2....
	# python create_train_valid.py 2,2,1,1992,1993,1994,1995,1996
	y = map(int,y.split(','))
	print y
	no_tr = y[0]
	no_vd = y[1]
	no_ts = y[2]

	Train = []
	Valid = []
	Test = []
	for i in range(no_tr):
		Train.append(y[3+i])
	for j in range(no_vd):
		Valid.append(y[3+no_tr+j])
	for k in range(no_ts):
		Test.append(y[3+no_tr+no_vd+k])
else:
	Train = [1991, 1992, 1993, 1994]
	Valid = [1995, 1996, 1997]
	Test = [1998,1999]
print Train, Valid, Test

print('Read Data')
data  = pd.read_csv('../Data/Final_new_dataset.csv', index_col = 'Years')
f = open('../Data/col_names.txt', 'r')
c = f.readlines()
f.close()
cols = []
cols.append('date')
for i in c:
	cols.append(i.split('\n')[0])

data  = pd.read_csv('../Data/Final_new_dataset.csv', index_col = 'Years')
#cols = ['ret1', 'sigmaret1', 'zfret1']

#cols.append('zfret0')
output_data = data['zfret1']
data['zfret1'] = map(class1,output_data)
#data['zfret0'] = map(class0, output_data)
#data['ret1'] = map(class0,output_data)
print 'Creating Training Dataset'
train_data = data.ix[Train]



print 'Creating Validation Dataset'
valid_data = data.ix[Valid]

print 'Creating Test Dataset'
test_data = data.ix[Test]

name_tr = '_'.join(map(str, Train))
name_vd = '_'.join(map(str, Valid))
name_ts = '_'.join(map(str, Test))

print 'Storing Training, Validation and Test files'
train_data[cols].to_csv('../Data/Train_'+name_tr+'_.csv', index = False)
valid_data[cols].to_csv('../Data/Valid_'+name_vd+'_.csv', index = False)
test_data[cols].to_csv('../Data/Test_'+name_ts+'_.csv', index = False)




