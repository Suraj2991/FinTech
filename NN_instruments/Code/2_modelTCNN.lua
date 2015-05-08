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
model:add(nn.TemporalConvolution(1, 5, 35, 2))
model:add(nn.TemporalMaxPooling(5,2))
model:add(nn.Reshape(15*5))
model:add(nn.Linear(75,2))
model:add(nn.Tanh())
