print '==> executing all'
require 'optim'
require 'torch'
cmd = torch.CmdLine()
cmd:text()
cmd:text('Options')
cmd:option('-seed', 10, 'fixed input seed for repeatable experiments')
cmd:option('-save', 'Results', 'subdirectory to save/log experiments in')
cmd:option('-learningRate', 1e-3, 'learning rate at t=0')
cmd:option('-batchSize', 14, 'mini-batch size (1 = pure stochastic)')
cmd:option('-epoch', 10000, 'Number of Iterations')
cmd:option('-layers',1,'Number of layers in the Neural Network')
cmd:option('-nhidden1',131,'Number of hidden neurons in 1st Layer')
cmd:option('-nhidden2',0,'Number of hidden neurons in 2nd Layer')
cmd:option('-nhidden3',0,'Number of hidden neurons in 3rd Layer')
cmd:option('-nhidden4',0,'Number of hidden neurons in 4th Layer')
cmd:option('-nhidden5',0,'Number of hidden neurons in 5th Layer')
cmd:option('-nhidden6',0,'Number of hidden neurons in 6th Layer')
cmd:option('-trainD', '../Data/Train_1992_1993_1994_1995.csv', 'Train dataset directory+file')
cmd:option('-validD', '../Data/Valid_1996_1997_1998.csv', 'Valid dataset directory+file')
cmd:option('-testD', '../Data/Test_1996_1997.csv', 'Test dataset directory+file')
cmd:option('-DataName', '1', 'Test dataset directory+file')

cmd:text()
opt = cmd:parse(arg or {})
torch.manualSeed(opt.seed)



dofile '1_data.lua'

dofile '2_model.lua'
dofile '3_loss.lua'
dofile '4_train.lua'
dofile '5_test.lua'


local i = 1
x = {}
y = {}
--trainLogger = optim.Logger(paths.concat('../Results/Final' .. opt.nhidden1  .. opt.nhidden2 .. '.log'))
trainMetrics = optim.Logger(paths.concat('../Results/Predictions/' .. opt.nhidden1 .. '_' .. opt.nhidden2 ..'_' .. opt.nhidden3 ..   'Metrics.log'))
while i<=opt.epoch do
	x[i], y[i] = train()
	trainMetrics:add{x[i], y[i]}
	
	
  	i = i+1

end
test()
filename = 'modelNN1997_2001.net' 
torch.save(filename, model, 'ascii')
--print('\n=> Should retrain for ' .. i-1 .. ' Iterations to get Validation error of ' .. y[i-1])	
print('\n Architecture')
--opt['epoch']=i
print(opt)
--trainLogger:add{string.format("%8f",y[i-2])}
--trainLogger:add{opt.nhidden1}
--trainLogger:add{opt.nhidden2}
--trainLogger:add{opt.epoch}
	  







