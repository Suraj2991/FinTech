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
	for t = 1,train_tensor:size()[1],opt.batchSize do
      
      		
      		local inputs = {}
      		local targets = {}
	        for i = t,math.min(t+opt.batchSize-1,train_tensor:size()[1]) do
         		
         		local input = train_dataset[shuffle[i]][1]
         		local output = train_dataset[shuffle[i]][2]
		        input = input:double() 
			output = output:double()      		
	                table.insert(inputs,input)
         		table.insert(targets,output)	
      		end
		
		
		local f = 0
		local f_eval = function(x)
			if x ~= parameters then
				parameters:copy(x)
			end

			gradParameters:zero()

			f = 0

			for k = 1,#inputs do
				print(inputs[k])
				pred_output = model:forward(inputs[k])
				print(pred_output)
				local err = criterion:forward(pred_output, targets[k][1])
				local df_do = criterion:backward(pred_output, targets[k][1])
				
				model:backward(inputs[k], df_do)
				f = f + err
				-- select arg min/max from pred_output 
				index_output = argmax_1D(pred_output)
				confusion_train:add(index_output, targets[k][1])
			end
			
			gradParameters:div(#inputs)
			f = f/#inputs

			return f,gradParameters
		end
		optimMethod(f_eval, parameters, optimState)
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
	for j=1, valid_tensor:size()[1] do
	        
		local pred_valid = model:forward(valid_dataset[j][1])
		local error_v = criterion:forward(pred_valid, valid_dataset[j][2][1])
		error_vf = error_vf + error_v
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
	return recall_train, recall_valid

end




























