import UIKit
import Foundation



//var a = Vector(dimensions: 2, elements: [2,3])

//a.euler_step(function: VectorConj, y0: a, n: 100, delta: 0.01)


var sp2 = ElasticPendellum(length: 5.0, x1: 0.3, y1: 0.032, x2: 0.3, y2: 0.08, mass: 3, spring_constant: 7.5)
var s = sp2.solve(dt: 0.01, n: 10000, type:2)

for element in s.0{
    element
}


for element in s.1{
    element
}


for element in s.2{
    element
}

for element in s.3{
    element
}



