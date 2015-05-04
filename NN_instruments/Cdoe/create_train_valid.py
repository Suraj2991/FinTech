import pandas as pd
import numpy as np

def rename(k, col):
	col_k = []
	for c in col:
		col_k.append(c+str(k))
	return col_k

def create_dataset(window, data, cols):

	datas = data[cols]
	final_data_pred= pd.DataFrame(np.zeros((len(datas) - window-1, 2)))
	final_array = np.zeros((len(datas)-window-1, 20*window))
	print "Creating Dataset"
	for i in range(len(datas) - window -1):

    	    lists = []
	    for w in range(window):
		lists.append(datas.iloc[w+i])
	
	    window_data = pd.Series()
	    for v in lists:
	        window_data = window_data.append(v)

    	    final_array[i] = np.array(window_data)
	    final_data_pred.loc[i] = np.array(data.iloc[w+i+1][['date', 'zzpred']])
	    
	assert len(final_array) == len(final_data_pred)
	print "Length",len(final_array)

   	Col = []
	for w in range(window):
	    	Col += rename(w+1, cols)
	assert len(final_array[1]) == len(Col)

	print "Total Cols", len(Col)
	final_data = pd.DataFrame(final_array, columns = Col)
	return final_data, final_data_pred

def main(wind, Train, Valid):

	data = pd.read_csv('../Data/Data.all.csv', index_col = 'Year')
	cols_list = data.columns[:-1]
	print len(cols_list)

	instr = 'es'
	data['zzpred'] = data[instr]+1

	train_data, train_data_pred = create_dataset(wind, data.ix[Train], cols_list)
	print "Train done"

	valid_data, valid_data_pred = create_dataset(wind, data.ix[Valid], cols_list)
	print "Valid done"

import sys

if len(sys.argv)>1:
	y = sys.argv[1]

	#input 
	# python create_train_valid.py (no. of training years),(no.of test years),yr1,yr2....
	# python create_train_valid.py 2,2,1,1992,1993,1994,1995,1996
	
	y = map(int,y.split(','))
	print y
	no_tr = y[1]
	no_vd = y[2]

	train = []
	valid = []
	for i in range(no_tr):
		train.append(y[3+i])
	for j in range(no_vd):
		valid.append(y[3+no_tr+j])
	wind = y[0]


else:
	train = [1989,1990,1991,1992,1993,1994,1995,1996,1997,1998,1999]
	valid = [2000,2001,2002,2003,2004]
	wind = 5



main(wind, train, valid)
