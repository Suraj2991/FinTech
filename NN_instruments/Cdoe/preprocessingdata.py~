import pandas as pd


def updown(x):
    if x >=0:
        return 1
    else:
        return 0




data = pd.read_csv('suraj.filtered.csv')
data['zfret1'] = map(updown, data['zfret1'])

data_group = data.groupby(by='date')

col_list = ['Year', 'date']
Final_data = pd.DataFrame(columns=list(np.unique(data['Instr']))+col_list, index = list(np.unique(data['date'])))
dates = list(np.unique(data['date']))
val = 0
print 'Creating Data with dates'

for ds in dates:
    val += 1
    dates_dict = data_group.get_group(ds)
    dicts = dates_dict[['Instr', 'zfret1'] ].set_index('Instr').T.to_dict('records')
    Final_data.loc[ds] = pd.Series(dicts[0])
    Final_data.loc[ds]['Year'] = int(ds/10000)
    Final_data.loc[ds]['date'] = ds

print 'Filling in NaNs'
for i in range(len(Final_data1)):
    v = Final_data.iloc[i].isnull().sum()
    m = mode(Final_data1.iloc[i])[0][0]
    Final_data1.iloc[i].fillna(value = m, inplace=True)
print 'More NaNs'
for i in range(len(Final_data1)):
    v = Final_data1.iloc[i].notnull()
    m = mode(v)[0][0]
    Final_data1.iloc[i].fillna(value = m, inplace=True)
    
print "Storing Data"
Final_data1.to_csv('Data.all.csv', index = False)
