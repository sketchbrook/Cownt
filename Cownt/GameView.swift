//
//  GameView.swift
//  Cownt
//
//  Created by Jamie Brook on 15/04/2015.
//  Copyright (c) 2015 sketchbrook. All rights reserved.
//

import UIKit


class GameView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    var label:UILabel!;
    var label_diff:UILabel!;
    var time:Int = 0;
    var lastLocation:CGPoint = CGPointMake(0, 0)
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor();
        var panRecognizer = UIPanGestureRecognizer(target:self, action:"detectPan:");
        self.gestureRecognizers = [panRecognizer];
    }
    
    func detectPan(recognizer:UIPanGestureRecognizer) {
        NSLog("PANNING");
        var translation  = recognizer.translationInView(self.superview!)
        self.center = CGPointMake(lastLocation.x + translation.x, lastLocation.y + translation.y)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    func detectTap(){
        NSLog("TAPPED");
    }
    
    
    override func drawRect(rect: CGRect)
    {
        var startAngle: Float = Float(2 * M_PI)
        var endAngle: Float = 0.0
        
        // Drawing code
        // Set the radius
        let strokeWidth = 3.0
        let radius = CGFloat((CGFloat(self.frame.size.width) - CGFloat(strokeWidth)) / 2)
        
        // Get the context
        var context = UIGraphicsGetCurrentContext()
        
        // Find the middle of the circle
        let center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2)
        
        // Set the stroke color
        CGContextSetStrokeColorWithColor(context, UIColorFromRGB(0xFFFFFF).CGColor)
        
        // Set the line width
        CGContextSetLineWidth(context, CGFloat(strokeWidth))
        
        // Set the fill color (if you are filling the circle)
        CGContextSetFillColorWithColor(context, UIColorFromRGB(0xFFFFFF).CGColor)
        CGContextFillPath(context)
        // Rotate the angles so that the inputted angles are intuitive like the clock face: the top is 0 (or 2π), the right is π/2, the bottom is π and the left is 3π/2.
        // In essence, this appears like a unit circle rotated π/2 anti clockwise.
        startAngle = startAngle - Float(M_PI_2)
        endAngle = endAngle - Float(M_PI_2)
        
        // Draw the arc around the circle
        CGContextAddArc(context, center.x, center.y, CGFloat(radius), CGFloat(startAngle), CGFloat(endAngle), 0)
        
        // Draw the arc
        CGContextDrawPath(context, kCGPathFillStroke) // or kCGPathFillStroke to fill and stroke the circle
        
        label = UILabel(frame: CGRectMake(0, -75, 100, 100))
        label.textAlignment = NSTextAlignment.Center;
        label.textColor = UIColor.whiteColor();
        var countToString = toString(time);
        label.text = countToString;
        label.font = UIFont (name: "Helvetica Neue", size: 30);
        label.userInteractionEnabled = false;
        self.addSubview(label);

        label_diff = UILabel(frame: CGRectMake(0, -75, 100, 100))
        label_diff.textAlignment = NSTextAlignment.Center;
        label_diff.textColor = UIColor.whiteColor();
        label_diff.text = "";
        label_diff.font = UIFont (name: "Helvetica Neue", size: 20);
        label_diff.userInteractionEnabled = false;
        self.addSubview(label_diff);

        
         self.layer.shadowOffset = CGSize(width: 0, height: 0)
         self.layer.shadowOpacity = 0.7
         self.layer.shadowRadius = 5
    }
    
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}
