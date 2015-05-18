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
cmd:option('-epoch', 1000, 'Number of Iterations')
cmd:option('-layers',1,'Number of layers in the Neural Network')
cmd:option('-nhidden1',5,'Number of hidden neurons in 1st Layer')
cmd:option('-nhidden2',30,'Number of hidden neurons in 2nd Layer')
cmd:option('-nhidden3',0,'Number of hidden neurons in 3rd Layer')
cmd:option('-nhidden4',0,'Number of hidden neurons in 4th Layer')
cmd:option('-nhidden5',0,'Number of hidden neurons in 5th Layer')
cmd:option('-nhidden6',0,'Number of hidden neurons in 6th Layer')
cmd:option('-trainD', '../Data/Train_1989-1999_', 'Train dataset directory+file')
cmd:option('-trainP', '../Data/Train_Pred_1989-1999_', 'Train predictions')
cmd:option('-validD', '../Data/Valid_2000-2004_', 'Valid dataset directory+file')
cmd:option('-validP', '../Data/Valid_Pred_2000-2004_', 'Valid Predictions')
cmd:option('-instr', 'ssi', 'Instrument')
cmd:text()

--'cgb', 'es', 'fce', 'fdx', 'ffi', 'fgbl', 'fgbm', 'flg', 'fv', 'hsi', 'jgb', 'mc', 'mfxi', 'nq', 're', 'ssi', 'stxe', 'ty', 'us', 'ym'



opt = cmd:parse(arg or {})
torch.manualSeed(opt.seed)
dofile '1_data.lua'

dofile '2_model.lua'
dofile '3_loss.lua'
dofile '4_train.lua'
dofile '5_testAll.lua'
local i = 1
x = {}
y = {}
trainMetrics = optim.Logger(paths.concat('../Results/Predictions/' .. opt.instr .. '/' .. opt.nhidden1 .. '_Metrics_test05-07.log'))


while i<=opt.epoch do
	x[i], y[i] = train()
	trainMetrics:add{y[i]}
	
	
  	i = i+1

end
test('cgb')
test( 'es')
test('fce')
test('fdx')
test('ffi')
test('fgbl')
test('fgbm')
test('flg')
test('fv')
test('hsi')
test('jgb')
test('mc')
test('mfxi')
test('nq')
test('re')
test('ssi')
test('stxe')
test('ty')
test('us')
test('ym')





