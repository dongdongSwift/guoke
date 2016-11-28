//
//  SearchList.swift
//  果壳
//
//  Created by qianfeng on 2016/11/15.
//  Copyright © 2016年 陶杰. All rights reserved.
//

import UIKit
import Alamofire
import MJRefresh
class SearchList: UIView {
var tbView:UITableView?
var curoffset=0
var timer:NSTimer?
var searchUrl:String?
    var detailData=[String:allModel]()
var data:searchModel?
    {
        didSet{
            
          configUI()
            
        }
    }
    
    init(frame:CGRect,url:String?) {
        super.init(frame: frame)
        
        searchUrl=url
        
        loadData()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func loadData(){
  
       let url=String(format:searchUrl!,curoffset).stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLFragmentAllowedCharacterSet())
        Alamofire.request(.GET, url!).responseData{ [weak self](response) in
            guard response.result.error == nil else{
                return
            }
           self!.tbView?.mj_footer.endRefreshing()
            if self!.data==nil{
                self!.data=searchModel.praserData(response.result.value!)
                
                
            }else{
        let tmpdata=searchModel.praserData(response.result.value!).result
                self?.data?.result! += tmpdata!
              
            }
          
            for i in 0..<self!.data!.result!.count{
                self!.loadDetailData(String(self!.data!.result![i].id!))
            }
            
        }

    }
    
    func configUI(){
        
        self.backgroundColor=UIColor.whiteColor()
        tbView=UITableView(frame: self.bounds, style: .Plain)
        
        tbView?.delegate=self
        tbView?.dataSource=self
        
        self.addSubview(tbView!)
        tbView?.registerNib(UINib(nibName: "SearchListCell", bundle: nil), forCellReuseIdentifier: "SearchListCell")
        tbView?.registerNib(UINib(nibName: "SearchListCell2", bundle: nil), forCellReuseIdentifier: "SearchListCell2")
        tbView?.mj_footer=MJRefreshAutoNormalFooter(refreshingBlock: { 
            self.curoffset+=1
            self.loadData()
//            print("tbv")
            self.tbView?.reloadData()
        })
    }
    func loadDetailData(index:String){
        Alamofire.request(.GET, String(format: searchListDetailUrl,index)).responseJSON { (response) in
//            print(String(format: searchListDetailUrl,index))
            guard response.result.error == nil else{
                return
            }
            self.detailData[index]=allModel()
            
            let json=response.result.value as! [String:AnyObject]
            self.detailData[index]!.now=json["now"] as? String
//            print(json["result"])
            let array=json["result"] as! [[String:AnyObject]]
            for item in array{
                let model=resultModel()
                model.setValuesForKeysWithDictionary(item as [String:AnyObject])
                let sourceModel=sourceDataModel()
                sourceModel.setValuesForKeysWithDictionary(item["source_data"] as! [String:AnyObject])
                model.source_data=sourceModel as sourceDataModel
                self.detailData[index]!.result.append(model)
            }
//            print(self.detailData[index]?.result.count)
        }
 
    }

    
    
    
    
}
extension SearchList:UITableViewDelegate,UITableViewDataSource{
   func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard data?.result?.count>0 else{
        return 0
    }
        return  (data?.result?.count)!
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if data != nil{
            
            if (data!.result![indexPath.row].headline_img!.containsString("Jo1X") ){
                let cell=SearchListCell2.createSearchListCell2(tableView, atIndexPath: indexPath, data: (data?.result)!)
                return cell
            }else{
            let cell=SearchListCell.createSearchListCell(tableView, atIndexPath: indexPath, data: (data?.result)!)
            return cell
            }
        }else{
       
    
            return UITableViewCell()
        }
        
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

            jump(indexPath.row)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)

}
    func jump(index:Int){

        print(String(self.data!.result![index].id!))
        if detailData[String(self.data!.result![index].id!)]?.result.count==nil{
            
        }else{
         let vc=DetailController()
//        print(detailData[String(self.data?.result![index].id)]?.result.count)
        vc.dataResult=detailData[String(self.data!.result![index].id!)]!.result
        
        self.window?.rootViewController!.presentViewController(vc, animated: true, completion: nil)
        }
    }
}





