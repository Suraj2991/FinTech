require 'nn'
require 'csvigo'
require 'torch'





cmd = torch.CmdLine()
cmd:text()
cmd:text('Weights')
cmd:text()
cmd:text('Options:')
   
cmd:option('-layers', 1, 'Number of layers')
cmd:option('-instrument', 'cgb', 'Name of instrument')
cmd:text()
opt = cmd:parse(arg or {})

model = torch.load('../Models/model_' .. opt.instrument .. '.net')

w = model:parameters(1)[1]
w_fin = torch.totable(w)
csvigo.save('../Models/weights_'..opt.instrument .. '_1.csv', w_fin)


w = model:parameters(1)[2]
w = w:reshape(w:size()[1], 1)
w_fin = torch.totable(w)
csvigo.save('../Models/weights_'..opt.instrument .. '_2.csv', w_fin)



w = model:parameters(1)[3]
w_fin = torch.totable(w)
csvigo.save('../Models/weights_'..opt.instrument .. '_3.csv', w_fin)

w = model:parameters(1)[4]
w = w:reshape(w:size()[1],1)
w_fin = torch.totable(w)
csvigo.save('../Models/weights_'..opt.instrument .. '_4.csv', w_fin)








