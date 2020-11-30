import Foundation

public struct SimpleHarmonicOscillator{
    
    var frequency: Double
    var position: Double
    var velocity: Double
    
    
}


public struct SimplePendellum{
    
    var length:Double
    var theta: Double
    var g: Double
    var velocity: Double
    var acceleration: Double
    var positions: [Double]
    
    public init(length:Double, theta:Double, velocity:Double){
        self.length = length
        self.theta = theta
        self.velocity = velocity
        self.g = 9.8
        self.acceleration = 0.0
        self.positions = []
    }
    
    public mutating func step(dt:Double, n:Int) -> [Double]{
        
        for _ in 1...n{
            self.velocity += (-self.g*sin(self.theta*3.14/180)/self.length)*dt
            self.theta += self.velocity*dt
            self.positions.append(self.theta)
        }
        
        return self.positions
        
    }
    
    
    public func compute_acceleration() -> Double{
        return -self.g*sin(self.theta)/self.length
    }
    
    public func euler_step(function: (Double) -> Double, h:Double, y0:Double, t0:Double, steps:Int) -> [Double]{
        //yn+1 = yn + hf(t,y)
        
        var y = y0
        var t = t0
        var y_arr :[Double] = []
        for _ in 0...steps{
            t += h
            y += function(t)
            y_arr.append(y)
        }
        
        return y_arr
        
    }
    
}


public struct ElasticPendellum{
    var length:Double
    var theta:Double
    var velocity_theta:Double
    var dl:Double
    var dv:Double
    var g = 9.8
    var m:Double
    var k:Double
    
    public init(length:Double, theta:Double, velocity_theta:Double, dl:Double, dv:Double, mass:Double, spring_constant:Double){
        self.length = length
        self.theta = theta
        self.velocity_theta = theta
        self.dl = dl
        self.dv = dv
        self.m = mass
        self.k = spring_constant
    }
    
    public func z1() -> Double {
        /**Returns the acceleration of the first generalised coordinate**/
        let g_factor =  -self.g * sin(3.14*self.theta/180)
        let v_factor =  2 * self.velocity_theta * self.dv
        return (g_factor - v_factor / (self.length))
    }
    
    public func z2() -> Double {
        /**Returns the acceleration of the second generalised coordinate**/
        let v_factor = self.m * (self.length + self.dl) * self.velocity_theta * self.velocity_theta
        let k_factor = self.k * (self.dl)
        let g_factor = self.m * self.g * cos(3.14 * self.theta / 180)
        
        return ((v_factor - k_factor + g_factor) / self.m)
        
    }
    
    public mutating func solve(dt:Double, n:Int) -> (mom1_arr: [Double], mom2_arr : [Double], p1_arr:[Double], p2_arr:[Double]){
        
        var times: [Double] = []
        var x1: [Double] = []
        var x2: [Double] = []
        var y1: [Double] = []
        var y2: [Double] = []
        var t = 0.0
        
        for _ in 0...n{
            let acceleration_theta = self.z1()
            let acceleration_length = self.z2()
            self.velocity_theta += (acceleration_theta * dt)
            self.dv += acceleration_length * dt
            self.theta += self.velocity_theta * dt
            self.dl += self.dv * dt
            x1.append(self.theta)
            x2.append(self.dl)
            y1.append(self.velocity_theta * self.m)
            y2.append(self.dv * self.m)
            t+=dt
            times.append(t)
        }
        return (y1, y2, x1, x2)
        
    }
}
