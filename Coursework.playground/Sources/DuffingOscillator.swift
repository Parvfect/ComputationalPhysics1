import Foundation

public struct DuffingOscillator{
    
    
    /** x - position , y - first derivative of position with respect to time, z = second derivative with respect to time */
    var y: [Double] = [0.0, 0.0, 0.0]
    
    /* Constants that impact the duffing oscillator
    * a - linear stiffness
    * b - amount of non linearity in restoring force
    * w - angular frequency of the driving force
    * d - controls the amount of damping
    * g - amplitude of periodic driving force
     
     Taken from (https://en.wikipedia.org/wiki/Duffing_equation) */
   
    var a:Double
    var b:Double
    var w:Double
    var d:Double
    var g:Double
    
    /** Initializes the data members based on user input */
    public init(x:Double, y:Double, a:Double, b:Double, w:Double, d:Double, g:Double){
        
        self.y[0] = x
        self.y[1] = y
        
        /** Starting off acceleration at 0 */
        self.y[2] = 0.0
        
        self.a = a
        self.b = b
        self.d = d
        self.w = w
        self.g = g
    }
    
    /** Returns the acceleration for time step dt */
    private func fz(y:[Double], t:Double) -> [Double]{
        
        let y1 = ((self.g * cos(self.w * t)) - (self.d * y[1]) - (self.a * self.y[0]) - (self.b * y[0] * y[0] * y[0]))
        return [y[1], y1]
    
    }
    
   
    /** Solves the damping equation by integrating it over time steps dt.
    * Uses two methods type 1 = euler, type 2 = runge kutta */
    public mutating func solve(dt:Double, n:Int, type:Int) -> ([Double], [Double]){
        
        /** Creating arrays to hold data regarding the positions, velocities of the generalised coordinates */
        var x1: [Double] = []
        var y1: [Double] = []
        
        var dt = dt
        
        /**Initializing the time variable */
        var t = 0.0
        
        /** Integrating the equation from 0 to n steps, with a time step of dt */
        for _ in 0...n{
            
            /**Getting the value for the acceleration of the generalised coordinates in dt */
            
            /** Switching between euler and runge kutta method */
            if type == 1{
                self.y += runge_kutta(function: self.fz, y: self.y, t: t, dt: dt)
            }
                
                /** else if type == 2{
                 self.y += euler(function: self.fz, y: self.y, t: t, dt: dt)
                 }
                 */
            else if type == 3{
                let val = runge_kutta_adaptive_stepper(function: self.fz, y: self.y, t: t, dt: dt)
                self.y += val.0
                dt = val.1
            }
                
            else if type == 4{
                let val = euler_adaptive_step(function: self.fz, y: self.y, t: t, dt: dt)
                self.y += val.0
                dt = val.1
            }
            
            
            
            /** Appending the angle in the array in degrees */
            x1.append(self.y[0] * 3.14 / 180)
            
            /** Appending the positions and velocities of the generalised coordinates to the arrays */
            y1.append(self.y[1])
            
            /** Updating the time of the system */
            t += dt
            
            
        }
        
        /** Returning the data for analysis */
        return (x1, y1)
        
    }
}
