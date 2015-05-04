require 'torch'
require 'nn'
csv2t = require 'csv2tensor'
print '==> loading dataset'


if not opt then
   print '==> processing options'
   cmd = torch.CmdLine()
   cmd:text()
   cmd:text('SVHN Training/Optimization')
   cmd:text()
   cmd:text('Options:')
   cmd:option('-trainD', '../Data/Train_1992_1993.csv', 'Train dataset directory+file')
   cmd:option('-validD', '../Data/Valid_1994_1995.csv', 'Valid dataset directory+file')
   cmd:option('-testD', '../Data/Test_1996_1996.csv', 'Train dataset directory+file')
   cmd:text()
   opt = cmd:parse(arg or {})
end


train_tensor, cols1 = csv2t.load(opt.trainD, {exclude='date'})
valid_tensor, cols2 = csv2t.load(opt.validD, {exclude='date'})
test_tensor, cols3 = csv2t.load(opt.testD, {exclude='date'})
org_train_in = train_tensor:narrow(2,1,1):clone()
org_valid_in = valid_tensor:narrow(2,1,1):clone()
org_test_in = test_tensor:narrow(2,1,1):clone()


train_out = train_tensor:narrow(2,3,1):clone()
valid_out = valid_tensor:narrow(2,3,1):clone()
test_out = test_tensor:narrow(2,3,1):clone()
print(train_out[1])
means = {}
stds = {}
assert( org_train_in:size()[2] == org_valid_in:size()[2], "Datasets have equal columns")

print "==> pre-processing data"
train_in = org_train_in:clone()
valid_in = org_valid_in:clone()
test_in = org_test_in:clone()
--for j=1,train_in:size()[2] do
--	means[j] = train_in[{{},j}]:mean()
--	stds[j] = train_in[{{},j}]:std()
--	train_in[{{},j}]:add(-means[j])
--	train_in[{{},j}]:div(stds[j])
--end


--for j=1,valid_in:size()[2] do
--	valid_in[{{},j}]:add(-means[j])
--	valid_in[{{},j}]:div(stds[j])	
--end


--for j=1,test_in:size()[2] do
--	test_in[{{},j}]:add(-means[j])
--	test_in[{{},j}]:div(stds[j])	
--end


train_dataset = {}
for i=1,train_tensor:size()[1] do
	train_dataset[i] = {train_in[i],train_out[i]}
end

valid_dataset = {}
for i=1,valid_tensor:size()[1] do
	valid_dataset[i] = {valid_in[i],valid_out[i]}
end

test_dataset = {}
for i=1,test_tensor:size()[1] do
	test_dataset[i] = {test_in[i],test_out[i]}
end







