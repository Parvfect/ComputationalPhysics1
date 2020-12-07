import Foundation

public struct SimpleHarmonicOscillator{
    
    var frequency: Double
    var position: Double
    var velocity: Double
    
    
}


public struct SimplePendellum{
    
    var length:Double
    var x1: Double
    var g: Double
    var velocity: Double
    var acceleration: Double
    var positions: [Double]
    
    public init(length:Double, x1:Double, velocity:Double){
        self.length = length
        self.x1 = x1
        self.velocity = velocity
        self.g = 9.8
        self.acceleration = 0.0
        self.positions = []
    }
    
    public mutating func step(dt:Double, n:Int) -> [Double]{
        
        for _ in 1...n{
            self.velocity += (-self.g*sin(self.x1*3.14/180)/self.length)*dt
            self.x1 += self.velocity*dt
            self.positions.append(self.x1)
        }
        
        return self.positions
        
    }
    
    
    public func compute_acceleration() -> Double{
        return -self.g*sin(self.x1)/self.length
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
