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
      momentum = 0.9,
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


	epoch = epoch or 1
	local time = sys.clock()

	model:training()
	print('==> doing epoch on training data:')
     
        print("==> online epoch # " .. epoch .. ' [batchSize = ' .. opt.batchSize .. ']')

	for t = 1,train_in:size()[1],opt.batchSize do
      		
      		
	    local inputs = {}
	    local targets = {}
	    for i = t, math.min(t+opt.batchSize-1, train_in:size()[1]) do
		local input = train_dataset[i][1]
		local target = train_dataset[i][2]
		table.insert(inputs, input)
		table.insert(targets, target)
 	    end  		
	    local f = 0
            local f_eval = function(x)
		if x ~= parameters then
			parameters:copy(x)			
                end

		gradParameters:zero()

		f = 0

		for i = 1,#inputs do
			local pred_output = model:forward(inputs[i])
			local err = criterion:forward(pred_output, targets[i][1])
			f = f + err
			pred_output = model:forward(inputs[i])
			local df_do = criterion:backward(pred_output, targets[i][1])
			
			model:backward(inputs[i], df_do)

			index_output = argmax_1D(pred_output)
			confusion_train:add(index_output, targets[i][1])
		end
		gradParameters:div(#inputs)
		f = f/#inputs

		return f,gradParameters
            end
 
	optimMethod(f_eval, parameters, optimState)
	end


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
	for j=1, valid_in:size()[1] do
	        local vd_in = valid_dataset[j][1]
		local pred_valid = model:forward(vd_in)
		local error_v = criterion:forward(pred_valid, valid_dataset[j][2][1])
		index_valid = argmax_1D(pred_valid)
		confusion_valid:add(index_valid, valid_dataset[j][2][1])
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
	return training_accuracy, accuracy_valid

end




























