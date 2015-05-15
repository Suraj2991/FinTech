import pandas as pd
import numpy as np



def create_big_data(file1, file2):
	dirs = ['cgb', 'es', 'fce', 'fdx', 'ffi', 'fgbl', 'fgbm', 'flg', 'fv', 'hsi', 'jgb', 'mc', 'mfxi', 'nq', 're', 'ssi', 'stxe', 'ty', 'us', 'ym']

	y = pd.DataFrame()
	for fs in dirs:
		x_init = pd.read_csv(fs+'/'+file1+ fs+'.csv')
		x_pred = pd.read_csv(fs + '/' + file2+ fs + '.csv')
	
		x = x_init.join(x_pred)
	
		y = pd.concat([x,y])

	final_data = y.sort(columns = '0')
	final_data_1 = final_data[y.columns[:-2]]
	final_data_2 = final_data[['0', '1']]
	return final_data_1, final_data_2

final_data_train, final_data_pred_t = create_big_data('Train_1989-2004_', 'Train_Pred_1989-2004_')

final_data_valid, final_data_pred_v = create_big_data('Valid_2005-2007_', 'Valid_Pred_2005-2007_')

final_data_train.to_csv('../Data/Train_1989-2004_all.csv', index = False)
final_data_pred_t.to_csv('../Data/Train_Pred_1989-2004_all.csv', index= False)


final_data_valid.to_csv('../Data/Valid_2005-2009_all.csv', index = False)
final_data_pred_v.to_csv('../Data/Valid_Pred_2005-2009_all.csv', index = False)


