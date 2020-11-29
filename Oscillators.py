import numpy as np
import matplotlib.pyplot as plt
import math



def rounding(decimal_places, arr):
    """Takes in an array of values and rounds them to n digits"
        Because precision causes values to become infinity"""
    
    for i in range(0, len(arr)):
        arr[i] = round(i,decimal_places)

    return arr

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
    velocities = []

    def __init__(self, length, theta, velocity, mass):
        """Initialises the instance variables"""
        self.length = length
        self.theta  = theta
        self.velocity = velocity
        self.acceleration = 0
        self.mass = mass
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

class ElasticPendellum(SimplePendellum):

    lengths = []
    v_lenghts = []

    def __init__(self, theta, ang_velocity, initial_length, mass, stretch, v_length, spring_constant):
        super().__init__(initial_length, theta, ang_velocity, mass)
        self.k = spring_constant
        self.x = stretch
        self.v_l = v_length

    
    def f_theta(self):
        return (-self.g*np.sin(math.radians(self.theta)) - 2*self.velocity*self.v_l) / self.length

    def f_L(self):
        return (self.mass*self.length*self.velocity**2 - self.k*(self.x) + self.mass*self.g*np.cos(math.radians(self.theta))) / self.mass
    
    def solve(self, dt, n):

        times = []
        t = 0
        ang_vels = []
        vels = []

        for i in range(n):
            acceleration_theta = self.f_theta()
            acceleration_length = self.f_L()
            self.velocity += (acceleration_theta *dt)
            self.v_l += acceleration_length*dt 
            self.theta += self.velocity*dt
            self.x += self.v_l*dt
            self.positions.append(self.theta)
            self.lengths.append(self.x)
            vels.append(self.v_l)
            ang_vels.append(self.velocity)

            t+=dt
            times.append(t)
        
        moms = [self.mass*i for i in ang_vels]



        plt.plot(times, self.positions)
        plt.xlabel("Time (s)")
        plt.ylabel("Theta (degrees)")
        plt.show()

        plt.plot(times, self.lengths)
        plt.xlabel("Time (s)")
        plt.ylabel("Length of pendellum (x) ")
        plt.show()

        plt.plot(self.positions, ang_vels)
        plt.xlabel("Theta (degrees)")
        plt.ylabel("Velocities")
        plt.show()

        plt.plot(self.lengths, vels)
        plt.xlabel("Lengths")
        plt.ylabel("Velocity of spring")
        plt.show()

        plt.plot(self.positions, moms)
        plt.xlabel("Theta (degrees)")
        plt.ylabel("Momentum")
        plt.show()

t = ElasticPendellum(0.1, 0.1, 2, 2, 3, 1, 5)
t.solve(0.001, 1000000)