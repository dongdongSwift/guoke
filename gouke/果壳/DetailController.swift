//
//  DetailController.swift
//  果壳
//
//  Created by qianfeng on 2016/10/27.
//  Copyright © 2016年 陶杰. All rights reserved.
//

import UIKit
import Alamofire
class DetailController: UIViewController {
    var scrollView:ScrollPage?
    var customNavBar:UIView?
    var progressBar:UIProgressView?
    var webData:NSMutableData?
    var webview:UIWebView?
    var webH:CGFloat?=screenHeight
    var len:Int?
    var replyData:[NSNumber:ReplyModel]=[:]
    var detailRecData=allModel()
    var tableArray:[UITableView]=[]

    var dataResult:[resultModel]?{
        
        willSet{
            initUI()
        }
        didSet{
            showData()
            for i in 0..<(dataResult?.count)!{
                let key=dataResult![i].id
                replyData[key!]=ReplyModel()
                loadData(i)
                
            }
            loadDetailRecomendData(0)
        }
    }
    override func viewWillAppear(animated: Bool) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
   view.backgroundColor=UIColor.whiteColor()

    }
    func initUI(){
        customNavBar=UIView(frame: CGRect(x: 0, y: 20, width: screenWidth, height: 44))
        customNavBar?.backgroundColor=UIColor.whiteColor()
                self.view.addSubview(customNavBar!)
        progressBar=UIProgressView(frame: CGRect(x: 0, y: 42, width:screenWidth , height: 2))
        progressBar?.progress=0
        customNavBar?.addSubview(progressBar!)
    let leftbtn=UIButton.createBtn(UIImage(named:"bar_dismiss_icon"))
    let rightbtn1=UIButton.createBtn(UIImage(named:"bar_share_icon"))
    let rightbtn2=UIButton.createBtn(UIImage(named:"bar_heart_empty_icon"))
    leftbtn.frame=CGRect(x: 5, y: 5, width: 32, height: 32)
    rightbtn1.frame=CGRect(x: screenWidth-37, y: 5, width: 32, height: 32)
   rightbtn2.frame=CGRect(x: screenWidth-70, y: 5, width: 32, height: 32)
        leftbtn.tag=101
        rightbtn1.tag=102
        rightbtn2.tag=103
        customNavBar?.addSubview(leftbtn)
        customNavBar?.addSubview(rightbtn1)
        customNavBar?.addSubview(rightbtn2)
        leftbtn.addTarget(self, action: #selector(btnClick(_:)), forControlEvents: .TouchUpInside)
    }
    func btnClick(btn:UIButton){
        if btn.tag==101{
           dismissViewControllerAnimated(true, completion: nil)
        }
        if btn.tag==102{
            
        }
        if btn.tag==103{
            
        }
    }
    func showData(){
        print("show")
       UIApplication.sharedApplication().statusBarStyle = .Default
        scrollView=ScrollPage(frame: CGRect(x: 0, y: 64, width: screenWidth, height: screenHeight-64), pageNum: (dataResult?.count)!)
        automaticallyAdjustsScrollViewInsets=false
        self.view.addSubview(scrollView!)
        tableArray=(scrollView?.tableArray)!
        scrollView!.tag=160
        scrollView!.delegate=self
        scrollView!.bounces=false
        scrollView!.showsVerticalScrollIndicator=false
        scrollView!.pagingEnabled=true
//         print("showdata")
        for i in 0..<dataResult!.count{
           
        
            tableArray[i].dataSource=self
            tableArray[i].delegate=self
            tableArray[i].tag=100+i
            tableArray[i].bounces=false
/**************加载webView（headView上）********/
//            tableArray[i].tableHeaderView=WebView(frame:  CGRect(x: 0, y: 64, width: screenWidth, height: webH!-64), link: dataResult![i].link_v2_sync_img!)
           tableArray[i].tableHeaderView=WebView(frame:  CGRect(x: 0, y: 64, width: screenWidth, height: screenHeight-64), link: dataResult![i].link_v2_sync_img!)
            
            tableArray[i].tableHeaderView!.tag=200+i
           
/***********解析热门回复数据***********/
//            loadData(i)

/*******************提前注册*************/
            tableArray[i].registerNib(UINib(nibName: "DetailCell1", bundle: nil), forCellReuseIdentifier: "DetailCell1")
            tableArray[i].registerNib(UINib(nibName: "customCell1", bundle: nil), forCellReuseIdentifier:"customCell1")
            tableArray[i].registerNib(UINib(nibName: "DetailCellHead1", bundle: nil), forCellReuseIdentifier:"DetailCellHead1")
            
            tableArray[i].registerNib(UINib(nibName: "DetailReplyCell2", bundle: nil), forCellReuseIdentifier:"DetailReplyCell2")
            tableArray[i].registerNib(UINib(nibName: "DetailRecommendCell", bundle: nil), forCellReuseIdentifier:"DetailRecommendCell")
            
        }
        
        
        
    }
    //MARK:loadData****************************/
    func loadData(tag:Int){
//        print("load")String(format:replyListUrl,String(key))
        //76108
        let key=dataResult![tag].id!
        
        let url=String(format:replyListUrl,String(key))
//        print(url)
        Alamofire.request(.GET, url).responseData {  (response) in
            
            guard response.result.error == nil else{
                print(Error)
                return
            }
            let json=response.result.value
            self.replyData[key]=ReplyModel.paraseData(json!)
            self.tableArray[tag].reloadData()
            
        }
    }
    
    func loadDetailRecomendData(tag:Int){
        if tableArray.count>tag{
        let downloader=SourceDataDownloader()
        downloader.download(detailRecData, tableview: tableArray[tag], currentOffSet: 0) { [weak self](a) in
            print("re")
            print(self?.detailRecData.result[0].title)
            self?.tableArray[tag].reloadData()
            //            print("\(self.data.result.count)=-=-")
            }}else{
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    
}
//MARK:UIscrollview 代理
extension DetailController:UIScrollViewDelegate{
func scrollViewWillBeginDragging(scrollView: UIScrollView){
    if scrollView.tag==160{
    let nextpage=(scrollView.contentOffset.x/screenWidth)+1
    print(nextpage)
        loadDetailRecomendData(Int(nextpage))
    }
    }
//    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
//        if scrollView.tag==160{
// let nextpage=(scrollView.contentOffset.x/screenWidth)+1
//        print(nextpage)
//            
//            loadDetailRecomendData(Int(nextpage))
//        }
//    }
}

extension DetailController:UIWebViewDelegate,NSURLConnectionDataDelegate{
    func webViewDidStartLoad(webView: UIWebView) {
        let contentOffset=Int((scrollView?.contentOffset.x)!/(scrollView?.frame.width)!)
        let url=NSURL(string: dataResult![contentOffset].link_v2_sync_img!)
        let data=NSData(contentsOfURL:url!)
         len=data?.length
    }
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        webData?.appendData(data)
//        progressBar?.progress=Float((webData?.length)!/len!)
    }
    func webViewDidFinishLoad(webView: UIWebView) {
         progressBar?.progress=Float((webData?.length)!/len!)
    }
}
//MARK:UITableView 代理
extension DetailController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section==0{
            return 1
        }else if section==1{
           
    let key=dataResult![tableView.tag-100].id!
            
            guard replyData[key]?.result?.count != nil else{
                
                return 3
            }
            print("\(replyData[key]?.result!.count)个")
            let cnt=replyData[key]?.result!.count
            if cnt>5{
                return 7
            }else{
                print("*****")
                return cnt!+2
            }
            
            
            
            
            
                   }else if section==2{
            return 4
        }else{
            return 0
        }
        
    }
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let key=dataResult![tableView.tag-100].id!
        if indexPath.section==0{
           
            return 120
        }
    else
            if indexPath.section==1{
            guard replyData[key]?.result?.count != nil  else{
                return 35
            }
            let cnt=replyData[key]?.result!.count
            if cnt==0{
                if indexPath.row==0{
                    return 35
                }else{
                    return 60
                }
            }else if cnt>0{
            if indexPath.row==0||indexPath.row==cnt!+1{
                return 35
            }else{
                return  150
                }
            }
            
            }
        else if indexPath.section==2 {
            if indexPath.row==0{
                return 35
            }else{
                return 90
            }
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section==0{

            let cell=DetailCell1.createDeatilCell1(tableView, atIndexPath: indexPath, sourceData: dataResult![tableView.tag-100].source_data)
            return cell

        }else if indexPath.section==1{
          let key=dataResult![tableView.tag-100].id!
            var cnt=0
            guard replyData[key] != nil else{
              return UITableViewCell()
            }

            if replyData[key]!.result!.count==0{
                if indexPath.row==0{
                    let cell=tableView.dequeueReusableCellWithIdentifier("DetailCellHead1") as! DetailCellHead1
                    
                    return cell
                }else {
                    let cell=tableView.dequeueReusableCellWithIdentifier("DetailCellHead1") as! DetailCellHead1
                    cell.content.text="还不有人评论！快来抢沙发！"
                    cell.content.textAlignment = .Center
                    return cell
                }
  
            }
        else if replyData[key]!.result!.count>0&&replyData[key]?.result?.count<=5{
                cnt=replyData[key]!.result!.count
               if indexPath.row==0{
                let cell=tableView.dequeueReusableCellWithIdentifier("DetailCellHead1") as! DetailCellHead1
                
                return cell
            }
            if indexPath.row==cnt+1{
                
                let cell=tableView.dequeueReusableCellWithIdentifier("DetailCellHead1") as! DetailCellHead1
                
                cell.content.text="查看全部评论"
                cell.content.textAlignment = .Center
                
                return cell
            }else {
                
                let cell=DetailReplyCell2.createDetailReplyCell2(tableView, atIndexPath: indexPath, data: (replyData[key]?.result)!)
               
                return cell
            }
            
            }
        else if replyData[key]?.result?.count>5{
            if indexPath.row==0{
                let cell=tableView.dequeueReusableCellWithIdentifier("DetailCellHead1") as! DetailCellHead1
                
                return cell
            }else if indexPath.row==6{
                let cell=tableView.dequeueReusableCellWithIdentifier("DetailCellHead1") as! DetailCellHead1
                return cell
            }else{
          }
        }
            let cell=DetailReplyCell2.createDetailReplyCell2(tableView, atIndexPath: indexPath, data: (replyData[key]?.result)!)
            return cell
        }
        else if indexPath.section==2{
            if indexPath.row==0{
                let cell=tableView.dequeueReusableCellWithIdentifier("DetailCellHead1") as! DetailCellHead1
                cell.content.text="大家都在看"
                cell.content.textAlignment = .Left
                return cell
            }else{
                if detailRecData.result.count>0{
                let cell=DetailRecommendCell.createDetailRecommendCell(tableView, atIndexPath: indexPath, data: detailRecData)
                    return cell}
                else {
                    
                }
            }
            
        }
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section==0||indexPath.section==2{
        
            if indexPath.section==0{
        let vc=sourceGroupViewController()
        vc.group=dataResult![tableView.tag-100].source_data!
        presentViewController(vc, animated: true, completion: nil)
    vc.tableview?.mj_header.beginRefreshingWithCompletionBlock({
                    vc.loadData()
                })

            }else{
                let vc=DetailController()
                vc.dataResult=detailRecData.result
                 presentViewController(vc, animated: true, completion: nil)
            }
                }
tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
 }





