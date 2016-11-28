//
//  keyWordsModel.swift
//  果壳
//
//  Created by qianfeng on 2016/11/7.
//  Copyright © 2016年 陶杰. All rights reserved.
//

import UIKit
import SwiftyJSON
class keyWordsModel: NSObject {
    var now:String?
    var ok:Bool?
    var result:[keywordsResultModel]?
    class func parseData(data:NSData)->keyWordsModel{
        let json=JSON(data: data)
        let model=keyWordsModel()
        model.now=json["now"].string
        model.ok=json["ok"].bool
        var array=[keywordsResultModel]()
        for (_,subjson) in json["result"]{
            let model=keywordsResultModel.prase(subjson)
            array.append(model)
        }
        model.result=array
        return model
    }
}
class keywordsResultModel:NSObject{
    var category:String?
    var interval:NSNumber?
    var is_greedy:Bool?
    var items:[itemModel]?
    var name:String?
    var number:NSNumber?
    var title:String?
    class func prase(json:JSON)->keywordsResultModel{
        let model=keywordsResultModel()
        model.category=json["category"].string
        model.interval=json["interval"].number
        model.is_greedy=json["is_greedy"].bool
        var array=[itemModel]()
        for (_,subjson) in json["items"]{
            let model=itemModel.prase(subjson)
            array.append(model)
        }
        model.items=array
        model.name=json["name"].string
        model.number=json["number"].number
        model.title=json["title"].string
        return model
    }
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}
class itemModel:NSObject{
    var ordinal:NSNumber?
    var text:String?
    class func prase(json:JSON)->itemModel{
        let model=itemModel()
        model.ordinal=json["ordinal"].number
        model.text=json["text"].string
        return model
    }
}






