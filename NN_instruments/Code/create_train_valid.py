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

def main(wind, Train, Valid, col):

	data = pd.read_csv('../Data/Data.all.csv', index_col = 'Year')
	cols_list = data.columns[:-1]
	print len(cols_list)

	instr = col
	data['zzpred'] = data[instr]+1

	train_data, train_data_pred = create_dataset(wind, data.ix[Train], cols_list)
	print "Train done"

	valid_data, valid_data_pred = create_dataset(wind, data.ix[Valid], cols_list)
	print "Valid done"
	
	train_data.to_csv('../Data/' + instr + '/Train_'+str(Train[0])+'-'+str(Train[-1])+'_' + instr+'.csv', index = False)
	train_data_pred.to_csv('../Data/' + instr + '/Train_Pred_'+str(Train[0])+'-'+str(Train[-1])+'_' + instr+'.csv', index = False)


	valid_data.to_csv('../Data/' + instr + '/Valid_'+str(Valid[0])+'-'+str(Valid[-1])+'_' + instr+'.csv', index = False)
	valid_data_pred.to_csv('../Data/'+ instr + '/Valid_Pred_'+str(Valid[0])+'-'+str(Valid[-1])+'_' + instr+'.csv', index = False)


import sys

if len(sys.argv[1].split(','))>3:
	y = sys.argv[1]

	#input 
	# python create_train_valid.py (no. of training years),(no.of test years),yr1,yr2....
	# python create_train_valid.py 5,2,2,1,1992,1993,1994,1995,1996,es
	
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
	col = y[-1]

else:
	train = [1989,1990,1991,1992,1993,1994,1995,1996,1997,1998,1999,2000,2001,2002,2003,2004]
	valid = [2005,2006,2007]
	if len(sys.argv[1].split(',')) :
		wind = int(sys.argv[1].split(',')[0])
		col = sys.argv[1].split(',')[1]

cols = ['fce', 'cgb', 'es','fce', 'fdx','ffi','fgbl','fgbm','flg','fv','hsi','jgb','mc','mfxi','nq','re','ssi','stxe','ty','us','ym']
for co in cols:

	main(wind, train, valid, str(co))
