

import matplotlib.pyplot as plt
import math
import numpy as np

def focal_length(u,v):

    return (u+v) /(v*u)

def image_distance(u, f):
    
    return (u - f)/(f*u) 

def get_mean(X):
    
    sum = 0
    for i in X:
        sum += i
    
    return sum/len(X)

def standard_error(X):
    
    assert(isinstance(X, list))

    mean = get_mean(X)

    n = len(X)
    sum = 0

    for i in X:
        sum += math.pow((i - mean),2)

    return math.sqrt(sum/(n-1))


u = [14.8, 13.8, 12.9, 13.6, 15.1, 17.8, 27.8, 30.4]
v =[74.5, 64.0, 54.4, 43.7, 32.7, 24.7, 16.5, 15.7]
f = []

u1 = [8.2]*10
l1 = [25.2, 25.2, 25.2, 34.6, 34.6, 34.6, 34.6, 44.0, 44.6, 44.5]
l2 = [46.5, 44.5, 43.9, 43.6, 44.5, 45.3, 46.9, 52.6, 53.5, 54.8]
v1 = [60.0, 70.3, 84.5, 86.0, 73.2, 63.6, 56.2, 70.7, 65.2, 62.0]
f1 = 10.5

for i in range(len(u1)):
    u1[i] = l1[i] - u1[i]
    v_dash.append(image_distance(u1[i], f1))
    v1[i] = [v1[i] - l2[i]]

actual_u = -v_dash
actual v = v1

v_plus_u = [i for i in u]
uv = [i for i in u]
sum = 0

for i in range(len(v)):
    v_plus_u[i] += v[i]
    uv[i] *= v[i]
    f.append(focal_length(u[i], v[i]))
    
print(standard_error(f))


def plot(x ,y, err):
    
    m = []
    for i in range(len(x)):
        m.append(y[i]/x[i])
        
    t = get_mean(m)

    f, ax = plt.subplots(1)
    plt.scatter(x, y, marker='o')
    ax.plot(np.unique(x), np.poly1d(np.polyfit(x, y, 1))(np.unique(x)))
    plt.grid(True)

    plt.ylabel("v + u (cm)")
    plt.xlabel("uv (cm^2) ")
    plt.title("Focal length of a convex lens  f = {}".format(round(t,3)))
    plt.show()
    
   


plot(uv, v_plus_u, 0.002)