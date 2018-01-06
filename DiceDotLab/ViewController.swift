//
//  ViewController.swift
//  DiceDotLab
//
//  Created by Lucas de Brito on 04/12/2017.
//  Copyright © 2017 Lucas de Brito. All rights reserved.
//

import UIKit
import AudioToolbox


class ViewController: UIViewController {
    
    var v1: UIView!
    var v2: UIView!
    var v3: UIView!
    var v4: UIView!
    var v5: UIView!
    var v6: UIView!
    var v7: UIView!
    var visible = true
    var big = true
    
    var c1: CGPoint!
    var c2: CGPoint!
    var c3: CGPoint!
    var c4: CGPoint!
    var c5: CGPoint!
    var c6: CGPoint!
    var c7: CGPoint!
    
    var previousState = 1
    var currentState = 1
    var ancientState = 0
    var hit = 0
    var hiHit = 0
    var randomNumber: UInt32!
    var pintinho = false
    var colorState = 3
    
    
    @IBOutlet weak var pintinhoView: UIImageView!
   
    @IBOutlet weak var placar: UILabel!
    @IBOutlet weak var high: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.swiped(gesture:)))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.swiped(gesture:)))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.swiped(gesture:)))
        swipeUp.direction = UISwipeGestureRecognizerDirection.up
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.swiped(gesture:)))
        swipeDown.direction = UISwipeGestureRecognizerDirection.down
        
        self.view.addGestureRecognizer(swipeRight)
        self.view.addGestureRecognizer(swipeLeft)
        self.view.addGestureRecognizer(swipeUp)
        self.view.addGestureRecognizer(swipeDown)
        
        
        pintinhoView.transform = pintinhoView.transform.rotated(by: CGFloat(-1*Double.pi/4))
        pintinhoView.center.x = self.view.bounds.width + self.view.bounds.width/12
        pintinhoView.center.y = self.view.bounds.height + self.view.bounds.height/12
        
        
        v1 = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width/8, height: self.view.frame.width/8))
        v1.center.x = self.view.frame.width/4
        v1.center.y = 3*self.view.frame.height/8
        c1 = v1.center
        v1.layer.cornerRadius = self.view.frame.width/16
        v1.backgroundColor = UIColor.black
        self.view.addSubview(v1)
        v1.alpha = 0
        
        
        v2 = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width/8, height: self.view.frame.width/8))
        v2.center.x = 3*self.view.frame.width/4
        v2.center.y = 3*self.view.frame.height/8
        c2 = v2.center
        v2.layer.cornerRadius = self.view.frame.width/16
        v2.backgroundColor = UIColor.black
        self.view.addSubview(v2)
        v2.alpha = 0
        
        
        v3 = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width/8, height: self.view.frame.width/8))
        v3.center.x = self.view.frame.width/4
        v3.center.y = self.view.frame.height/2
        c3 = v3.center
        v3.layer.cornerRadius = self.view.frame.width/16
        v3.backgroundColor = UIColor.black
        self.view.addSubview(v3)
        v3.alpha = 0
        
        v4 = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width/8, height: self.view.frame.width/8))
        v4.center.x = self.view.frame.width/2
        v4.center.y = self.view.frame.height/2
        c4 = v4.center
        v4.layer.cornerRadius = self.view.frame.width/16
        v4.backgroundColor = UIColor.black
        self.view.addSubview(v4)
        
        v5 = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width/8, height: self.view.frame.width/8))
        v5.center.x = 3*self.view.frame.width/4
        v5.center.y = self.view.frame.height/2
        c5 = v5.center
        v5.layer.cornerRadius = self.view.frame.width/16
        v5.backgroundColor = UIColor.black
        self.view.addSubview(v5)
        v5.alpha = 0
        
        v6 = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width/8, height: self.view.frame.width/8))
        v6.center.x = self.view.frame.width/4
        v6.center.y = 5*self.view.frame.height/8
        c6 = v6.center
        v6.layer.cornerRadius = self.view.frame.width/16
        v6.backgroundColor = UIColor.black
        self.view.addSubview(v6)
        v6.alpha = 0
        
        v7 = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width/8, height: self.view.frame.width/8))
        v7.center.x = 3*self.view.frame.width/4
        v7.center.y = 5*self.view.frame.height/8
        c7 = v7.center
        v7.layer.cornerRadius = self.view.frame.width/16
        v7.backgroundColor = UIColor.black
        self.view.addSubview(v7)
        v7.alpha = 0
        
        placar.text = "0x0"
        
        let hiHitAUX = UserDefaults.standard.object(forKey: "hiHit")
        let hiHitValueAUX = UserDefaults.standard.object(forKey: "hiHitValue")
        
        if let x = hiHitAUX as? Int{
            
            hiHit = x
            
        }
        
        if let y = hiHitValueAUX as? Int{
            
          ancientState = y
            
        }
        
        let colorREMINDER = UserDefaults.standard.object(forKey: "colorState")
        
        if let z = colorREMINDER as? Int{
            
            colorState = z
            
        }
        
        if colorState == 1 {
            
            self.view.backgroundColor = UIColor.yellow
            self.v1.backgroundColor = UIColor.black
            self.v2.backgroundColor = UIColor.black
            self.v3.backgroundColor = UIColor.black
            self.v4.backgroundColor = UIColor.black
            self.v5.backgroundColor = UIColor.black
            self.v6.backgroundColor = UIColor.black
            self.v7.backgroundColor = UIColor.black
            self.placar.textColor = UIColor.black
            self.high.textColor = UIColor.black
            
        }
        
        if colorState == 2 {
            
            self.view.backgroundColor = UIColor.black
            self.v1.backgroundColor = UIColor.red
            self.v2.backgroundColor = UIColor.red
            self.v3.backgroundColor = UIColor.red
            self.v4.backgroundColor = UIColor.red
            self.v5.backgroundColor = UIColor.red
            self.v6.backgroundColor = UIColor.red
            self.v7.backgroundColor = UIColor.red
            self.placar.textColor = UIColor.red
            self.high.textColor = UIColor.red
            
        }
        
        if colorState == 3 {
            
            self.view.backgroundColor = UIColor.white
            self.v1.backgroundColor = UIColor.black
            self.v2.backgroundColor = UIColor.black
            self.v3.backgroundColor = UIColor.black
            self.v4.backgroundColor = UIColor.black
            self.v5.backgroundColor = UIColor.black
            self.v6.backgroundColor = UIColor.black
            self.v7.backgroundColor = UIColor.black
            self.placar.textColor = UIColor.black
            self.high.textColor = UIColor.black
            
        }
        
        if colorState == 4 {
            
            self.view.backgroundColor = UIColor.green
            self.v1.backgroundColor = UIColor.black
            self.v2.backgroundColor = UIColor.black
            self.v3.backgroundColor = UIColor.black
            self.v4.backgroundColor = UIColor.black
            self.v5.backgroundColor = UIColor.black
            self.v6.backgroundColor = UIColor.black
            self.v7.backgroundColor = UIColor.black
            self.placar.textColor = UIColor.black
            self.high.textColor = UIColor.black
            
        }
        
        
        
        
        high.text = String(hiHit) + "x" + String(ancientState)
        
        //print(currentState)
        //print(hiHit)
        
    }
    
    
    @objc func swiped(gesture: UISwipeGestureRecognizer){
        if gesture.direction == UISwipeGestureRecognizerDirection.right{
            self.view.backgroundColor = UIColor.yellow
            self.v1.backgroundColor = UIColor.black
            self.v2.backgroundColor = UIColor.black
            self.v3.backgroundColor = UIColor.black
            self.v4.backgroundColor = UIColor.black
            self.v5.backgroundColor = UIColor.black
            self.v6.backgroundColor = UIColor.black
            self.v7.backgroundColor = UIColor.black
            self.placar.textColor = UIColor.black
            self.high.textColor = UIColor.black
            self.colorState = 1
            UserDefaults.standard.set(colorState, forKey: "colorState")
        }
        if gesture.direction == UISwipeGestureRecognizerDirection.left{
            self.view.backgroundColor = UIColor.black
            self.v1.backgroundColor = UIColor.red
            self.v2.backgroundColor = UIColor.red
            self.v3.backgroundColor = UIColor.red
            self.v4.backgroundColor = UIColor.red
            self.v5.backgroundColor = UIColor.red
            self.v6.backgroundColor = UIColor.red
            self.v7.backgroundColor = UIColor.red
            self.placar.textColor = UIColor.red
            self.high.textColor = UIColor.red
            self.colorState = 2
            UserDefaults.standard.set(colorState, forKey: "colorState")
        }
        if gesture.direction == UISwipeGestureRecognizerDirection.down{
            
            self.view.backgroundColor = UIColor.white
            self.v1.backgroundColor = UIColor.black
            self.v2.backgroundColor = UIColor.black
            self.v3.backgroundColor = UIColor.black
            self.v4.backgroundColor = UIColor.black
            self.v5.backgroundColor = UIColor.black
            self.v6.backgroundColor = UIColor.black
            self.v7.backgroundColor = UIColor.black
            self.placar.textColor = UIColor.black
            self.high.textColor = UIColor.black
            self.colorState = 3
            UserDefaults.standard.set(colorState, forKey: "colorState")
        }
        if gesture.direction == UISwipeGestureRecognizerDirection.up{
            
            self.view.backgroundColor = UIColor.green
            self.v1.backgroundColor = UIColor.black
            self.v2.backgroundColor = UIColor.black
            self.v3.backgroundColor = UIColor.black
            self.v4.backgroundColor = UIColor.black
            self.v5.backgroundColor = UIColor.black
            self.v6.backgroundColor = UIColor.black
            self.v7.backgroundColor = UIColor.black
            self.placar.textColor = UIColor.black
            self.high.textColor = UIColor.black
            self.colorState = 4
            UserDefaults.standard.set(colorState, forKey: "colorState")
        }
        
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if event?.subtype == UIEventSubtype.motionShake{
            
            self.randomNumber = arc4random_uniform(6) + 1
            
           // print("Numero sorteado " + String(randomNumber))
            
            while(currentState != randomNumber){
                
                if pintinho {
                    UIView.animate(withDuration: 0.2) {
                        self.pintinhoView.center.x = self.view.bounds.width + self.view.bounds.width/12
                        self.pintinhoView.center.y = self.view.bounds.height + self.view.bounds.height/12
                    }
                    pintinho = false
                }
                
                if self.currentState == 1 {
                    
                    v1.center = c4
                    v7.center = c4
                    v1.alpha = 1
                    v7.alpha = 1
                    v4.alpha = 0
                    
                    UIView.animate(withDuration: 0.2) {
                        self.v1.center = self.c1
                        self.v7.center = self.c7
                    }
                }
                
                if self.currentState == 2 {
                    
                    v4.center = c1
                    v4.alpha = 1
                    
                    UIView.animate(withDuration: 0.2) {
                        
                        self.v4.center = self.c4
                        
                    }
                }
                
                if self.currentState == 3 {
                    
                    v2.center = c4
                    v6.center = c4
                    v2.alpha = 1
                    v6.alpha = 1
                    v4.alpha = 0
                    
                    UIView.animate(withDuration: 0.2) {
                        
                        self.v2.center = self.c2
                        self.v6.center = self.c6
                        
                    }
                }
                
                if self.currentState == 4 {
                    
                    v4.center = c2
                    v4.alpha = 1
                    
                    UIView.animate(withDuration: 0.2) {
                        
                        self.v4.center = self.c4
                        
                    }
                }
                
                if self.currentState == 5 {
                    
                    v3.center = c4
                    v5.center = c4
                    v3.alpha = 1
                    v5.alpha = 1
                    v4.alpha = 0
                    
                    UIView.animate(withDuration: 0.2) {
                        
                        self.v3.center = self.c3
                        self.v5.center = self.c5
                        
                    }
                }
                
                if self.currentState == 6 {
                    
                    UIView.animate(withDuration: 0.5) {
                        
                        self.v1.center = self.c4
                        self.v2.center = self.c4
                        self.v3.center = self.c4
                        self.v5.center = self.c4
                        self.v6.center = self.c4
                        self.v7.center = self.c4
                        
                    }
                    
                    self.v1.alpha = 0
                    self.v2.alpha = 0
                    self.v3.alpha = 0
                    self.v4.alpha = 1
                    self.v5.alpha = 0
                    self.v6.alpha = 0
                    self.v7.alpha = 0
                    
                    let aux = arc4random_uniform(50) + 1
                    
                    if aux == 7 {
                        UIView.animate(withDuration: 0.2, delay: 0, options: [],
                                       animations: {
                                        self.pintinhoView.center.x = self.view.bounds.width - self.view.bounds.width/12
                                        self.pintinhoView.center.y = self.view.bounds.height - self.view.bounds.height/12
                                        
                        },
                                       completion: nil
                        )
                        
                        
                        pintinho = true
                    }
                    
                }
                
                if currentState == 6 {
                    currentState = 1
                    
                }else{
                    currentState+=1
                }
                
            }
            
            if(currentState == previousState){
                hit+=1
                if (hit > hiHit) || ((hit == hiHit)&&(currentState>ancientState)){
                    hiHit = hit
                    ancientState = currentState
                    high.text = String(hiHit) + "x" + String(currentState)
                    UserDefaults.standard.set(hiHit, forKey: "hiHit")
                    UserDefaults.standard.set(currentState, forKey: "hiHitValue")
                }
            }else{
                hit = 1
                previousState = currentState
            }
            
            
            placar.text = String(hit) + "x" + String(currentState)
           // print("Estado atual " + String(currentState))
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}

