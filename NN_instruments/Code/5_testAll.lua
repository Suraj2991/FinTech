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



classes = {'0','1'}
confusion_test = optim.ConfusionMatrix(classes)
function test(instr)
	testLogger1 = optim.Logger(paths.concat('../Results/Predictions/' .. instr .. '/Output_Predictions_05-07_full_' .. instr .. '.log'))
	testLogger1:add{'Date', 'Predictions', 'Original'}
	testLogger2 = optim.Logger(paths.concat('../Results/Predictions/' .. instr .. '/Output_confusion_mat_05-07_full_' .. instr .. '.log'))
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
	valid_tensor, cols2 = csv2t.load('../Data/' .. instr .. '/' .. opt.validD .. instr .. '.csv', {exclude='date'})
	valid_in = valid_tensor:narrow(2,1,100):clone()
	valid_tensors, cols2 = csv2t.load('../Data/' .. instr .. '/' .. opt.validP .. instr .. '.csv')
	valid_out = valid_tensors:narrow(2,2,1):clone()
	valid_dataset = {}
	for i=1,valid_tensor:size()[1] do
		valid_dataset[i] = {valid_in[i],valid_out[i]}
	end
	for j=1, valid_in:size()[1] do
		local vd_in = valid_dataset[j][1]
		local pred_valid = model:forward(vd_in)
		local error_v = criterion:forward(pred_valid, valid_dataset[j][2][1])
		index_valid = argmax_1D(pred_valid)
		confusion_test:add(index_valid, valid_dataset[j][2][1])
		--print(confusion_test)
		testLogger1:add{string.format("%.0f",valid_tensors[j][1]),string.format("%.0f",valid_out[j][1]), string.format("%.0f",index_valid)}
		
	end
	local mat_CM_valid = confusion_test.mat
	print(mat_CM_valid)
	testLogger2:add{string.format("%.0f",mat_CM_valid[1][1]), string.format("%.0f",mat_CM_valid[1][2])}
	testLogger2:add{string.format("%.0f",mat_CM_valid[2][1]), string.format("%.0f",mat_CM_valid[2][2])}
	confusion_test:zero()
end



