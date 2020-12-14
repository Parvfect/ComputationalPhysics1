"""
Numerical integration methods 

Euler, adaptive stepping euler, RK4, and adaptive stepping RK4

"""

def euler(self, function, y, t, dt):

    return dt * function(y,t)

def euler_adaptive_step(self, function, y, t, dt):

    h = dt 
    # Fixed step size
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

    step = dt * function(y, t + dt) 
    half_step = dt / 2 * function(y, t + dt/2)
    double_step = 2 * dt * function(y, t + 2*dt)  

    #Checking if step size is above defined limit to control speed 
    if h < h_min:
        step = h_fixed

    #Updating step size
    if abs(step - half_step) > dx_max:
        h = h/2

    elif abs(double_step - step) < dx_min:
        h = 2 * h

    return double_step, h

def runge_kutta(self, function, y, t, dt):
    
    k1 = function(y,t)
    k2 = function(y + 0.5 * k1 * dt, t + 0.5 * dt)
    k3 = function(y + 0.5 * k2 * dt, t + 0.5 * dt)
    k4 = function(y + k3 * dt, t + dt)

    return dt * (k1 + 2 * k2 + 2 * k3 + k4) / 6

def runge_kutta_adaptive_stepper(self, y, t, dt):
    """Returns the new step size as well along with an array"""

    # Fixed step size
    h = dt 
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

    step = h * (k1 + 2 * k2 + 2 * k3 + k4) / 6


    #Calculating half step based on fixed step size
    k2 = function(t + h/4, y + k1 * h / 4)
    k3 = function(t + h/4, y + k2 * h / 4)
    k4 = function(t + h/2, y + k3 * h/2)

    half_step = h * (k1 + 2 * k2 + 2 * k3 + k4) / 12


    #Calculating Double step based on fixed step size
    k2 = function(t + h, y + k1 * h)
    k3 = function(t + h, y + k2 * h)
    k4 = function(t + 2* h, y + k3 * 2 * h)

    double_step = h * (k1 + 2 * k2 + 2 * k3 + k4) / 3

    #Checking if step size is above defined limit to control speed 
    if h < h_min:
        step = h_fixed

    #Updating step size
    if abs(step - half_step) > dx_max:
        h = h/2

    elif abs(double_step - step) < dx_min:
        h = 2 * h

    return double_step, h