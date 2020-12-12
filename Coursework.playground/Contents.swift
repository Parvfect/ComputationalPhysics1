import UIKit


var t = DuffingOscillator(x: 0, y: 0, a: 1, b: 5, w: 0.5, d: 8, g: 0.03)
var x = t.solve(dt: 0.01, n: 50000, type: 2)

for i in x.0{
    i
}

for i in x.1 {
    i
}

