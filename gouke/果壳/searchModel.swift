//
//  searchModel.swift
//  果壳
//
//  Created by qianfeng on 2016/11/15.
//  Copyright © 2016年 陶杰. All rights reserved.
//

import UIKit
import SwiftyJSON
class searchModel: NSObject {
    var now:String?
    var ok:Bool?
    var result:[searchResultModel]?
    var total:NSNumber?
    class func praserData(data:NSData)->searchModel{
        let json=JSON(data: data)
        let model=searchModel()
        model.now=json["now"].string
        model.ok=json["ok"].bool
        model.total=json["total"].number
        var array=[searchResultModel]()
        for (_,subjson) in json["result"]{
            let sub=searchResultModel.prase(subjson)
           array.append(sub)
        }
        model.result=array
        return model
    }
}
class searchResultModel:NSObject{
    var headline_img:String?
    var id:NSNumber?
    var owner_name:String?
    var style:String?
    var summary:String?
    var title:String?
    class func prase(json:JSON)->searchResultModel{
        let model=searchResultModel()
        model.headline_img=json["headline_img"].string
        model.id=json["id"].number
        model.owner_name=json["owner_name"].string
        model.style=json["style"].string
        model.summary=json["summary"].string
        model.title=json["title"].string
        return model
    }
}
