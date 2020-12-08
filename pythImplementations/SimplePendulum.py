import matplotlib.pyplot as plt
import math
import numpy as np
import numerical_integration as ode

class SimplePendellum:
    
    #Acceleration due to gravity
    g = 9.8
    positions = []
    velocities = []
    positions2 = []

    def __init__(self, length, theta, velocity, mass):
        """Initialises the instance variables"""
        self.length = length
        self.x  = theta
        self.y = velocity
        self.acceleration = 0
        self.mass = mass
        
    def f_z(self):
        return (-self.g * np.sin(self.x) / self.length)

    
    def euler_adaptive_step(self, dt, err):

        y1, x1 = ode.euler_step(self.f_z, self.y, self.x, dt)
        y2, x2 = ode.euler_step(self.f_z, self.y, self.x, dt/2)
        y3, x3 = ode.euler_step(self.f_z, y2, x2, dt/2)
        
        return y1, x1    

        """ if ((y2 + y3) - y1) > err:
            print(dt)
            self.euler_adaptive_step(dt/2, err)
        """
        

    def solve(self, dt, n):
        """Iterates through to calculate a solution to the differential equation"""
        
        for i in range(n):
            self.y, self.x = self.euler_adaptive_step(dt, 0.01) 
            self.positions.append(self.x)
            self.velocities.append(self.y)
        
        #Plotting the positions
        plt.plot(self.positions)
        plt.show()
        
        #Phase space plot
        plt.plot(self.positions, self.velocities)
        plt.show()
