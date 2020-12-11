import Foundation


public struct DoublePendellum{

    var g = 9.8

    init(m1:Double , m2:Double, l1:Double, l2:Double, x1:Double, x2:Double, y1:Double, y2:Double){
        self.m1 = m1
        self.m2 = m2
        self.l1 = l1
        self.l2 = l2
        self.x1 = x1
        self.x2 = x2
        self.y1 = y1
        self.y2 = y2
        self.z1 = 0
        self.z2 = 0
    }
    /** Solves using the fourth order runge kutta method */
    func runge_kutta(function:(Double) -> Double, y:Double, h:Double) -> Double{
    
        var k1 = function(y)
        var k2 = function(y + h * k1/2)
        var k3 = function(y + h * k2/2)
        var k4 = function(y + h * k3)

        return (k1 + 2 * k2 + 2 * k3 + k4) / 6
    }
    
    
    func fz1(y:Double) -> Double{
    
        a =  - (self.m2 * self.l2 * self.z2 * cos(self.x1 - self.x2)) / (self.l1 * (self.m1 + self.m2))
        b =  - self.m2 * self.l2 * self.y2 * self.y2 * sin(self.x1 - self.x2) / (self.l1 * (self.m1 + self.m2))
        c =  - self.g * sin(self.x1) / self.l1
        return (a + b + c)
    }

    func fz2(y:Double) -> Double{
    
        a = - self.l1 * self.z1 * cos(self.x1 - self.x2) / self.l2
        b = self.l1 * self.y1 * self.y1 * sin(self.x1 - self.x2)/ self.l2
        c = - self.g * sin(self.x2)/ self.l2
        return (a + b + c)
    }
    
    
    func solve(dt:Double, n:Int, type:Int) -> ([Double],[Double],[Double],[Double]){
   
        var t = 0
        var times:[Double] = []

        var x1_arr:[Double] = []
        var x2_arr:[Double] = []
        var y1_arr:[Double] = []
        var y2_arr:[Double] = []
        
        for _ in 0...n{

            if type == 1{
                self.z1 = self.fz1(self.y1)
                self.z2 = self.fz2(self.y2)
            }
            
            else {
                self.z1 = self.runge_kutta(self.first_order_fz1, self.y1, 0.001)
                self.z2 = self.runge_kutta(self.first_order_fz2, self.y2, 0.001)
            }

            self.y1 += self.z1 * dt
            self.y2 += self.z2 * dt
            self.x1 += self.y1 * dt
            self.x2 += self.y2 * dt

            x1_arr.append(self.x1 * 3.14 / 180)
            x2_arr.append(self.x2 * 3.14 / 180)
            y1_arr.append(self.y1)
            y2_arr.append(self.y2)
            times.append(t)

            t += dt

        return (x1_arr, y1_arr, x2_arr, y2_arr)
    }
}


