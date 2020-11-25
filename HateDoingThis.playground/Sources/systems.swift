
public struct SimpleHarmonicOscillator{
    
    var frequency: Double
    var position: Double
    var velocity: Double

    public func solve(function: (Double, Double) -> Double) -> [Vector]{
        
        velocity += euler_step(function: function, h: 0.001, y0: 4, t0: 0, steps: 1000)
        
    }
    
    public func dddtv(position: Double, frequency: Double){
        return -(frequency*frequency*position)
    }
    
}


