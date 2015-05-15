require 'torch'   
require 'xlua'    
require 'optim'   


if not opt then
   print '==> processing options'
   cmd = torch.CmdLine()
   cmd:text()
   cmd:text('SVHN Training/Optimization')
   cmd:text()
   cmd:text('Options:')
   cmd:option('-save', 'results', 'subdirectory to save/log experiments in')
   cmd:option('-learningRate', 1e-3, 'learning rate at t=0')	
   cmd:option('-batchSize', 14, 'mini-batch size (1 = pure stochastic)')
   cmd:text()
   opt = cmd:parse(arg or {})
end 

testLogger1 = optim.Logger(paths.concat('../Results/Predictions/' .. opt.instr .. '/Output_Predictions_00-04_full_' .. opt.instr .. '.log'))
testLogger1:add{'Date', 'Predictions', 'Original'}
testLogger2 = optim.Logger(paths.concat('../Results/Predictions/' .. opt.instr .. '/Output_confusion_mat_00-04_full_' .. opt.instr .. '.log'))

classes = {'0','1'}
confusion_test = optim.ConfusionMatrix(classes)
function test()
	local function argmax_1D(v)
	   local length = v:size(1)
	   assert(length > 0)
	   
	   -- examine on average half the entries
	   local maxValue = torch.max(v)
	   for i = 1, v:size(1) do
	      if v[i] == maxValue then
	         return i
	      end
   	   end
	end
	for j=1, valid_in:size()[1]-opt.batchSize do
		local vd_in = valid_dataset[j][1]
		local pred_valid = model:forward(vd_in)
		local error_v = criterion:forward(pred_valid, valid_dataset[j][2][1])
		index_valid = argmax_1D(pred_valid)
		confusion_test:add(index_valid, valid_dataset[j][2][1])
		testLogger1:add{string.format("%.0f",valid_tensors[j][1]),string.format("%.0f",valid_out[j][1]), string.format("%.0f",index_valid)}
		
	end
	local mat_CM_valid = confusion_test.mat
	testLogger2:add{string.format("%.0f",mat_CM_valid[1][1]), string.format("%.0f",mat_CM_valid[1][2])}
	testLogger2:add{string.format("%.0f",mat_CM_valid[2][1]), string.format("%.0f",mat_CM_valid[2][2])}
end



