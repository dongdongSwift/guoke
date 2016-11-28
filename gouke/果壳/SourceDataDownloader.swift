//
//  SourceDataDownloader.swift
//  果壳
//
//  Created by qianfeng on 2016/10/30.
//  Copyright © 2016年 张冬. All rights reserved.
//

import UIKit
import Alamofire
class SourceDataDownloader: NSObject {
    var  url:String?
    func download(data:allModel,group:String?=nil,tableview:UITableView,currentOffSet:Int, closure:(Void->Void)){
        if group != nil{
//            主页面地址
             url=String(format:groupUrl,group!,currentOffSet).stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLFragmentAllowedCharacterSet())
            

        }else{
//            详情页3个推荐的地址
             url=detailRecommendUrl
        }

        
            Alamofire.request(.GET, url!).responseJSON(completionHandler: { (response) in
                guard response.result.error == nil else{
                    return
                }
                if group != nil{
                tableview.mj_header.endRefreshing()
                tableview.mj_footer.endRefreshing()
                if currentOffSet==0{
                    data.result.removeAll()
                    
                }
                }
                data.result.removeAll()
                let json=response.result.value as! [String:AnyObject]
                data.now=json["now"] as? String
                let array=json["result"] as! [[String:AnyObject]]
                for item in array{
                    let model=resultModel()
                    model.setValuesForKeysWithDictionary(item as [String:AnyObject])
                    let sourceModel=sourceDataModel()
                    sourceModel.setValuesForKeysWithDictionary(item["source_data"] as! [String:AnyObject])
                    model.source_data=sourceModel as sourceDataModel
                    data.result.append(model)
                    
                }
//                print(dataAll[categoryArray[n]]!.result.count)
                
                closure()
            
        })
    

        }    
}