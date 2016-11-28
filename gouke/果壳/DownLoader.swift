//
//  DownLoader.swift
//  果壳
//
//  Created by qianfeng on 2016/10/25.
//  Copyright © 2016年 张冬. All rights reserved.
//

import UIKit
import Alamofire
class DownLoader: NSObject {
    func download(currentPage n:Int,dataAll:[String:allModel],categoryArray:[String],tableArray:[UITableView],currentOffSetArray:[Int], closure:(Void->Void)){
        
        if n==0 {
        Alamofire.request(.GET, String(format:allUrl,currentOffSetArray[n])).responseJSON { (response) in
            guard response.result.error == nil else{
                return
            }
            tableArray[n].mj_header.endRefreshing()
            tableArray[n].mj_footer.endRefreshing()
            if currentOffSetArray[n]==0{
                dataAll[categoryArray[n]]?.result.removeAll()
                
            }
            let json=response.result.value as! [String:AnyObject]
            dataAll[categoryArray[n]]!.now=json["now"] as? String
            let array=json["result"] as! [[String:AnyObject]]
            for item in array{
                let model=resultModel()
                model.setValuesForKeysWithDictionary(item as [String:AnyObject])
                let sourceModel=sourceDataModel()
                sourceModel.setValuesForKeysWithDictionary(item["source_data"] as! [String:AnyObject])
                model.source_data=sourceModel as sourceDataModel
                dataAll[categoryArray[n]]!.result.append(model)
                
            }
           
            
            closure()
            
        }

            
            
           
        }else{
        Alamofire.request(.GET, String(format: Url,currentOffSetArray[n],categoryArray[n])).responseJSON { (response) in
            guard response.result.error == nil else{
                return
            }
            
            tableArray[n].mj_header.endRefreshing()
            tableArray[n].mj_footer.endRefreshing()
            if currentOffSetArray[n]==0{
                dataAll[categoryArray[n]]?.result.removeAll()
            }

            let json=response.result.value as! [String:AnyObject]
            dataAll[categoryArray[n]]!.now=json["now"] as? String
            let array=json["result"] as! [[String:AnyObject]]
            for item in array{
                let model=resultModel()
                model.setValuesForKeysWithDictionary(item as [String:AnyObject])
                let sourceModel=sourceDataModel()
                sourceModel.setValuesForKeysWithDictionary(item["source_data"] as! [String:AnyObject])
                model.source_data=sourceModel as sourceDataModel
                dataAll[categoryArray[n]]!.result.append(model)
            }
            closure() 
        }
       
    }
    
    }}