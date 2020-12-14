import matplotlib.pyplot as plt
import numpy as np



class ElasticPendi:

    y = np.array([0, 0.0, 0.0, 0.0])

    def __init__(self, x1, y1, x2, y2, m, l, k, g):
        
        self.y[0] = x1
        self.y[1] = x2
        self.y[2] = y1
        self.y[3] = y2
        self.m = m 
        self.l = l
        self.k = k 
        self.g = g 

    def fz(self, y, t):
    
        x1, x2, y1, y2 = y[0], y[1], y[2], y[3]

        y12 = (- self.g * np.sin(y[0]) - 2 * y[3] * y[2] ) / (self.l + y[2])
        y22 = (self.l + y[1]) * y[2]**2 - (self.k * (y[1]) / self.m)  +  self.g * np.cos(y[0])  

        return np.array([y1, y2, y12, y22])

    def runge_kutta(self, function, y, t, dt):
        
        k1 = self.fz(y,t)
        k2 = self.fz(y+0.5*k1*dt, t+0.5*dt)
        k3 = self.fz(y+0.5*k2*dt, t+0.5*dt)
        k4 = self.fz(y+k3*dt, t+dt)

        return dt * (k1 + 2 * k2 + 2 * k3 + k4) /6

    def runge_kutta_adaptive_stepper(self, y, t, dt):
                
        # Fixed step size
        h = 0.1 
        h_fixed = 0.01
        h_min = 0.0001

        # Normal step value 
        step = 0

        # Half step value 
        half_step = 0

        #Double step value
        double_step = 0

        #Tolerable difference ranges 
        dx_min = 0.008
        dx_max = 0.01

        #Calculating full step based on fixed step size
        k1 = function(t, y)
        k2 = function(t + h/2, y + k1 * h / 2)
        k3 = function(t + h/2, y + k2 * h / 2)
        k4 = function(t + h, y + k3 * h)

        step = (k1 + 2 * k2 + 2 * k3 + k4) / 6


        #Calculating half step based on fixed step size
        k2 = function(t + h/4, y + k1 * h / 4)
        k3 = function(t + h/4, y + k2 * h / 4)
        k4 = function(t + h/2, y + k3 * h/2)

        half_step = (k1 + 2 * k2 + 2 * k3 + k4) / 12


        #Calculating Double step based on fixed step size
        k2 = function(t + h, y + k1 * h)
        k3 = function(t + h, y + k2 * h)
        k4 = function(t + 2* h, y + k3 * 2 * h)

        double_step = (k1 + 2 * k2 + 2 * k3 + k4) / 3

        #Checking if step size is above defined limit to control speed 
        if abs(step) < h_min:
            step = h_fixed

        #Updating step size
        if abs(step - half_step) > dx_max:
            h = h/2

        elif abs(double_step - step) < dx_min:
            h = 2 * h




    def solve(self, steps, dt):
        

        y_arr = [[],[],[],[]]
        times = []
        t = 0

        for i in range(steps):

            self.y += self.runge_kutta(self.y, t, dt)
           
            #Appending into arrays
            y_arr[0].append(self.y[0])
            y_arr[1].append(self.y[1])
            y_arr[2].append(self.y[2])
            y_arr[3].append(self.y[3])
            times.append(t)
            
            #Increasing the time
            t += dt

        plt.plot(times, y_arr[0])
        plt.show()

        plt.plot(times, y_arr[1])
        plt.show()
        
        plt.plot(y_arr[0], y_arr[2])
        plt.show()

        plt.plot(y_arr[1], y_arr[3])
        plt.show()


t = ElasticPendi(0.3, 0.02, 0.5, 0.1, 2.5, 4.3, 6.5, 9.8)
t.solve(10000, 0.01)