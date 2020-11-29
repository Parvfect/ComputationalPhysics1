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
        
        if n==0:
            print(self.positions)
        
        else:
            self.acceleration += (-self.g*math.sin(self.theta)/self.length)*dt
            self.velocity += self.acceleration*dt
            self.theta += self.velocity*dt
            self.positions.append(self.theta)
            self.step(dt, (n-1))
        

t = SimplePendellum(9.8, 0, 0)

print(t.positions)