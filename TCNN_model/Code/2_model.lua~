require 'torch'
require 'nn'
require 'optim'
require 'nnx'



if not opt then
   print '==> processing options'
   cmd = torch.CmdLine()
   cmd:text()
   cmd:text('SVHN Training/Optimization')
   cmd:text()
   cmd:text('Options:')
   cmd:text()
   opt = cmd:parse(arg or {})
   torch.manualSeed(opt.seed)
end 

print '==> construct model'
model = nn.Sequential()
model:add(nn.TemporalConvolution(131, 2, 50, 1))
model:add(nn.TemporalMaxPooling(5,2))
model:add(nn.Reshape(38*2))
model:add(nn.Linear(76,2))
model:add(nn.Tanh())
--model = nn.Sequential()
--model:add(nn.TemporalConvolution(1,4,35,1))
--model:add(nn.TemporalMaxPooling(5,2))
--model:add(nn.Reshape(45*4))
--model:add(nn.Linear(180,2))
--model:add(nn.ReLU())





		
