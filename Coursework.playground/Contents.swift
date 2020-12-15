import UIKit

var t = DoublePendellum(m1:2.5 , m2:2.5, l1:3.2, l2:2.7, x1:0.3, x2:0.4, y1:0.002, y2:0.003)
var x = t.solve(dt: 0.001, n: 10000, type: 1)
for i in x.0{
    i
}

for i in x.1 {
    i
}

