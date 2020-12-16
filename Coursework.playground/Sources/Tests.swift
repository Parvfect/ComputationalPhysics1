import Foundation


/** Testing and returning the values for two initial conditions */
public func ElasticPendulumTests() -> (([Double], [Double], [Double], [Double]), ([Double], [Double], [Double], [Double])){
    
    var t1 = ElasticPendellum(l: 2.1, x1: 0.1, y1: 0.001, x2: 0.2, y2: 0.002, mass: 2.5, spring_constant: 18.9)
    var t2 = ElasticPendellum(l: 3.1, x1: 0.21, y1: 0.001, x2: 0.3, y2: 0.002, mass: 3.5, spring_constant: 8.9)
    
    let val1 = t1.solve(dt: 0.01, n: 1000, type: 2)
    let val2 = t2.solve(dt: 0.01, n: 1000, type: 4)
    
    return (val1, val2)
}


/** Testing and returning the values for two initial conditions */
public func DoublePendulumTests() -> (([Double], [Double], [Double], [Double]),([Double], [Double], [Double], [Double])){
    
    var t1 = DoublePendellum(m1: 0.24, m2: 2.5, l1: 0.3, l2: 4.5, x1: 0.3, x2: 0.02, y1: 0.003, y2: 0.002)
    var t2 = DoublePendellum(m1: 2.5, m2: 0.24, l1: 3.1, l2: 2.5, x1: 0.3, x2: 0.2, y1: 0.0, y2: 0.01)
    
    let val1 = t1.solve(dt: 0.01, n: 1000, type: 1)
    let val2 = t2.solve(dt: 0.01, n: 1000, type: 3)

    return (val1, val2)
    
}

/** Testing and returning the values for two initial conditions */
public func DuffingOscialltorTests() -> (([Double], [Double]),([Double], [Double])){
    var t1 = DuffingOscillator(x: 0.02, y: 0.001, a: 1, b: 5, w: 0.5, d: 0.02, g: 8)
    var t2 = DuffingOscillator(x: 0.03, y: 0.002, a: 1 , b: -1, w: 1, d: 0.2, g: 0.3)

    let val1 = t1.solve(dt: 0.01, n: 1000, type: 1)
    let val2 = t2.solve(dt: 0.01, n: 1000, type: 3)
    
    return (val1, val2)
}

