//
//  ViewController.swift
//  果壳
//
//  Created by qianfeng on 2016/10/20.
//  Copyright © 2016年 陶杰. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var homeView:mainView!
    var sideView:SliderView!
    var hasShow:Bool=false
    var distance:CGFloat=0
    var beginCenterPoint:CGPoint!
    var launchVc:UIViewController!
    var story:UIStoryboard!
    var homeNavigationController:UINavigationController?
    var mainview:UIView?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        beginCenterPoint=view.center
        let app=UIApplication.sharedApplication().delegate as! AppDelegate
        homeNavigationController=app.nav
        homeView=homeNavigationController?.viewControllers.first as! mainView
        sideView=SliderView()
        mainview=UIView(frame:CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        mainview?.addSubview((homeView.navigationController?.view)!)
        mainview?.addSubview(homeView.view)
       
         self.view.addSubview(sideView.view)
         self.view.addSubview(mainview!)
        let pan=UIPanGestureRecognizer(target: self, action: #selector(panChange(_:)))
        mainview?.addGestureRecognizer(pan)
        homeView.leftBtnClickClosure={
            self.show()
        }
        
//        let sb=UIStoryboard.init(name: "SettingController", bundle:nil)
//        _=sb.instantiateViewControllerWithIdentifier("SettingController") as! SettingController
//        let nav=UINavigationController(rootViewController: setCtrl)
//        nav.navigationBar.backgroundColor=UIColor.redColor()
//        self.homeView.addChildViewController(nav)
//        self.homeView.view.addSubview(setCtrl.view)
        
         story=UIStoryboard.init(name: "launchViewController", bundle:nil)
         launchVc=story.instantiateViewControllerWithIdentifier("launchViewController") as! launchViewController
        
        let nav2=UINavigationController(rootViewController: launchVc)
        nav2.navigationBar.backgroundColor=UIColor.brownColor()
        
        sideView.changeClosure={
            [weak self](indexPath) in
            if indexPath.row==0{
               self!.hide()
            }else if indexPath.row==1{
                self!.presentViewController(nav2, animated: true, completion: nil)
            }else if indexPath.row==2{
                self!.presentViewController(nav2, animated: true, completion: nil)
            }else{
               
              
                
            }

        }
        
           }
    
    func show(){
        UIView.animateWithDuration(0.1) {
            [unowned self](a) in
            
            
            self.mainview?.center=CGPoint(x: self.view.center.x+screenWidth*2/3, y: (self.view.center.y))
            self.beginCenterPoint.x=self.view.center.x+screenWidth*2/3
            self.hasShow=true
            self.mainview?.subviews.last?.userInteractionEnabled=false
        }
        

    }
    func hide(){
        UIView.animateWithDuration(0.1) {
            [unowned self](a) in
       self.mainview?.center=CGPoint(x: self.view.center.x, y: (self.view.center.y))
         self.beginCenterPoint=self.mainview?.center
            self.distance=0
            self.hasShow=false
     self.mainview?.subviews.last?.userInteractionEnabled=true
        }
    }
    func panChange(pan:UIPanGestureRecognizer){
       
        let chgpoint=pan.translationInView(view)
        
        if !hasShow{
           
            if chgpoint.x<0{
               
            }else{
               pan.view?.center.x=beginCenterPoint.x+chgpoint.x
            }
           distance = (pan.view?.center.x)!-beginCenterPoint.x
            if pan.state == .Ended{
                
                
                if distance>screenWidth/3{
                    self.show()
                }
                if distance<screenWidth/3{
                    self.hide()
                }
            }
 
        }else if hasShow{
            if chgpoint.x<0{
               pan.view?.center.x=beginCenterPoint.x+chgpoint.x
            }else{
              
            }
            distance = (pan.view?.center.x)!-beginCenterPoint.x
            if pan.state == .Ended{
                
                
                if distance > -screenWidth/3{
                    self.show()
                }
                if distance < -screenWidth/3{
                    self.hide()
                }
            }

        }
        
       

//        if pan.view?.center.x>=screenWidth/2 {
//            
//       pan.view?.center.x=beginCenterPoint.x+chgpoint.x
//        }
        
        }
          override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

