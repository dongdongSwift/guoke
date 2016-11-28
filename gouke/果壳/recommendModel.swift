//
//  recommendModel.swift
//  果壳
//
//  Created by qianfeng on 2016/10/24.
//  Copyright © 2016年 陶杰. All rights reserved.
//

import UIKit

class recommendModel: NSObject {
    var now:String?
    var ok:Bool?
    var result=[recommendResultModel]()
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
}
class recommendResultModel:NSObject{
    var ordinal:Int?
    var picture:String?
    var custom_title:String?
    var article_id:Int?
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
}








