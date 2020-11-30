import Foundation

/**
import UIKit

/*override func draw(_ rect: UIRect) {
    UIColor(red: 103/255, green: 146/255, blue: 195/255, alpha: 1).set()
    let line = UIBezierPath()
    line.move(to: UIMakePoint(10, 5))
    line.line(to: UIMakePoint(90, 5))
    line.lineWidth = 2
    line.stroke()

    UIColor(red: 163/255, green: 189/255, blue: 218/255, alpha: 1).setFill()

    let origiUI = [UIPoint(x: 10, y: 1),
                   UIPoint(x: 50, y: 1),
                   UIPoint(x: 90, y: 1)]

    let size = UISize(width: 8, height: 8)

    for origin in origiUI {
        let quad = UIBezierPath(roundedRect: UIRect(origin: origin, size: size), xRadius: 2, yRadius: 2)
        quad.fill()
        quad.stroke()
    }
}

draw()
**/
// this function creates a plot of an array of doubles where it scales to the provided width and the x-axis is on half height
public func plotArray(arr: [Double], width: Double, height: Double) -> UIImage {
    if arr.isEmpty { return UIImage() }
    let xAxisHeight = height / 2
    let increment = width / Double(arr.count)
    let image = UIImage(size: UISize(width: width, height: height))
    
    image.lockFocus()
    // set background color
    UIColor.whiteColor().set()
    
    UIRectFill(UIRect(x: 0, y: 0, width: width, height: height))
    
    let path = UIBezierPath()
    // line width of plot
    path.lineWidth = 5
    path.moveToPoint(UIPoint(x: 0, y: arr[0] * increment + xAxisHeight))
    
    var i = increment
    for value in dropFirst(sineWave) {
        path.lineToPoint(UIPoint(x: i, y: value * increment + xAxisHeight))
        i += increment
    }
    
    // set plot color
    UIColor.blueColor().set()
    path.stroke()
    
    image.unlockFocus()
    return image
}



**/
