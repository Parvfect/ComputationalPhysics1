#An attempt to create a seperate runge kutta and euler step that is more accurate


def euler_step(function, y0, x0, dt):
    
    z = function()
    y = y0 + z * dt 
    x = x0 + y * dt

    return x, y


def runge_kutta(function, y0, x0, dt, h):

    k1 = function(y0)
    k2 = function(y0 + h * k1 / 2)
    k3 = function(y0 + h * k2 / 2)
    k4 = function(y0 + h*k3)

    z =  (k1 + 2 * k2 + 2* k3 + k4) / 6
    y = y0 + z * dt
    x = x0 * dt

    return x, y

