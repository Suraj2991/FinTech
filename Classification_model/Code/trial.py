import numpy as np
import sys
y = sys.argv[1]

f = open('../Results/Recall'+y+'_Metrics.log', 'r')

z = list(f)
y = []
for i in z:
	y.append(i.split()[1])

x = map(float,y[1:])

val = np.argmax(x) +1
print val
print x[val-1]
