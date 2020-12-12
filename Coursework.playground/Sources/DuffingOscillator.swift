import Foundation

public struct DuffingOscillator{
    
    
    /** x - position , y - first derivative of position with respect to time, z = second derivative with respect to time */
    var x:Double
    var y:Double
    var z:Double
    
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
        
        self.x = x
        self.y = y
        
        /** Starting off acceleration at 0 */
        self.z = 0
        
        self.a = a
        self.b = b
        self.d = d
        self.w = w
        self.g = g
    }
    
    /** Returns the acceleration for time step dt */
    private func fz(t:Double, y:Double) -> Double{
        return self.g * cos(self.w * t) - (self.d * y) - (self.a * self.x) - (self.b * self.x * self.x * self.x)
    }
    
    /** Fourth order runge kutta method. Taken from (https://lpsa.swarthmore.edu/NumInt/NumIntFourth.html) */
    private func runge_kutta(function:(Double, Double) -> Double, t:Double, y:Double, h:Double) -> Double{
        
        let k1 = function(t, y)
        let k2 = function(t + h / 2, y + h * k1 / 2)
        let k3 = function(t + h / 2, y + h * k2 / 2)
        let k4 = function(t + h, y + h * k3)
        
        return (k1 + 2 * k2 + 2 * k3 + k4) / 6
    }
    
    /** Solves the damping equation by integrating it over time steps dt.
    * Uses two methods type 1 = euler, type 2 = runge kutta */
    public mutating func solve(dt:Double, n:Int, type:Int) -> ([Double], [Double]) {
        
        /** Arrays for storing the data */
        var x_arr:[Double] = []
        var y_arr:[Double] = []
       
        /** Initializing the time of the system */
        var t = 0.0
        
        for _ in 0...n{
            
            /** Checking if the user wants euler or runge kutta method
                Obtaining the acceleration of the time step from fz */
            if type == 1 {
                self.z = self.fz(t:t, y:self.y)
            }
                
            else{
                self.z = self.runge_kutta(function:self.fz, t:t, y:self.y, h:0.0001)
            }
            
            /** Integrating the velocity and position for the time step dt */
            self.y += self.z * dt
            self.x += self.y * dt
            
            /** Appending the values of position and velocity in the array */
            x_arr.append(self.x)
            y_arr.append(self.y)
            
            /** Updating the time step */
            t += dt
        }
        
        /** Returning the calculated data for analysis */
        return (x_arr, y_arr)
    }
}
