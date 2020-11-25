import numpy as np
import matplotlib.pyplot as plt
import math


class SimplePendellum:
    
    #Acceleration due to gravity
    g = 9.8
    positions = []

    def __init__(self, length, theta, velocity):
        """Initialises the instance variables"""
        self.length = length
        self.theta  = theta
        self.velocity = velocity
        self.acceleration = 0
        
    def euler_step(self, dt, n):
        """Iterates through to calculate a solution to the differential equation"""
        
        for i in range(n):
            self.velocity += (-self.g*math.sin(math.radians(self.theta))/self.length)*dt
            self.theta += self.velocity*dt
            self.positions.append(self.theta)
        
        plt.plot(self.positions)
        plt.show()

t = SimplePendellum(9.8, 20, 10)
t.euler_step(0.001, 100000)