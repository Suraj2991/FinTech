print '==> executing all'
require 'optim'
require 'torch'
cmd = torch.CmdLine()
cmd:text()
cmd:text('Options')

cmd:option('-seed', 10, 'fixed input seed for repeatable experiments')
cmd:option('-save', 'Results', 'subdirectory to save/log experiments in')
cmd:option('-learningRate', 1e-3, 'learning rate at t=0')

cmd:option('-batchSize', 128, 'mini-batch size (1 = pure stochastic)')
cmd:option('-epoch', 50, 'Number of Iterations')


cmd:option('-trainD', '../Data/Train_1989_1990_1991_1992_1993_1994_1995_1996_1997_1998_1999_2000_2001_.csv', 'Train dataset directory+file')
cmd:option('-validD', '../Data/Valid_2002_2003_2004_2005_2006_2007_.csv', 'Valid dataset directory+file')
cmd:option('-testD', '../Data/Test_2008_2009_.csv', 'Test dataset directory+file')

cmd:option('-DataName', '1', 'Test dataset directory+file')

cmd:text()
opt = cmd:parse(arg or {})
torch.manualSeed(opt.seed)



dofile '1_data.lua'

dofile '2_model.lua'
dofile '3_loss.lua'
dofile '4_train.lua'
dofile '5_test.lua'

local ep = 1
x = {}
y = {}
--trainLogger = optim.Logger(paths.concat('../Results/Final' .. opt.nhidden1  .. opt.nhidden2 .. '.log'))
trainMetrics = optim.Logger(paths.concat('../Results/1stTry'  .. '_' ..  'Metrics.log'))


print(opt.epoch)
while ep<=opt.epoch do
	x[ep], y[ep] = train()
	trainMetrics:add{x[ep], y[ep]}
  	ep = ep+1

end
test()

--filename = 'model.net' .. opt.epoch
--torch.save(filename, model)
--print('\n=> Should retrain for ' .. i-1 .. ' Iterations to get Validation error of ' .. y[i-1])	
print('\n Architecture')
--opt['epoch']=i
print(opt)
--trainLogger:add{string.format("%8f",y[i-2])}
--trainLogger:add{opt.nhidden1}
--trainLogger:add{opt.nhidden2}
--trainLogger:add{opt.epoch}
	  







