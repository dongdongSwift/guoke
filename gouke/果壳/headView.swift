//
//  headView.swift
//  果壳
//
//  Created by qianfeng on 2016/11/5.
//  Copyright © 2016年 陶杰. All rights reserved.
//

import UIKit

class headView: UIView {

    @IBOutlet weak var icon: UIButton!

    @IBAction func touchAction(sender: AnyObject) {
        let story=UIStoryboard.init(name: "launchViewController", bundle:nil)
        
        let launchVc=story.instantiateViewControllerWithIdentifier("launchViewController")
        
        let nav2=UINavigationController(rootViewController: launchVc)
        nav2.navigationBar.backgroundColor=UIColor.brownColor()
      window?.rootViewController!.presentViewController(nav2, animated: true, completion: nil)
    }
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
     
      
    }

    

}
