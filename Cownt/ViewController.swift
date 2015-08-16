//
//  ViewController.swift
//  Cownt
//
//  Created by Jamie Brook on 15/04/2015.
//  Copyright (c) 2015 sketchbrook. All rights reserved.
//


import UIKit



class ViewController: UIViewController {
    
    @IBOutlet weak var AvailTimeLabel: UILabel?
    @IBOutlet weak var scoreBar: UIView!
    @IBOutlet weak var img_diag: UIImageView!
    @IBOutlet weak var img_diag_red: UIImageView!
    
    var screenCenter:CGPoint = CGPointMake(0, 0);
    var timer = NSTimer();
    var myView: UIView!;
    var w:CGFloat = 0.0;
    var h:CGFloat = 0.0;
    var userTime:Float = 0.0;
    var numberOfPlayers:Int = 0;
    var targetTime:Int = 0;
    var finalTime:Float = 0.0;
    var tagValue:Int = 0;
    
    var AvilalbleTime:Float = 10.0;
   // var AvailableLabel_Center:CGPoint!;
    var fingerView1:UIView!;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColorFromRGB(0x712727)
        myView = self.view;
        w = myView.bounds.size.width;
        h = myView.bounds.size.height;
        screenCenter = CGPointMake(w/2, h/2);
        self.view.multipleTouchEnabled = true;
        self.scoreBar.multipleTouchEnabled = true;
        AvailTimeLabel?.text = "Tap and Hold to Begin"
        self.view.bringSubviewToFront(AvailTimeLabel!)

