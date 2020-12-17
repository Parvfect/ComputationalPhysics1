/**
Numerical integration methods 

Euler, adaptive stepping euler, RK4, and adaptive stepping RK4

*/

public func euler(function: ([Double], Double) -> ([Double]), y:[Double], t:Double, dt:Double) -> ([Double]){
    
    return dt * function(y,t)
}

/** Take two half steps and compare their difference with a full step. Reduce the step size if difference is greater than dx_max **/
public func euler_adaptive_step(function: ([Double], Double) -> ([Double]), y:[Double], t:Double, dt:Double) -> ([Double], Double){

    var h = dt 

    /** Fixed step values */
    let h_fixed = 0.01
    let h_min = 0.0001

    var step:[Double] = []

    /** Half step value */
    var half_step:[Double] = []

    
    /** Tolerable difference ranges */ 
    let dx_max = 0.01

    step =  dt * function(y, t + dt)
    half_step =  dt/2 * function(y, t + dt/2)
    half_step += dt/2 * (function(y, t + dt) + half_step)
    
    /** Checking if step size is above defined limit to control speed */
    if h < h_min{
        h = h_fixed
    }

    /** Updating step size */
    if (abs(step[2] - half_step[2]) > dx_max || abs(step[3] - half_step[3]) > dx_max){
        h = h/2
    }

    return (half_step, h)
}

/** Fourth order runge kutta method. Taken from (https://lpsa.swarthmore.edu/NumInt/NumIntFourth.html) */
public func runge_kutta(function: ([Double], Double) -> ([Double]), y:[Double], t:Double, dt:Double) -> ([Double]){
    
    let k1 = function(y,t)
    let k2 = function(y + (dt * 0.5) * k1, t + 0.5 * dt)
    let k3 = function(y + 0.5 * dt * k2, t + 0.5 * dt)
    let k4 = function(y + dt * k3, t + dt)
    
    return dt * (k1 + (2 * k2) + (2 * k3) + k4) / 6
}

/** Take a half step, a full step and a double step.
    If the difference between double step and single step is below dx_min double the step size
    If the difference between half step and single step  is above dx_max half the step size */
public func runge_kutta_adaptive_stepper(function: ([Double], Double) -> ([Double]), y:[Double], t:Double, dt:Double) -> ([Double], Double){
    
    /** Fixed step size */
    var h = dt
    let h_fixed = 0.01
    let h_min = 0.0001

    /** Normal step value */
    var step:[Double] = []

    /** Half step value */
    var half_step:[Double] = []

    /** Double step value */
    var double_step:[Double] = []

    /** Tolerable difference ranges */
    let dx_min = 0.008
    let dx_max = 0.01

    /** Calculating full step based on fixed step size */
    let k1 = function(y, t)
    var k2 = function(y + k1 * h / 2, t + h/2)
    var k3 = function(y + k2 * h / 2, t + h/2)
    var k4 = function(y + k3 * h, t + h)
    
    step = h * (k1 + 2 * k2 + 2 * k3 + k4) / 6


    /** Calculating half step based on fixed step size */
    k2 = function(y + k1 * h / 4, t + h/4)
    k3 = function(y + k2 * h / 4, t + h/4)
    k4 = function(y + k3 * h, t + h/2)

    half_step = h * (k1 + 2 * k2 + 2 * k3 + k4) / 12
    


    /** Calculating Double step based on fixed step size */
    k2 = function(y + k1 * h , t + h)
    k3 = function(y + k2 * h , t + h)
    k4 = function(y + k3 * h, t + 2*h)

    double_step = h * (k1 + 2 * k2 + 2 * k3 + k4) / 3
    

    /** Checking if step size is above defined limit to control speed */
    if h < h_min{
        h = h_fixed
    }
    
    /** Taking care of different number of generalised coordinates */
    if step.count != 2{
        /** Updating step size */
        if (abs(step[2] - half_step[2]) > dx_max || abs(step[3] - half_step[3]) > dx_max){
            h = h/2
        }
            
        else if(abs(double_step[2] - step[2]) < dx_min || abs(double_step[3] - step[3]) < dx_min){
            h = 2 * h
        }
    }
        
    else{
        
        /** Duffing Oscillator handling */
        if (abs(step[1] - half_step[1]) > dx_max){
            h = h/2
        }
            
        else if(abs(double_step[1] - step[1]) < dx_min){
            h = 2 * h
        }
    }


    return (half_step, h)
}
