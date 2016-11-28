//
//  allModel.swift
//  果壳
//
//  Created by 张冬 on 16/10/25.
//  Copyright © 2016年 陶杰. All rights reserved.
//

import UIKit

class allModel: NSObject {
    var now:String?
    var result:[resultModel]=[]
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}
class resultModel:NSObject{
    var author:String?
    var category:String?
    var current_user_has_collected:Bool?
    var current_user_has_liked:Bool?
    var date_created:NSNumber?
    var date_picked:NSNumber?
    var headline_img:String?
    var headline_img_tb:String?
    var likings_count:NSNumber?
    var link:String?
    var replies_count:NSNumber?
    var source:String?
    var images:[String]?
    var source_data:sourceDataModel?
    var source_name:String?
    var style:String?
    var summary:String?
    var title:String?
    var video_url:String?
    var id:NSNumber?
    var link_v2_sync_img:String?
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
}
class sourceDataModel:NSObject{
    var id:Int?
    var image:String?
    var key:String?
    var summary:String?
    var title:String?
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}













