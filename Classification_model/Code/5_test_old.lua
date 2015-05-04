require 'optim'
require 'nn'
require 'torch'
require 'xlua'

print('Testing')
testLogger1 = optim.Logger(paths.concat('../Results/Trial/Output_Valid.log'))
testLogger1:add{'Predictions', 'Original'}
testLogger2 = optim.Logger(paths.concat('../Results/Output_Train.log'))
testLogger2:add{'Predictions', 'Original'}
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
	for j=1, valid_tensor:size()[1] do
	        local vd = valid_dataset[j][2]
		local pred_valid = model:forward(valid_dataset[j][1])
		index_output = argmax_1D(pred_valid)
		testLogger1:add{index_output, vd[1]}

	end


	for j=1, train_tensor:size()[1] do
	        local td = train_dataset[j][2]
		local pred_train = model:forward(train_dataset[j][1])
		index_output = argmax_1D(pred_train)
		testLogger2:add{index_output, td[1]}

	end
	
	--print ("Validation Accuracy" .. confusion_test.totalValid*100))
end
