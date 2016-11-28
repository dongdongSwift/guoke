//
//  launchViewController.swift
//  果壳
//
//  Created by qianfeng on 2016/11/8.
//  Copyright © 2016年 陶杰. All rights reserved.
//

import UIKit

class launchViewController: UIViewController,NavigationProtocol {
    @IBAction func btnClick(btn: UIButton) {
        if btn.tag==300{
            print("微信登录")
        }else if btn.tag==301{
            print("微博登录")
        }else if btn.tag==302{
            print("QQ登录")
        }else if btn.tag==303{
            print("豆瓣登录")
        }else if btn.tag==304{
            print("登录")
        }else if btn.tag==305{
            print("查看用户协议")
        }else if btn.tag==306{
            print("刷新验证码")
        }else if btn.tag==307{
            navigationController?.pushViewController(forgetController(), animated: true)
        }
    }

    @IBAction func back(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBOutlet weak var accountTextField: UITextField!

    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var verificationCodeTextField: UITextField!
    
    @IBOutlet weak var verificationImage: UIImageView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTitle("登录")
        
      
    }
    func keyBoardDidReturn(){
        
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        accountTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        verificationCodeTextField.resignFirstResponder()
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
