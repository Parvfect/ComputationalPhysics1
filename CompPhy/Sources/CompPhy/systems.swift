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
        
        if n==0{
            print(self.positions)
        }
        else{
            self.acceleration += self.compute_acceleration()*dt
            self.velocity += self.acceleration*dt
            self.theta += self.velocity*dt
            self.positions.append(self.theta)
            self.step(dt:dt, n:(n-1))
        }

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
