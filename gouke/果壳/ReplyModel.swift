//
//  ReplyMdel.swift
//  果壳
//
//  Created by qianfeng on 2016/10/31.
//  Copyright © 2016年 陶杰. All rights reserved.
//

import UIKit
import SwiftyJSON
class ReplyModel: NSObject {
    var limit:Int?
    var now:String?
    var ok:Bool?
    var result:[retModel]?
    class func paraseData(data:NSData)->ReplyModel{
        let json=JSON(data:data)
        let model=ReplyModel()
        model.limit=json["limit"].int
        model.now=json["now"].string
        model.ok=json["ok"].bool
        var tmpresult=[retModel]()
        for (_,item) in json["result"]{
            let res=retModel.parase(item)
            tmpresult.append(res)
        }
       model.result=tmpresult
        return model
    }
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}
class retModel:NSObject{
    var content:String?
    var date_created:String?
    var likings_count:NSNumber?
    var author:authorModel?
    var html:String?
    var url:String?
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
    }
    
    class func parase(json:JSON)->retModel{
        let model=retModel()
        model.content=json["content"].string
        model.date_created=json["date_created"].string
        model.likings_count=json["likings_count"].number
        model.html=json["html"].string
        model.url=json["url"].string
        model.author=authorModel.parse(json["author"])
        return model
    }
}
class authorModel:NSObject{
    var followers_count:NSNumber?
    var nickname:String?
    var avatar:avatarModel?
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    class func parse(json:JSON)->authorModel{
    let model=authorModel()
        model.followers_count=json["followers_count"].number
        model.nickname=json["nickname"].string
        model.avatar=avatarModel.parse(json["avatar"])
        return model
    }
}
class avatarModel:NSObject{
    var large:String?
    var normal:String?
    var small:String?
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
    }
    class func parse(json:JSON)->avatarModel{
        let model=avatarModel()
        model.large=json["large"].string
        model.normal=json["normal"].string
        model.small=json["small"].string
        return model
    }
}




