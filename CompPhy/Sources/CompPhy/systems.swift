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

    public mutating func step(dt:Double, n:Int){
        
        for i in 1...n{
            self.velocity += (-self.g*sin(self.theta*3.14/180)/self.length)*dt
            self.theta += self.velocity*dt
            self.positions.append(self.theta)
        }

        print(self.positions)

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
        self.m = self.mass
        self.k = self.spring_constant    
    }

    public func z1(){
        /**Returns the acceleration of the first generalised coordinate**/
        return (-self.g*sine(3.14*self.theta/180) - 2*self.velocity*self.v_l) / self.length)
    }

    public func z2(){
        /**Returns the acceleration of the second generalised coordinate**/
        return (self.m*(self.length+self.dl)*self.velocity_theta**2 - self.k*(self.dl) + self.m*self.g*cos(3.14*self.theta/180)) / self.m)
    }

    public mutating func solve(dt:Double, n:Int){

        times:[Double] = []
        x1: [Double] = []
        x2: [Double] = []
        y1: [Double] = []
        y2: [Double] = []
        var t = 0.0

    for i in 0...n{
        var acceleration_theta = self.z1()
        var acceleration_length = self.z2()
        self.velocity_theta += (acceleration_theta * dt)
        self.dv += acceleration_length* dt 
        self.theta += self.velocity*dt
        self.dl += self.v_l*dt
        x1.append(self.theta)
        x2.append(self.dl)
        y1.append(self.velocity_theta)
        y2.append(self.dv)
        t+=dt
        times.append(t)
        print(self.theta)
    }
}