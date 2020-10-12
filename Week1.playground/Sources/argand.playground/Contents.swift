import Foundation
import UIKit
import PlaygroundSupport

public protocol ArgandDiagramable {
    func getRealValue() -> Double
    func getImagValue() -> Double
}

public class ArgandDiagram<T: ArgandDiagramable>: UIView {
    private var limit: Int = 0
    private var scale: Int = 1
    private var vector: T
    private let offSet: CGFloat = 50
    
    public init(_ vectorIn: T) {
        vector = vectorIn
        
        var maxValue = max(abs(vectorIn.getRealValue()), abs(vectorIn.getImagValue()))
        
        if maxValue.remainder(dividingBy: 5.0) != 0.0 {
            maxValue += 5.0 - maxValue.remainder(dividingBy: 5.0)
        }
        
        limit = Int(maxValue)
        scale = Int(maxValue / 5.0)
        
        super.init(frame: CGRect(x: 0, y: 0, width: 500 + 2*offSet, height: 500 + 2*offSet))
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func draw(_ rect: CGRect) {
        let width = rect.width - 2*offSet
        let height = rect.height - 2*offSet
        let framedRect = CGRect(x: offSet, y: offSet, width: width, height: height)
        
        UIColor(red: 1, green: 1, blue: 1, alpha: 1).setFill()
        UIBezierPath(rect: CGRect(x: 0, y: 0, width: 500 + 2*offSet, height: 500 + 2*offSet)).fill()
        
        labelAxis("Re", in: CGRect(x: width + offSet + 20, y: height/2 + 45, width: 40, height: 10))
        labelAxis("Im", in: CGRect(x: width/2 + 42, y: offSet - 25, width: 40, height: 10))
        drawXTics(xtics(framedRect, maxValue: limit))
        drawYTics(ytics(framedRect, maxValue: limit))
        UIColor(red: 0, green: 0, blue: 0, alpha: 1).set()
        drawAxis(framedRect)
        
        UIColor.red.set()
        UIColor.red.setFill()
        
        let line = UIBezierPath()
        
        line.move(to: CGPoint(x: width/2 + offSet, y: height/2 + offSet))
        line.addLine(to: CGPoint(x: CGFloat(vector.getRealValue())*width / CGFloat(2*limit) + width/2 + offSet,
                                 y: -CGFloat(vector.getImagValue())*height / CGFloat(2*limit) + height/2 + offSet))
        line.lineWidth = 2
        line.stroke()
        
        let center = CGPoint(x: CGFloat(vector.getRealValue())*width / CGFloat(2*limit) + width/2 + offSet,
                             y: -CGFloat(vector.getImagValue())*height / CGFloat(2*limit) + height/2 + offSet)
        let radius = 2.5
        line.addArc(withCenter: center, radius: CGFloat(radius), startAngle: 0.0, endAngle: .pi * 2.0, clockwise: true)
        
        // Draw
        line.stroke()
        
        PlaygroundPage.current.liveView = self
    }
    
    private func drawAxis(_ rect: CGRect) {
        let grid = UIBezierPath()
        let width = rect.width
        let height = rect.height
        
        grid.lineWidth = 2
        grid.move(to: CGPoint(x: offSet, y: height/2 + offSet))
        grid.addLine(to: CGPoint(x: width + offSet, y: height/2 + offSet))
        grid.move(to: CGPoint(x: width/2 + offSet, y: offSet))
        grid.addLine(to: CGPoint(x: width/2 + offSet, y: height + offSet))
        grid.stroke()
    }
    
    private func labelAxis(_ textIn: String, in box: CGRect) {
        let label = UILabel(frame: box)
        
        label.text = textIn
        label.textColor = UIColor.purple
        label.drawText(in: box)
    }
    
    private func drawXTics(_ tics: [CGPoint]) {
        let size = CGSize(width: 0.01, height: 500)
        
        for i in 0..<tics.count {
            let quad = UIBezierPath(rect: CGRect(origin: tics[i], size: size))
            
            UIColor(red: 103/255, green: 146/255, blue: 195/255, alpha: 1).set()
            quad.fill()
            quad.stroke()
            
            if -tics.count/2 + i != 0 {
                let label = UILabel(frame: CGRect(origin: tics[i], size: CGSize(width: 40, height: 10)))
                
                label.text = "\((-tics.count/2 + i) * scale)"
                label.textColor = UIColor.purple
                label.drawText(in: CGRect(x: tics[i].x-10, y: tics[i].y + 10 + 250, width: 40, height: 20))
            }
        }
    }
    
    private func xtics(_ rect: CGRect, maxValue: Int) -> [CGPoint] {
        let width = rect.width
        var tics = [CGPoint]()
        
        for step in 0...(maxValue/scale)*2 {
            tics.append(CGPoint(x: offSet + width/(CGFloat(maxValue/scale * 2)) * CGFloat(step), y: offSet))
        }
        
        return tics
    }
    
    private func drawYTics(_ tics: [CGPoint]) {
        let size = CGSize(width: 500, height: 0.01)
        
        for i in 0..<tics.count {
            let quad = UIBezierPath(rect: CGRect(origin: tics[i], size: size))
            
            UIColor(red: 103/255, green: 146/255, blue: 195/255, alpha: 1).set()
            quad.fill()
            quad.stroke()
            
            if -tics.count/2 + i != 0 {
                let label = UILabel(frame: CGRect(origin: tics[i], size: CGSize(width: 40, height: 10)))
                
                label.text = "\((tics.count/2 - i) * scale)"
                label.textColor = UIColor.purple
                label.drawText(in: CGRect(x: tics[i].x + 10 + 250, y: tics[i].y - 10, width: 40, height: 20))
            }
        }
    }
    
    private func ytics(_ rect: CGRect, maxValue: Int) -> [CGPoint] {
        let height = rect.height
        var tics = [CGPoint]()
        
        for step in 0...(maxValue/scale)*2 {
            tics.append(CGPoint(x: offSet, y: offSet + height/(CGFloat(maxValue/scale * 2)) * CGFloat(step)))
        }
        
        return tics
    }
}
