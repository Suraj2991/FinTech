require 'optim'
require 'nn'
require 'torch'
require 'xlua'
classes = {'0','1'}
confusion_test = optim.ConfusionMatrix(classes)

print('Testing')
testLogger1 = optim.Logger(paths.concat('../Results/Predictions/Output_Valid.log'))
testLogger1:add{'Predictions', 'Original'}
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


	local error_vf = 0
	for j=1, valid_in:size()[1]-opt.batchSize do
	        local vd = valid_out[j+opt.batchSize][1]
		local pred_test = model:forward(valid_in:sub(j, j+opt.batchSize-1))
		local error_v = criterion:forward(pred_test, valid_out[j+opt.batchSize][1])
		index_test = argmax_1D(pred_test)
		confusion_test:add(index_test, valid_out[j+opt.batchSize][1])
		testLogger1:add{index_test,vd}
	end

	print(confusion_test)
	print("Test Accuracy" .. confusion_test.totalValid*100)	
	--print ("Validation Accuracy" .. confusion_test.totalValid*100))
end
