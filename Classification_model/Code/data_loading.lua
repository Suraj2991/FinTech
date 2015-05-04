csv2t = require 'csv2tensor'
train_tensor, cols = csv2t.load("Deeper/train.csv",
			 {exclude={"globalIndex", "Didx", "date", "fdate_t1", "zfret1_t1", "signfret1", "zcfret1"}})
valid_tensor, cols1 = csv2t.load("Deeper/valid.csv",
                         {exclude={"globalIndex", "Didx", "date", "fdate_t1", "zfret1_t1", "signfret1", "zcfret1"}})
csv2t = require 'csv2tensor'
x = valid_tensor:narrow(2,1,156):clone()
y = valid_tensor:narrow(2,156,1):clone()

train_dataset = {}
for i=1,valid_tensor:size()[1] do
	train_dataset[i] = {x[i],y[i]}
end
function train_dataset:size() return 15000 end
require "nn"
mlp=nn.Sequential();  
inputs=131; outputs=1; HUs=400
mlp:add(nn.Linear(inputs,200))
mlp:add(nn.Tanh())
mlp:add(nn.Linear(200,400))
mlp:add(nn.Tanh())
mlp:add(nn.Linear(400,200))
mlp:add(nn.Tanh())

mlp:add(nn.Linear(200,outputs))

criterion = nn.MSECriterion()  
trainer = nn.StochasticGradient(mlp, criterion)
trainer.learningRate = 0.01 

for j=1,10 do

	trainer:train(train_dataset) 
end
