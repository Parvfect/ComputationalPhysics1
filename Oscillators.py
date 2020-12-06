import numpy as np
import matplotlib.pyplot as plt
import math
from matplotlib import animation
import os
from datetime import datetime

#Creating a unique id for a specific execution so we can save the plots categorically
path = os.getcwd()

"""Things to do ---- 

1) Fix Double pendi overflow error

2) Elastic Pendulum equation check

3) Create test file

4) Is a runge kutta just changing the output variable or all..?
"""



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
            acceleration = -(self.frequency*self.frequency*self.position) - (2*damp_coeff*self.frequency*self.velocity) + driving_force*np.sin(np.radians(driving_frequency*t))/self.mass
            self.velocity += acceleration*dt
            self.position += self.velocity*dt
            t += dt
            self.positions.append(self.position)

        plt.plot(self.positions)
        plt.show()

    def duffing_oscillator(self, gamma, driving_frequency, delta, alpha, beta, dt, n):
        t = 0
        for i in range(n):
            acceleration = gamma* np.cos(np.radians(driving_frequency*t)) - delta * self.velocity - alpha*self.position - beta* self.position*self.position
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
        self.frequency = (1/(2*3.14))*(np.sqrt(self.g/self.length))
        
    def euler_step(self, dt, n):
        """Iterates through to calculate a solution to the differential equation"""
        
        for i in range(n):
            self.velocity += (-self.g*np.sin(np.radians(self.theta))/self.length)*dt
            self.theta += self.velocity*dt
            self.positions.append(self.theta)
        
        plt.plot(self.positions)
        plt.show()



    """def euler_step_damped(self, dt, n ,dc):

        for i in range(n):
                self.velocity += (-self.g*np.sin(np.radians(self.theta))/self.length)*dt
                self.theta += self.velocity*dt
                self.positions.append(self.theta)
            
            plt.plot(self.positions)
            plt.show()
        """

class ElasticPendellum(SimplePendellum):

    lengths = []
    v_lenghts = []

    def __init__(self, x1, y1, l0, m, x2, y2, spring_constant):
        self.x1 = x1
        self.y1 = y1
        self.l0 = l0
        self.m = m
        self.k = spring_constant
        self.x2 = x2
        self.y2 = y2

    
    def f_z1(self, y):
        return (-self.g * np.sin(self.x1) - 2 * self.y2 * y ) / (self.l0 + self.x2)

    def f_z2(self, y):
        return (self.m * (self.l0 + self.x2) * self.y1**2 - self.k * (self.x2) + self.m * self.g * np.cos(self.x1)) / self.m   
    
    def runge_kutta(self, func, h, y):
        """Solves using the fifth order range kutta method"""
        #Rememeber that y is just the input that you are feeding 
        
        k1 = func(y)
        k2 = func(y + h*k1/2)
        k3 = func(y + h*k2/2)
        k4 = func(y + h*k3/2)
        k5 = func(y + h*k4)
        
        return (k1 + k2 + k3 + k4 + k5)/5
        
    def solve(self, dt, n, type):

        now = datetime.now()
        os.mkdir(path + "/Figures/ElasticPendulum/{}".format(now))
        path_temp = path + "/Figures/ElasticPendulum/{}".format(now)

        #Creating a text file with the initial conditions
        file_name = path_temp + "/initial_conditions.txt"
        f = open(file_name, "w")
        f.write("x1 {}  x2 {} y1 {} y2 {} l0{} m{} k{}".format(self.x1, self.x2, self.y1, self.y2, self.l0, self.m, self.k))
        f.close()

        #Initializing the time variables
        times = []
        t = 0
        ang_vels = []
        vels = []

        if type == 1:
        
            for i in range(n):  
          
                z1 = self.f_z1(self.y1)
                z2 = self.f_z2(self.y2)
                self.y1 += z1 *dt
                self.y2 += z2 * dt 
                self.x1 += self.y1 * dt
                self.x2 += self.y2 * dt
                self.positions.append(180*self.x1/3.14)
                self.lengths.append(self.x2)
                vels.append(self.y1)
                ang_vels.append(self.y2)

                t+=dt
                times.append(t)
        else:
          
            for i in range(n):  
          
                z1 = self.runge_kutta(self.f_z1, dt, self.y1)
                z2 = self.runge_kutta(self.f_z2, dt, self.y2)
                self.y1 += z1 *dt
                self.y2 += z2 * dt 
                self.x1 += self.y1 * dt
                self.x2 += self.y2 * dt
                self.positions.append(180*self.x1/3.14)
                self.lengths.append(self.x2)
                vels.append(self.y1)
                ang_vels.append(self.y2)

                t+=dt
                times.append(t)
            
        fig = plt.figure()
        plt.plot(times, self.positions)
        plt.xlabel("Time (s)")
        plt.ylabel("Theta (degrees)")
        plt.show()
        fig.savefig(path_temp + "/t_x1")


        fig = plt.figure()
        plt.plot(times, self.lengths)
        plt.xlabel("Time (s)")
        plt.ylabel("Length of pendellum (x) ")
        plt.show()
        fig.savefig(path_temp + "/t_x2")
        
        
        fig = plt.figure()
        plt.plot(self.positions, ang_vels)
        plt.xlabel("Theta (degrees)")
        plt.ylabel("Velocities")
        plt.show()
        fig.savefig(path_temp + "/x1_y1")

        
        fig = plt.figure()
        plt.plot(self.lengths, vels)
        plt.xlabel("Lengths")
        plt.ylabel("Velocity of spring")
        plt.show()
        fig.savefig(path_temp + "/x2_y2")


