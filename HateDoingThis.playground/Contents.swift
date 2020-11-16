import UIKit
import Foundation


var t = TrapezoidalIntegration(function: square, x: 0, n: 6.0, upper:3.0)
print(t)
