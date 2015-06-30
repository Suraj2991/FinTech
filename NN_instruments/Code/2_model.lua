require 'torch'
require 'nn'
require 'optim'




if not opt then
   print '==> processing options'
   cmd = torch.CmdLine()
   cmd:text()
   cmd:text('SVHN Training/Optimization')
   cmd:text()
   cmd:text('Options:')
   
   cmd:option('-layers',1,'Number of layers in the Neural Network')
   cmd:option('-nhidden1',10,'Number of hidden neurons in 1st Layer')
   cmd:option('-nhidden2',30,'Number of hidden neurons in 2nd Layer')
   cmd:option('-nhidden3',2,'Number of hidden neurons in 3rd Layer')
   cmd:option('-nhidden4',0,'Number of hidden neurons in 4th Layer')
   cmd:option('-nhidden5',0,'Number of hidden neurons in 5th Layer')
   cmd:option('-nhidden6',0,'Number of hidden neurons in 6th Layer')
   cmd:option('-window', 10, 'Window Size')
   cmd:text()
   opt = cmd:parse(arg or {})
   torch.manualSeed(opt.seed)
end 

print '==> construct model'

local hid_1 = opt.nhidden1
ninputs=opt.window*20
noutputs=2

model = nn.Sequential()
model:add(nn.Linear(ninputs, hid_1))
model:add(nn.Tanh())
local hid_neurons = {}
local lay = opt.layers
hid_neurons[1] = hid_1
for i=1,lay-1 do
	hid_neurons[i+1] = opt['nhidden'..tostring(i+1)]
	
	if hid_neurons[i+1] > 0 then
		model:add(nn.Linear(hid_neurons[i],hid_neurons[i+1]))
		model:add(nn.Tanh())
	else
		break
	end
end
model:add(nn.Linear(hid_neurons[lay],noutputs))

print '==> the model:'
print(model)
	
			






		