class DoublePendellum():
    
    g = 9.8
    x1_arr = []
    x2_arr = []
    y1_arr = []
    y2_arr = []

    def __init__(self, m1, m2, l1, l2, x1, x2, y1, y2, z1=0, z2=0):
        self.m1 = m1
        self.m2 = m2
        self.l1 = l1
        self.l2 = l2
        self.x1 = x1
        self.x2 = x2
        self.y1 = y1
        self.y2 = y2
        self.z1 = z1
        self.z2 = z2

    def runge_kutta(self, func, y, h):
        """Solves using the fifth order range kutta method"""
        #Rememeber that y is just the input that you are feeding 
        
        k1 = func(y)
        k2 = func(y + h*k1/2)
        k3 = func(y + h*k2/2)
        k4 = func(y + h*k3/2)
        k5 = func(y + h*k4)
        
        return (k1 + k2 + k3 + k4 + k5)/5
        
    def first_order_fz1(self, y):
        
        a = -self.g * (2 * self.m1 * self.m2) * np.sin(self.x1)
        b = - self.m2 * self.g * np.sin(self.x1 - 2 * self.x2)
        c = - 2 * np.sin(self.x1 - self.x2) * self.m2 * (self.y2**2 * self.l2 + y**2 * self.l1 * np.cos(self.x1 - self.x2))           
        d = self.l1 * (2* self.m1 + self.m2 - self.m2 * np.cos(2 * self.x1 - 2* self.x2))
        return (a + b + c)/d

    def first_order_fz2(self, y):
        
        a = 2 * np.sin(self.x1 - self.x2) * (self.y1**2 * self.l1 * (self.m1 + self.m2))
        b = self.g * (self.m1 + self.m2) * np.cos(self.x1)
        c = y**2 * self.l2 * self.m2 * np.cos(self.x1 - self.x2)
        d = self.l2 * (2 * self.m1 + self.m2 - self.m2 * np.cos(2 * (self.x1 - self.x2)))
        return (a + b + c)/d

    def fz2(self, y):
        """Returns acceleration of x2 for time instant dt"""
        a = - self.l1 * self.z1 * np.cos(self.x1 - self.x2)/self.l2
        b = self.l1 * self.y1 * self.y1 * np.sin(self.x1 - self.x2)/ self.l2
        c = -self.g * np.sin(self.x2)/ self.l2
        return (a + b + c)
        
    def fz1(self, y):
        """Returns acceleration for x1 for time instant dt"""
        a =   -(self.m2 * self.l2 * self.x2 * np.cos(self.x1 - self.x2))/(self.l1*(self.m1+self.m2))
        b =  -self.m2 * self.l2 * self.y2 * np.sin(self.x1 - self.x2)/(self.l1*(self.m1+self.m2))
        c =  -self.g * np.sin(self.x1)/ self.l1
        return (a + b + c)
       

    def solve(self, dt, n, type):
        """Solves the differential equation and plots it"""
        
        now = datetime.now()
        os.mkdir(path + "/Figures/DoublePendulum/{}".format(now))
        path_temp = path + "/Figures/DoublePendulum/{}".format(now)

        #Creating a text file with the initial conditions
        file_name = path_temp + "/initial_conditions.txt"
        f = open(file_name, "w")
        f.write("x1 {}  x2 {} y1 {} y2 {} m1{} m2{} l1{} l2{} z1{} z2{}".format(self.x1, self.x2, self.y1, self.y2, self.m1, self.m2, self.l1, self.l2, self.z1, self.z2))
        f.close()  
        #The time variables
        t = 0
        times = []

        if type == 1:
            for i in range(n):

                #Euler method for integrating over small time steps
                self.z1 = self.fz1(self.y1)
                self.z2 = self.fz2(self.y2)
                self.y1 += self.z1 * dt
                self.y2 += self.z2 * dt
                self.x1 += self.y1 * dt
                self.x2 += self.y2 * dt

                #Appending into arrays
                self.x1_arr.append(self.x1)
                self.x2_arr.append(self.x2)
                self.y1_arr.append(self.y1)
                self.y2_arr.append(self.y2)
                times.append(t)

                #Increasing the time 
                t += dt
        else:
            for i in range(n):

                #Runge kutta method for integrating over small time steps
                self.z1 = self.runge_kutta(self.first_order_fz1, self.y1, 0.001)
                self.z2 = self.runge_kutta(self.first_order_fz2, self.y2, 0.001)
                self.y1 += self.z1 * dt
                self.y2 += self.z2 * dt
                self.x1 += self.y1 * dt
                self.x2 += self.y2 * dt

                #Appending into arrays
                self.x1_arr.append(self.x1)
                self.x2_arr.append(self.x2)
                self.y1_arr.append(self.y1)
                self.y2_arr.append(self.y2)
                times.append(t)

                #Increasing the time 
                t += dt
        

        #Position - time plot
        fig = plt.figure()
        plt.plot(times, self.x1_arr)
        plt.xlabel("Times")
        plt.ylabel("Coordinates of the  pendulum 1")
        plt.show()
        fig.savefig(path_temp + "/x1_t.png")

        fig = plt.figure()
        plt.plot(times, self.x2_arr)
        plt.xlabel("Times")
        plt.ylabel("Theta 2 ")
        plt.show()
        fig.savefig(path_temp + "/x2_t")

        #Phase diagram plots
        fig = plt.figure()
        plt.plot(self.x1_arr, self.y1_arr)
        plt.xlabel("Positions x1")
        plt.ylabel("Velocity")
        plt.show()
        fig.savefig(path_temp + "/x1_y1")


        fig = plt.figure()
        plt.plot(self.x2_arr, self.y2_arr)
        plt.xlabel("Positions x2")
        plt.ylabel("Velocity")
        plt.show()
        fig.savefig(path_temp + "/x2_y2")


