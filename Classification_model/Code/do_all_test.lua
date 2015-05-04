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
cmd:option('-trainD', '../Data/Train_1992_1993.csv', 'Train dataset directory+file')
cmd:option('-validD', '../Data/Valid_1994_1995.csv', 'Valid dataset directory+file')
cmd:option('-testD', '../Data/Test_1996_1997.csv', 'Test dataset directory+file')
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
while i<opt.epoch do
	x[i], y[i] = train()
	if i>2 and (y[i]>y[i-1] and y[i-1]>y[i-2]) then 
		break
	end
	
  	i = i+1

end

	  


test()




