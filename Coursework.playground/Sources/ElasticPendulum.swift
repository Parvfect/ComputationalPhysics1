import Foundation


public struct ElasticPendellum{
    
    var length:Double
    var y = [0.0, 0.0, 0.0, 0.0]
    var g = 9.8
    var m:Double
    var k:Double
    
    /**Initialises the data members */
    public init(length:Double, x1:Double, y1:Double, x2:Double, y2:Double, mass:Double, spring_constant:Double){
        
        self.length = length
        self.y[0] = x1
        self.y[1] = x2
        self.y[2] = y1
        self.y[3] = y2
        self.m = mass
        self.k = spring_constant
   }
    
    
    
    private func fz(y:[Double], t:Double) -> ([Double]){
        
        let y12 = (-self.g * sin(y[0]) - 2 * y[3] * y[2] ) / (self.length + y[2])
        let y22 = (self.length + y[1]) * y[2] * y[2] - (self.k * (y[1]) / self.m)  +  self.g * cos(y[0])
        
        return [y[2], y[3], y12, y22]
    }
    
    
    
    /**Solves the differential equation using euler step or runge kutta. type = 1 runs euler and 2 runs runge kutta*/
    public mutating func solve(dt:Double, n:Int, type:Int) -> ([Double], [Double], [Double], [Double]){
        
        /** Creating arrays to hold data regarding the positions, velocities of the generalised coordinates */
        var x1: [Double] = []
        var x2: [Double] = []
        var y1: [Double] = []
        var y2: [Double] = []
        
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
            x2.append(self.y[1])
            y1.append(self.y[2] * self.m)
            y2.append(self.y[3] * self.m)
            
            /** Updating the time of the system */
            t += dt
            
            
        }
        
        /** Returning the data for analysis */
        return (y1, y2, x1, x2)
        
    }
}