class DuffingOscillator:

    def __init__(self, x, y, a, b, w, g, d):
        self.x = x
        self.y = y
        self.z = 0
        self.a = a
        self.b = b
        self.g = g
        self.d = d
        self.w = w
    
    def fz(self, t, y):
        return self.g*np.cos(self.w*t) - (self.d*y) - (self.a*self.x) - (self.b*self.x*self.x*self.x)

    def runge_kutta(self, func, t, y, h):
        """Solves using the fifth order range kutta method"""
        #Rememeber that y is just the input that you are feeding 
        
        k1 = func(t, y)
        k2 = func(t+ h/2, y + h*k1/2)
        k3 = func(t + h/2, y + h*k2/2)
        k4 = func(t+ h/2, y + h*k3/2)
        k5 = func(t + h, y + h*k4)
        
        return (k1 + k2 + k3 + k4 + k5)/5
        
    def solve(self, dt, n, type):

        now = datetime.now()
        os.mkdir(path + "/Figures/DuffingOscillator/{}".format(now))
        path_temp = path + "/Figures/DuffingOscillator/{}".format(now)

        #Creating a text file with the initial conditions
        file_name = path_temp + "/initial_conditions.txt"
        f = open(file_name, "w")
        f.write("Position {}  Velocity {} A {} B {} w{} g{} D{}".format(self.x, self.y, self.a, self.b, self.w, self.g, self.d))
        f.close()

        vels = []
        times = []
        positions = []
        t = 0
        
        if type == 1:

            for i in range(n):  
                self.z = self.fz(t, self.y)
                self.y += self.z*dt 
                self.x += self.y*dt
                positions.append(self.x)
                vels.append(self.y)

                t+=dt
                times.append(t)
            
        else:

            for i in range(n):  
                self.z = self.runge_kutta(self.fz, t, self.y, 0.0001)
                self.y += self.z*dt 
                self.x += self.y*dt
                positions.append(self.x)
                vels.append(self.y)

                t+=dt
                times.append(t)
            
        fig = plt.figure()
        plt.plot(positions, vels)
        plt.xlabel("Positions")
        plt.ylabel("Velocities")
        fig.savefig(path_temp + "/x_v")
        plt.show()

        fig = plt.figure()
        plt.plot(times, positions)
        plt.xlabel("Time")
        plt.ylabel("Positions")
        fig.savefig(path_temp + "/t_x")
        plt.show()




"""
Orderly and not so chaotic
"""

""""
t = DoublePendellum(2.5, 2.5, 4.8, 4.8, 0.03, 0.02, 0.002, 0.003)

t.solve(0.01, 10000, 2)
"""
"""
"""

"""
t = DuffingOscillator(0.1, 0.02, 1, 5, 0.5, 8, 0.02)
t.solve(0.01, 50000, 1)
"""


"""
t = ElasticPendellum(0.003, 0.001, 4.8, 1.5, 0.1, 0.01, 8.5)
t.solve(0.001, 500000, 2)
"""