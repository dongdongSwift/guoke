 //
//  AppDelegate.swift
//  果壳
//
//  Created by qianfeng on 2016/10/20.
//  Copyright © 2016年 陶杰. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher
import MJRefresh
 
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var nav:UINavigationController?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        let vc3=mainView()
         nav=UINavigationController(rootViewController: vc3)
        
//        nav.navigationBar.backgroundColor=UIColor.brownColor()
    
        let vc=ViewController()
//        let vc2=SliderView()
//        vc3.view.addSubview(nav.view)
//        vc3.addChildViewController(SettingControllerTableViewController())
//        vc.addChildViewController(vc2)
//        
//      
//        
//        
//       
//       vc.view.addSubview(vc2.view)
//         vc.view.addSubview(.view)
        window?.rootViewController=vc
        
        UMSocialData.setAppKey("57b1797067e58e3aab002deb")
        UMSocialWechatHandler.setWXAppId("wxc003a644c3d076a0", appSecret: "cee5aae80cc72d21ea2fea334a794603", url: "跳转的网址")
//        UMSocialSinaSSOHandler.openNewSinaSSOWithAppKey("2671990398", secret: "729ace085d311a36e9534d935ed63a39", redirectURL: nil)
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

