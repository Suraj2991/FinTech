import matplotlib.pyplot as plt
import sys
val = sys.argv[1]
f = open(val, 'r')

z = list(f)
f.close()
y = []
for i in z:
	y.append(i.split()[1])

x = map(float,y[1:])


plt.plot(range(len(x)), x)
plt.xlabel('epochs')
plt.ylabel('Recall')
plt.savefig(val+'.png', bbox_inches='tight')
