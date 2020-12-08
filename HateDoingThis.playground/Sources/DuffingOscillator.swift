import Foundation

public struct DuffingOscillator{

    var g = 9.8 

    public init(x:Double, y:Double, a:Double, b:Double, w:Double, d:Double){
        self.x = x
        self.y = y
        self.z = 0
        self.a = a
        self.b = b
        self.d = d
        self.w = w
    }
    
    private func fz(t:Double, y:Double) -> Double{
        return self.g * cos(self.w * t) - (self.d * y) - (self.a * self.x) - (self.b * self.x * self.x * self.x)
    }

    private func runge_kutta(function:(Double, Double) -> Double, t:Double, y:Double, h:Double) -> Double{
        
        k1 = function(t, y)
        k2 = function(t+ h/2, y + h*k1/2)
        k3 = function(t + h/2, y + h*k2/2)
        k4 = function(t+ h, y + h*k3)
        
        return (k1 + 2* k2 + 2 * k3 + k4) / 6
    }        
    
    public func solve(dt:Double, n:Int, type:Int) -> ([Double], [Double]) {

        var x_arr:[Double] = []
        var y_arr:[Double] = []
        var times:[Double] = []
        var t = 0
        
        for _ in 0...n{  
            
            if type == 1 {
                self.z = self.fz(t, self.y)
            }
     
            else{
                self.z = self.runge_kutta(function:self.fz, t:t, y:self.y, h:0.0001)
            }
     
            self.y += self.z*dt 
            self.x += self.y*dt
            x_arr.append(self.x)
            y_arr.append(self.y)

            t+=dt
            times.append(t)
        }
    
        return positions, vels
    }