import UIKit
import Foundation



var sp = SimplePendellum(length: 1.0, theta: 0.2, velocity: 0.03)
var t = sp.step(dt: 0.01, n: 2000)

for element in t{
    element
}
//var a = Vector(dimensions: 2, elements: [2,3])

//a.euler_step(function: VectorConj, y0: a, n: 100, delta: 0.01)


var sp2 = ElasticPendellum(length: 5.0, theta: 0.3, velocity_theta: 3.2, dl: 0.3, dv: 0.8, mass: 3, spring_constant: 7.5)
var s = sp2.solve(dt: 0.01, n: 10000)

for element in s.0{
    print(element)
}

for element in s.1{
    print(element)
}

for element in s.2{
    print(element)
}

for element in s.3{
    print(element)
}


