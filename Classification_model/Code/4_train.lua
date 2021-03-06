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

if model then
   parameters,gradParameters = model:getParameters()
end

print '==> configuring optimizer'

classes = {'0','1'}
confusion_train = optim.ConfusionMatrix(classes)



optimState = {
      learningRate = opt.learningRate, 
      weightDecay = 0,
      momentum = 0,
      learningRateDecay = 1e-7
   }
optimMethod = optim.sgd




print '==> defining training procedure'

function train()
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


	shuffle = torch.randperm(train_tensor:size()[1])
	epoch = epoch or 1
	local time = sys.clock()

	model:training()
	print('==> doing epoch on training data:')
     
        print("==> online epoch # " .. epoch .. ' [batchSize = ' .. opt.batchSize .. ']')
		for t = 1,train_in:size()[1]-opt.batchSize do
      		
      		print(t)
		local inputs = train_in:sub(t,t+opt.batchSize-1):clone():resize(128)
		local targets = train_out[t+opt.batchSize]
		--print(inputs[128])
		--print(targets)				
		
		local f = 0
		--print(inputs:size())
		local f_eval = function(x)
			if x ~= parameters then
				parameters:copy(x)
			end

			gradParameters:zero()

			f = 0


			pred_output = model:forward(inputs)
			--print(pred_output)
			--print(pred_output)
			local err = criterion:forward(pred_output, targets[1])
			local df_do = criterion:backward(pred_output, targets[1])
			
			model:backward(inputs, df_do)
			-- select arg min/max from pred_output
			index_output = argmax_1D(pred_output)
			
			

			return err,gradParameters
		end
		local vals = 1
		if targets[1] == 1 then
			vals = 1
		end
		for it = 1,vals do
			optimMethod(f_eval, parameters, optimState)
		end
		confusion_train:add(index_output, targets[1])
	
	end
	local error_tf = 0


	-- Training error calculation
	print("confusion matrix")	
	print(confusion_train)
	local mat_CM_train = confusion_train.mat 
	recall_train = (mat_CM_train[1][1]/(mat_CM_train[1][1]+mat_CM_train[1][2]))*100
	training_accuracy = confusion_train.totalValid * 100
	
	
	epoch = epoch + 1

	-- Validation error calculation
	local error_vf = 0
	confusion_valid = optim.ConfusionMatrix(classes)
	for j=1, valid_in:size()[1]-opt.batchSize do
	        local vd_in = valid_in:sub(j, j+opt.batchSize-1):clone():resize(128)
		local pred_valid = model:forward(vd_in)
		local error_v = criterion:forward(pred_valid, valid_out[j+opt.batchSize][1])
		index_valid = argmax_1D(pred_valid)
		confusion_valid:add(index_valid, valid_out[j+opt.batchSize][1])
	end

	print('confusion')
	print(confusion_valid)
	local mat_CM_valid = confusion_valid.mat 
	recall_valid = (mat_CM_valid[1][1]/(mat_CM_valid[1][1]+mat_CM_valid[1][2]))*100
	
	accuracy_valid = confusion_valid.totalValid * 100
	
	print("Train Accuracy")
	print(training_accuracy)
	print("Validation Accuracy")
	print(accuracy_valid)
	
	print('Recall_train')
	print(recall_train)
	
	print('Recall_valid')
	print(recall_valid)
	


	confusion_train:zero()
	confusion_valid:zero()
	--return training_acuracy, accuracy_valid
	return train_accuracy, accuracy_valid

end




























