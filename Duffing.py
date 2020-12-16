import matplotlib.pyplot as plt
import numpy as np 
import numerical_integration as ode

class DuffingOscillator:

    y = np.array([0.0, 0.0])

    def __init__(self, x, y, a, b, w, g, d):
        
        self.y[0] = x
        self.y[1] = y
        self.a = a 
        self.b = b
        self.w = w 
        self.g = g
        self.d = d 

    def fz(self, y, t):
        
        y11 = self.g*np.cos(self.w*t) - (self.d*y[1]) - (self.a*y[0]) - (self.b * y[0] * y[0] * y[0])
    
        return np.array([y[1], y11])
    
    def solve(self, steps, dt, type):
        

        y_arr = [[],[],[],[]]
        times = []
        t = 0

        for i in range(steps):

            if type == 1:
                self.y += ode.runge_kutta(self.fz, self.y, t, dt)
            elif type == 2:
                self.y += ode.euler(self.fz, self.y, t, dt)
            elif type == 3:
                val, dt = ode.runge_kutta_adaptive_stepper(self.fz, self.y,t, dt)
                self.y += val
            else:
                val, dt = ode.euler_adaptive_step(self.fz, self.y,t, dt)
                self.y += val
            
            #Appending into arrays
            y_arr[0].append(self.y[0] * 180 / 3.14)
            y_arr[1].append(self.y[1])
            times.append(t)
            
            #Increasing the time
            t += dt

        plt.plot(times, y_arr[0])
        plt.title("Position vs time plot for theta")
        plt.xlabel("Time")
        plt.ylabel("Theta")
        plt.grid(True, which='both')
        plt.show()

        plt.plot(y_arr[0], y_arr[1])
        plt.title("Phase space for theta")
        plt.xlabel("Theta")
        plt.ylabel("Angular Velocity")
        plt.grid(True, which='both')
        plt.show()
        