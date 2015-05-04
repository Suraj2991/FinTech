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



optimState = {
      learningRate = opt.learningRate, 
      weightDecay = 0,
      momentum = 0,
      learningRateDecay = 1e-7
   }
optimMethod = optim.sgd




print '==> defining training procedure'

function train()
	epoch = epoch or 1
	local time = sys.clock()

	model:training()
	print('==> doing epoch on training data:')
        print("==> online epoch # " .. epoch .. ' [batchSize = ' .. opt.batchSize .. ']')
	for t = 1,train_tensor:size()[1],opt.batchSize do
      
      		
      		local inputs = {}
      		local targets = {}
	        for i = t,math.min(t+opt.batchSize-1,train_tensor:size()[1]) do
         		
         		local input = train_dataset[i][1]
         		local output = train_dataset[i][2]
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
				
				local output = model:forward(inputs[k])
				local err = criterion:forward(output, targets[k])
				local df_do = criterion:backward(output, targets[k])
				
				model:backward(inputs[k], df_do)
				f = f + err
			end
		
			gradParameters:div(#inputs)
			f = f/#inputs

			return f,gradParameters
		end
		optimMethod(f_eval, parameters, optimState)
	end
	local error_tf = 0
	for j=1, train_tensor:size()[1] do
		local pred_output = model:forward(train_dataset[j][1])
		local error_t = criterion:forward(pred_output, train_dataset[j][2])
		error_tf = error_tf + error_t
	end
	local avg_MSE_train = error_tf/train_tensor:size()[1]


	time = sys.clock() - time
   	time = time / train_tensor:size()[1]
	epoch = epoch + 1

	local error_vf = 0
	for j=1, valid_tensor:size()[1] do
	        
		local pred_valid = model:forward(valid_dataset[j][1])
		local error_v = criterion:forward(pred_valid, valid_dataset[j][2])
		error_vf = error_vf + error_v
		
		
	end
	
	local avg_MSE_valid =  error_vf/(valid_tensor:size()[1])

	print ("Training MSE " .. (avg_MSE_train) .. "Validation MSE " .. (avg_MSE_valid) )

	return avg_MSE_train, avg_MSE_valid

end




























