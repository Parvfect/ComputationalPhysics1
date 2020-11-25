import Foundation

/*Why is this so different - tan 
print(TrapezoidalIntegration(function:tan, x:0.0, n:1000, upper:(Double.pi)))
print(SimpsonIntegration(function:tan, x:0.0, n:1000, upper:(Double.pi)))
**/

var t = SimplePendellum(length:9.8, theta:-20, velocity:33)

print(t.step(dt:0.001, n:10000))