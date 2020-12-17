import Foundation

public struct DoublePendellum{
    
    /** System Variables
        g - acceleration due to gravity
        y - array that holds the positions velocities of the generalised coordinates
        z1, z2 - acceleration of the generalised coordinates
        m1, m2 - mass of the two bobs
        l1, l2 - Lengths of the two strings of the Pendulum */
    
    var g = 9.8
    var y:[Double] = [0.0, 0.0, 0.0, 0.0]
    var z1 = 0.0
    var z2 = 0.0
    var m1 = 0.0
    var m2 = 0.0
    var l1 = 0.0
    var l2 = 0.0

    /** Constructor that initializes the data members */
    public init(m1:Double , m2:Double, l1:Double, l2:Double, x1:Double, x2:Double, y1:Double, y2:Double){
        self.m1 = m1
        self.m2 = m2
        self.l1 = l1
        self.l2 = l2
        self.y[0] = x1
        self.y[1] = x2
        self.y[2] = y1
        self.y[3] = y2
        self.z1 = 0
        self.z2 = 0
    }
    
    /** Function that returns the updated array based on the derivatives of the time step dt */
    private func fz(y:[Double], t:Double) -> ([Double]){
        
        /** Second derivative of first generalised coordinate */
        let y21 = -(self.m2 * self.l2 * y[1] * cos(y[0] - y[1]))/(self.l1*(self.m1+self.m2)) - self.m2 * self.l2 * y[3] * sin(y[0] - y[1])/(self.l1*(self.m1+self.m2)) - self.g * sin(y[0]) / self.l1
        
        /** Second derivative of the second generalised coordinate */
        let y22 = (-self.l1 * self.z1 * cos(y[0] - y[1])/self.l2) + (self.l1 * y[2] * y[2] * sin(y[0] - y[1])/self.l2) - (self.g * sin(y[1])/self.l2)
        
        /** Returning the updated array */
        return [y[2], y[3], y21, y22]
    
    }
    
    /** Solves the differential equation using the integration methods in numerical_integration.
        type = 1 - RK4,  2 - Euler,  3 - RK4(Adaptive Step),  4 - Euler(Adaptive Step)
        Returns the positions and velocites of the generalised coordinates for (dt * n) time period */
    public mutating func solve(dt:Double, n:Int, type:Int) -> ([Double], [Double], [Double], [Double]){
        
        /** Creating arrays to hold data regarding the positions, velocities of the generalised coordinates */
        var x1: [Double] = []
        var x2: [Double] = []
        var y1: [Double] = []
        var y2: [Double] = []
        
        /** Initialising the step size */
        var dt = dt
        
        /**Initializing the time variable */
        var t = 0.0
        
        /** Integrating the equation from 0 to n steps, with a time step of dt */
        for _ in 0...n{
            
            /** Getting the updated array of the generalised coordinates in dt based on the method of integration chosen. */
            if type == 1{
                self.y = self.y + runge_kutta(function: self.fz, y: self.y, t: t, dt: dt)
            }
                
            else if type == 2{
                self.y = self.y + euler(function: self.fz, y: self.y, t: t, dt: dt)
            }
                
            else if type == 3{
                let val = runge_kutta_adaptive_stepper(function: self.fz, y: self.y, t: t, dt: dt)
                self.y = self.y + val.0
                
                /** Updating the step size */
                dt = val.1
            }
                
            else if type == 4{
                let val = euler_adaptive_step(function: self.fz, y: self.y, t: t, dt: dt)
                self.y = self.y + val.0
                
                /** Updating the step size */
                dt = val.1
            }
          
            /** Appending the angle in the array in degrees */
            x1.append(self.y[0] * 3.14 / 180)
            
            /** Appending the positions and velocities of the generalised coordinates to the arrays */
            x2.append(self.y[1])
            y1.append(self.y[2] * self.m1)
            y2.append(self.y[3] * self.m2)
            
            /** Updating the time of the system */
            t += dt
            
            
        }
        
        /** Returning the data for analysis */
        return (x1, x2, y1, y2)
        
    }

}
