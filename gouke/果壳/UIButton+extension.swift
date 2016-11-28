//
//  UIButton+extension.swift
//  果壳
//
//  Created by qianfeng on 2016/10/29.
//  Copyright © 2016年 张冬. All rights reserved.
//

import UIKit


extension UIButton{
    class func createBtn(image:UIImage?=nil,bgImage:UIImage?=nil)->UIButton{
        let btn=UIButton()
        btn.setImage(image, forState: .Normal)
        
//        btn.setImage(image, forState: <#T##UIControlState#>)
        return btn
    }
}