       // AvailableLabel_Center = CGPointMake(self.AvailTimeLabel!.center.x, self.AvailTimeLabel!.center.y)
    }
    
    func addPlayers(number_of_players: Int)
    {
        if(number_of_players == 1){
        var player1View = GameView(frame: CGRectMake(screenCenter.x - w/2, screenCenter.y - h/2, w, h))
        player1View.backgroundColor = UIColorFromRGB(0x004358);
        player1View.tag = 1;
        myView.addSubview(player1View);
        }
        if(number_of_players >= 2){
        var player1View = GameView(frame: CGRectMake(screenCenter.x - w/2, screenCenter.y - h, w, h))
        player1View.backgroundColor = UIColorFromRGB(0x004358);
        player1View.tag = 1;
        myView.addSubview(player1View);
        var player2View = GameView(frame: CGRectMake(screenCenter.x - w/2, screenCenter.y, w, h))
        player2View.backgroundColor = UIColorFromRGB(0x1F8A70);
        player2View.tag = 2;
        myView.addSubview(player2View);
        }
        if(number_of_players >= 3){
        var player3View = GameView(frame: CGRectMake(screenCenter.x - w, screenCenter.y - h, w, h))
        player3View.backgroundColor = UIColorFromRGB(0xFFE11A);
        player3View.tag = 3;
        myView.addSubview(player3View);
        }
        if(number_of_players >= 4){
        var player4View = GameView(frame: CGRectMake(screenCenter.x - w, screenCenter.y, w, h))
        player4View.backgroundColor = UIColorFromRGB(0xFD7400);
        player4View.tag = 4;
        myView.addSubview(player4View);
        }
    }
    
    
   override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        if let touch = touches.first as? UITouch {
            var touchCenter = touch.locationInView(myView)
            w = 100;
            h = 100;
            var player4View = GameView(frame: CGRectMake(touchCenter.x-w/2, touchCenter.y-h/2, w, h))
            //player4View.backgroundColor = UIColorFromRGB(0xFD7400);
            player4View.time = Int(arc4random_uniform(10));
            
            
            

            
            /*var label = UILabel(frame: CGRectMake(0, 0, 100, 100))
            label.textAlignment = NSTextAlignment.Center;
            label.textColor = UIColor.blackColor();
            var countToString = toString(player4View.time);
            label.text = countToString;
            label.font = UIFont (name: "Helvetica Neue", size: 30);
            player4View.addSubview(label);*/
            ++tagValue;
            
            player4View.lastLocation = touchCenter;
            player4View.userInteractionEnabled = true;
            player4View.tag = tagValue;
            
            NSLog("First Target: %d",player4View.time);
            
           
            
            if(tagValue == 1){
                
                NSLog("First Go %f",targetTime)
                if(player4View.time < 6){
                    NSLog("Setting Timer")
                    player4View.time = 6;
                }
                AvailTimeLabel?.text = "Count to the number \n above your finger/thumb"
            }
            
             NSLog("Target: %d",player4View.time);
           
            fingerView1 = player4View;
            var panRecognizer = UIPanGestureRecognizer(target:self.view, action:"detectPan");
            self.view.gestureRecognizers = [panRecognizer];
            myView.addSubview(player4View);
            
            
            targetTime = player4View.time;
            
            
            timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
        }
        super.touchesBegan(touches , withEvent:event)
        self.img_diag.alpha = 0.05;
        self.img_diag_red.alpha = 0.05;
    
        UIView.animateWithDuration(30, delay: 0.0, options: .Repeat | .CurveLinear, animations: {
            self.img_diag.frame = CGRect(x: 0, y: 0, width: self.img_diag.frame.width, height: self.img_diag.frame.height);
            self.img_diag_red.frame = CGRect(x: -2000, y: 0, width: self.img_diag_red.frame.width, height: self.img_diag_red.frame.height);
            },  completion: { finished in
            if(finished) {
                //tappedView.removeFromSuperview()
            }
        })
    
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
       // NSLog("MOVING");
       /* let touch =  touches.first as? UITouch;
        var pointHit:CGPoint = touch!.locationInView(self.view);
        let tappedView:UIView = self.view.hitTest(pointHit, withEvent: nil)!;
        
        if(tappedView.isKindOfClass(GameView)){
            tappedView.center = pointHit;
        }*/
        
        //NSLog("WHAT WHYNOT %lu",touches.count);
        for touch: AnyObject in touches {
            var pointHit:CGPoint = touch.locationInView(self.view);
            let tappedView:UIView = self.view.hitTest(pointHit, withEvent: nil)!;
            //if(tappedView.isKindOfClass(GameView)){
                tappedView.center = pointHit;
            
            //}
        }

    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        timer.invalidate();
        self.img_diag.alpha = 0.0;
        self.img_diag_red.alpha = 0.0;
        finalTime = abs(Float(targetTime) - userTime);
        AvilalbleTime -= finalTime;
        AvailTimeLabel?.text = toString(AvilalbleTime);
        if(AvilalbleTime < 0){
            AvailTimeLabel?.text = "Game Over, \n You did AWFUL"
        }
        NSLog("Final Time %f",finalTime);
        NSLog("Available Time %f",AvilalbleTime);
        
        
       // var touch = touches.first as! UITouch
       // var touchCenter = touch.locationInView(myView);
       // NSLog("My Tage %@", touch.view.tag);
        let touch =  touches.first as? UITouch;
        var pointHit:CGPoint = touch!.locationInView(self.view);
        let tappedView:UIView = self.view.hitTest(pointHit, withEvent: nil)!;
        
        if(tappedView.isKindOfClass(GameView)){
            NSLog("Remove from View %d",tappedView.tag);
            //do this after checking class to avoid removing sView Controller
            var tappedViewRef:GameView = tappedView as! GameView;
            let displayTimer = roundf(100 * userTime) / 100.0;
            tappedViewRef.label.text = toString(displayTimer);
            tappedViewRef.label.transform.ty = 75;
            tappedViewRef.label.textColor = UIColorFromRGB(0x505050);
            //let newFrameOfMyView:CGRect = CGRectMake(0.0, 50, 50, 50);
            NSLog("Time Remaining %f",AvilalbleTime)
            let percentageRemain =  1 - (AvilalbleTime/10);
            NSLog("Percent Remain%f",percentageRemain)
            let heightPosition = self.view.frame.height * CGFloat(percentageRemain);
            NSLog("Percent %f",heightPosition)
            let targetY = heightPosition;
            
            tappedViewRef.label_diff.text = "-" + toString(roundf(100 * finalTime) / 100.0);
           
            
            userTime = 0;
            UIView.animateWithDuration(0.5, delay: 0.3, options: .CurveEaseInOut, animations: {
                tappedView.center.x = self.AvailTimeLabel!.center.x;
                tappedView.center.y = self.AvailTimeLabel!.center.y;
                tappedView.alpha = 0.0;
                self.scoreBar.transform.ty = targetY;
                },  completion: { finished in
                    if(finished) {
                        tappedView.removeFromSuperview()
                    }
            })
        }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true;
    }
    
    func update(){
        userTime += 0.01;
        if(tagValue == 1){
            if(userTime > 3){
                 AvailTimeLabel?.text = "Let go when you have counted to the value"
            }
           
        }
    }
    
    func detectTap(){
        NSLog("TAPPEDY");
    }
    
    func detectPan(recognizer:UIPanGestureRecognizer) {
        NSLog("PANNING");
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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