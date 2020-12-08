import Foundation


public struct ElasticPendellum{
    var length:Double
    var x1:Double
    var y1:Double
    var x2:Double
    var y2:Double
    var g = 9.8
    var m:Double
    var k:Double
    var z1:Double
    var z2:Double
    
    /**Initialises the data members */
    public init(length:Double, x1:Double, y1:Double, x2:Double, y2:Double, mass:Double, spring_constant:Double){
        self.length = length
        self.x1 = x1
        self.y1 = x1
        self.x2 = x2
        self.y2 = y2
        self.m = mass
        self.k = spring_constant
        self.z1 = 0
        self.z2 = 0
    }
    
    /** Generalised fourth order runge kutta method to calculate next step value using midpoint */
    private func runge_kutta(function:(Double) -> Double, h:Double, y:Double) -> Double {
        
        /* The function refers to the respective equation of motion whose next value needs to be calculated for dt.
          The function explicitly depends on the first differential of the specific generalised coordinate */
        let k1 = function(y)
        let k2 = function(y + h * k1/2)
        let k3 = function(y + h * k2/2)
        let k4 = function(y + h * k3)
        return ((k1 + 2 * k2 + 2 * k3 + k4) / 6)
    }
    
    /**Returns the acceleration of the first generalised coordinate (change in theta made with vertical) */
    private func fz1(y:Double) -> Double {
        let g_factor =  -self.g * sin(self.x1)
        let v_factor =  2 * y * self.y2
        return (g_factor - v_factor / (self.length + self.x2))
    }
    
    
    /**Returns the acceleration of the second generalised coordinate (change in length of spring) */
    private func fz2() -> Double {
        let v_factor = self.m * (self.length + self.x2) * self.y1 * self.y1
        let k_factor = self.k * (self.x2)
        let g_factor = self.m * self.g * cos(self.x1)
        
        return ((v_factor - k_factor + g_factor) / self.m)
        
    }
    
    
    /**Solves the differential equation using euler step or runge kutta. type = 1 runs euler and 2 runs runge kutta*/
    public mutating func solve(dt:Double, n:Int, type:Int) -> (mom1_arr: [Double], mom2_arr : [Double], p1_arr:[Double], p2_arr:[Double]){
        
        /** Creating arrays to hold data regarding the positions, velocities and time of the generalised coordinates */
        var times: [Double] = []
        var x1: [Double] = []
        var x2: [Double] = []
        var y1: [Double] = []
        var y2: [Double] = []
        
        /**Initializing the time variable */
        var t = 0.0
        
        /** Integrating the equation from 0 to n steps, with a time step of dt */
        for _ in 0...n{
            
            /**Getting the value for the acceleration of the generalised coordinates in dt */
            
            /** Switching between euler and runge kutta method */
            if type == 1{
                self.z1 = self.fz1(y:self.y1)
            }
            
            else{
                self.z1 = self.runge_kutta(function: self.fz1, h: 0.001, y: self.y1)
            }
            
            self.z2 = self.fz2()
            
            /** Updating the change in velocities of the generalised coordinates in dt */
            self.y1 += (self.z1 * dt)
            self.y2 += self.z2 * dt
            
            /** Updating positions based on change in dt */
            self.x1 += self.y1 * dt
            self.x2 += self.y2 * dt
            
            /** Appending the angle in the array in degrees */
            x1.append(self.x1 * 3.14 / 180)
            
            /** Appending the positions and velocities of the generalised coordinates to the arrays */
            x2.append(self.x2)
            y1.append(self.y1 * self.m)
            y2.append(self.y2 * self.m)
            
            /** Updating the time of the system */
            t+=dt
            
            /** Appending the time to the time array */
            times.append(t)
            
        }
        
        /** Returning the data for analysis */
        return (y1, y2, x1, x2)
        
    }
}
