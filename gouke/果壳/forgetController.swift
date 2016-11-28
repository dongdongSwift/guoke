//
//  forgetController.swift
//  果壳
//
//  Created by qianfeng on 2016/11/9.
//  Copyright © 2016年 陶杰. All rights reserved.
//

import UIKit

class forgetController: UIViewController,NavigationProtocol {
    var webView:UIWebView?
    override func viewDidLoad() {
        super.viewDidLoad()
//        let title=UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 40))
//        title.text="忘记密码"
//        title.textColor=UIColor.whiteColor()
//        title.textAlignment = .Center
//        navigationItem.titleView=title
        addTitle("忘记密码")
        addBarButton(imageName: "bar_back_icon", postion: .left, select: #selector(back))
        self.view.backgroundColor=UIColor.whiteColor()
webView=UIWebView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        let request=NSURLRequest(URL: NSURL(string: "http://account.guokr.com/email/forgot_password/")!)
        webView?.backgroundColor=UIColor.whiteColor()
        webView?.loadRequest(request)
        
        view.addSubview(webView!)
        // Do any additional setup after loading the view.
    }
    func back(){
        navigationController?.popViewControllerAnimated(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
