require 'torch'
require 'nn'

print '==> construct the loss function'
model:add(nn.LogSoftMax())
criterion = nn.ClassNLLCriterion()

print(criterion)
