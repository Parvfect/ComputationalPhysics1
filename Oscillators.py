import numpy as np
import matplotlib.pyplot as plt
import math

class SimpleHarmonicOscillator:
    
    positions = []
    velocities = []
    times = []

    def __init__(self, mass, frequency, position, velocity):
        self.mass = mass
        self.frequency = frequency
        self.position = position
        self.velocity = velocity

    def solve_damped(self, dt, n, damp_coeff):
        """Solving the equation of a damped simple harmonic oscillator"""
        
        for i in range(n):
            acceleration = -(self.frequency*self.frequency*self.position) - (2*damp_coeff*self.frequency*self.velocity)
            self.velocity += acceleration*dt
            self.position += self.velocity*dt
            self.positions.append(self.position)

        plt.plot(self.positions)
        plt.show()

    def solve_damped_driven(self, dt, n, damp_coeff, driving_force, driving_frequency):
        
        t = 0
        for i in range(n):
            acceleration = -(self.frequency*self.frequency*self.position) - (2*damp_coeff*self.frequency*self.velocity) + driving_force*math.sin(math.radians(driving_frequency*t))/self.mass
            self.velocity += acceleration*dt
            self.position += self.velocity*dt
            t += dt
            self.positions.append(self.position)

        plt.plot(self.positions)
        plt.show()

    def duffing_oscillator(self, gamma, driving_frequency, delta, alpha, beta, dt, n):
        t = 0
        for i in range(n):
            acceleration = gamma* math.cos(math.radians(driving_frequency*t)) - delta * self.velocity - alpha*self.position - beta* self.position*self.position
            self.velocity += acceleration*dt
            self.position += self.velocity*dt
            t += dt
            self.positions.append(self.position)
            self.times.append(t)

        plt.plot(self.times, self.positions)
        plt.show()

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
        self.frequency = (1/(2*3.14))*(math.sqrt(self.g/self.length))
        
    def euler_step(self, dt, n):
        """Iterates through to calculate a solution to the differential equation"""
        
        for i in range(n):
            self.velocity += (-self.g*math.sin(math.radians(self.theta))/self.length)*dt
            self.theta += self.velocity*dt
            self.positions.append(self.theta)
        
        plt.plot(self.positions)
        plt.show()

    """def euler_step_damped(self, dt, n ,dc):

        for i in range(n):
                self.velocity += (-self.g*math.sin(math.radians(self.theta))/self.length)*dt
                self.theta += self.velocity*dt
                self.positions.append(self.theta)
            
            plt.plot(self.positions)
            plt.show()
        """
t = SimpleHarmonicOscillator(1, 200, 200, 100)

t.duffing_oscillator(8,9.5,0.02,1,5,0.10,10000)