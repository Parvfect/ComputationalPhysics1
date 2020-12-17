import matplotlib.pyplot as plt
import numpy as np 
import numerical_integration as ode

class DoublePendulum:

    y = np.array([0, 0.0, 0.0, 0.0])

    def __init__(self, x1, y1, x2, y2, m1, m2, l1, l2):
        
        self.y[0] = x1
        self.y[1] = x2
        self.y[2] = y1
        self.y[3] = y2
        self.m1 = m1 
        self.m2 = m2
        self.l1 = l1 
        self.l2 = l2 
        self.z1 = 0 
        self.z1 = 0
        self.z2 = 0
        self.g = 9.8

  
    def fz(self, y, t):
    
        self.z1 = -((self.m2 * self.l2 * self.z2 * np.cos(y[0] - y[1]))/ (self.l1 * (self.m1+self.m2))) - (self.m2 * self.l2 * y[3] * y[3] * np.sin(y[0] - y[1])/ (self.l1 * (self.m1+self.m2))) - (self.g * np.sin(y[0])/ self.l1)       
        self.z2 = - (self.l1 * self.z1 * np.cos(y[0] - y[1])/self.l2) + (self.l1 * y[2] * y[2] * np.sin(y[0] - y[1])/ self.l2) - (self.g * np.sin(y[1])/ self.l2)

        return np.array([y[2], y[3], self.z1, self.z2]) 

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
            y_arr[1].append(self.y[1] * 180 / 3.14)
            y_arr[2].append(self.y[2])
            y_arr[3].append(self.y[3])
            times.append(t)
            
            #Increasing the time
            t += dt

       
        plt.plot(times, y_arr[0])
        plt.title("Position vs time for theta 1")
        plt.xlabel("Time")
        plt.ylabel("Theta")
        plt.grid(True, which='both')
        plt.show()

        plt.plot(times, y_arr[1])
        plt.title("Position vs time for theta 2")
        plt.xlabel("Time")
        plt.ylabel("Theta")
        plt.show()
        
        plt.plot(y_arr[0], y_arr[2])
        plt.title("Phase space for theta1")
        plt.xlabel("Theta")
        plt.ylabel("Angular Velocity")
        plt.grid(True, which='both')
        plt.show()

        plt.plot(y_arr[1], y_arr[3])
        plt.title("Phase space for theta2")
        plt.xlabel("Theta")
        plt.ylabel("Angular Velocity")
        plt.grid(True, which='both')
        plt.show()
