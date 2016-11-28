//
//  mainView.swift
//  果壳
//
//  Created by qianfeng on 2016/10/21.
//  Copyright © 2016年 陶杰. All rights reserved.
//

import UIKit
import Alamofire
import MJRefresh
class mainView: UIViewController,NavigationProtocol,UMSocialUIDelegate {
    
    var center:CGPoint!
    var leftBtnClickClosure:(()->())?
    var currentPage:CGFloat=0
    var edgepan:UIScreenEdgePanGestureRecognizer?
    var pan:UIPanGestureRecognizer?
    var tableArray:[UITableView]=[]
    var newsList:ScrollPage?
    var titlels:titlelist?
    var currentOffSetArray:[Int]=[0,0,0,0,0,0,0,0]
    let categoryArray=["all","science","life","health","learning","humanities","nature","entertainment"]
    var dataAll:[String:allModel]=["all":allModel(),"science":allModel(),"life":allModel(),"health":allModel(),"learning":allModel(),"humanities":allModel(),"nature":allModel(),"entertainment":allModel()]
    let titlenames=["全部","科技","生活","健康","学习","人文","自然","娱乐"]
    override func viewDidLoad() {
        super.viewDidLoad()
 
        view.backgroundColor=UIColor.whiteColor()

        

        let titlels=titlelist(frame: CGRect(x: 0, y: 64, width: screenWidth, height:40), titlies: titlenames)
        
        self.view.addSubview(titlels)
        
        initTitleList()
        initNewsList()
//        addengePan(false)
        loadData(currentPage: 0)
       
    }
    //MARK:init TitleList
    func initTitleList(){
        print("tlist")
        let titlenames=["全部","科技","生活","健康","学习","人文","自然","娱乐"]
        titlels=titlelist(frame: CGRect(x: 0, y: 64, width: screenWidth, height:40), titlies: titlenames)
        
        self.view.addSubview(titlels!)
        self.view.addSubview((navigationController?.navigationBar)!)
//        let image=UIImage()
//        self.navigationController?.navigationBar.setBackgroundImage(image, forBarMetrics: .Default)
        self.navigationController?.navigationBar.barTintColor=UIColor.brownColor()
        
   
       
        center=self.view.center
        addTitle("果壳精选")
        addBarButton( imageName: "bar_back_icon", postion: .left, select: #selector(leftBtnClick))
        addBarButton(imageName: "search_ic", postion: .right, select: #selector(rightBtnClick))
       
    }
    func leftBtnClick(){
        leftBtnClickClosure!()
    }
    func rightBtnClick(){
    let vc=searchViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    /*********************数据加载*******************************/
    func initData(){
        
    }
    
    func loadData(currentPage n:Int){
        
        let downloader=DownLoader()
        downloader.download(currentPage: n, dataAll: dataAll, categoryArray: categoryArray,tableArray:tableArray,currentOffSetArray:currentOffSetArray,closure: {
            
            self.tableArray[n].reloadData()
            
        })

}
/***********************页面初始化*******************************/
    func initNewsList(){
        
        automaticallyAdjustsScrollViewInsets = false
        
//        MARK:create scrollowview *************************/
        
        newsList=ScrollPage(frame: CGRect(x: 0, y:104, width: screenWidth, height: screenHeight-104), pageNum: titlenames.count)
        self.tableArray=newsList!.tableArray
        newsList!.tag=200
        newsList!.delegate=self

        let pageWidth=newsList!.frame.width
//        let pageHeight=newsList!.frame.height
        newsList!.bounces=false
        newsList!.showsVerticalScrollIndicator=false
        newsList!.pagingEnabled=true
        self.view.addSubview(newsList!)
      
//MARK:config tableview****************************/
        tableArray[0].tableHeaderView=TJScrollView(frame: CGRect(x: 0, y: 0, width: pageWidth, height: pageWidth/2))
       
        for i in 0..<titlenames.count{
            tableArray[i].dataSource=self
            tableArray[i].delegate=self
            tableArray[i].tag=100+i
            tableArray[i].registerNib(UINib(nibName: "Customcell", bundle: nil), forCellReuseIdentifier: "customCell")
            tableArray[i].registerNib(UINib(nibName: "customCell1", bundle: nil), forCellReuseIdentifier:"customCell1")
            tableArray[i].registerNib(UINib(nibName: "CustomCell2", bundle: nil), forCellReuseIdentifier: "CustomCell2")
            /***********************加刷新***********************/

            tableArray[i].mj_header=MJRefreshNormalHeader(refreshingBlock: {
                self.currentOffSetArray[i]=0
                self.loadData(currentPage: i)
                self.tableArray[i].reloadData()
            })
            tableArray[i].mj_footer=MJRefreshAutoNormalFooter(refreshingBlock: {
                self.currentOffSetArray[i]+=20
                self.loadData(currentPage: i)
                self.tableArray[i].reloadData()
            })
        }
         /***********************加刷新***********************/
            
        

        
     /**************titlels的闭包控制换页*********************/
        titlels?.pageChangeClosure={
            [unowned self](labeltag) in
            self.currentPage=CGFloat(labeltag)
            self.newsList!.setContentOffset(CGPoint(x: pageWidth*self.currentPage, y: 0), animated: false)
            self.tableArray[labeltag].mj_header.beginRefreshingWithCompletionBlock({
                [weak self] (a) in
                self!.loadData(currentPage: labeltag)
               
                })
        }
    }
    
    /**************titlels的闭包控制换页*********************/
    /*************手势的添加********************************/
//    func btnClick(){
//       show()
//    }
//    
//    func addengePan(haveshow:Bool){
//        if haveshow{
//            pan=UIPanGestureRecognizer(target: self, action: #selector(panChange(_:)))
//            pan!.minimumNumberOfTouches=1
//            view.addGestureRecognizer(pan!)
//        }else{
//            edgepan=UIScreenEdgePanGestureRecognizer(target: self, action: #selector(panChange(_:)))
//            edgepan!.edges=UIRectEdge.Left
//            edgepan!.minimumNumberOfTouches=1
//            view.addGestureRecognizer(edgepan!)
//        }
//    }
//    
//    
//    func show(){
//        
//        UIView.animateWithDuration(0.1) {
//            [unowned self](a) in
//            
//            self.view.superview!.frame.origin.x = 2*self.view.bounds.width/3
//           
//        }
//       center=self.view.center
//        self.view.removeGestureRecognizer(edgepan!)
//        addengePan(true)
//        
//    }
//    func hide(){
//        UIView.animateWithDuration(0.1) {
//            
//            self.view.frame.origin.x = 0
//            
//        }
//        center=self.view.center
//        if pan != nil{
//            self.view.removeGestureRecognizer(pan!)}
//        addengePan(false)
//    }
//    
//    func panChange(pan:UIPanGestureRecognizer){
//      // view.userInteractionEnabled=false
//        let chgpoint=pan.translationInView(view)
//        pan.view?.center.x=center.x+chgpoint.x
//        if pan.state == .Ended{
//            if view.frame.origin.x<self.view.bounds.width/3{
//                hide()
//            }
//            if view.frame.origin.x>self.view.bounds.width/3{
//                show()
//            }
//            
//        }
    }



//MARK:scrollowview代理
extension mainView:UIScrollViewDelegate{

    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if scrollView.tag==200 {
        let pagewidth=scrollView.frame.width
        currentPage=scrollView.contentOffset.x/pagewidth
            titlels?.titleChange(Int(currentPage))
           
            loadData(currentPage: Int(currentPage))

        }
    
}
    
}
//MARK:UITableView代理
extension mainView:UITableViewDelegate,UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {


        guard dataAll[categoryArray[tableView.tag-100]]?.result.count>0 else{
            return 20
        }
        return (dataAll[categoryArray[tableView.tag-100]]?.result.count)!

           }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row==0{
            return 20

        }
        else{
            if dataAll[categoryArray[tableView.tag-100]]?.result.count>0&&(((dataAll[categoryArray[tableView.tag-100]]?.result[indexPath.section])?.category == "pic")||((dataAll[categoryArray[tableView.tag-100]]?.result[indexPath.section])?.category == "calendar")){
            
            return 355
            
            }else{
            return 115
            }
        }
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
          let data=dataAll[categoryArray[tableView.tag-100]]! as allModel
        guard data.now != nil else{
            let cell=UITableViewCell()
            return cell
        }
               if indexPath.row==0{
        let cell=Customcell.createHeadCell(tableView, atIndexPath: indexPath, dataAll: dataAll[categoryArray[tableView.tag-100]]!)
            return cell
        }else if indexPath.row==1{
                if data.result[indexPath.section].category=="pic"||data.result[indexPath.section].category=="calendar"{
                    let cell=CustomCell2.createCustomCell2(tableView, atIndexPath: indexPath, dataAll: data)
                    
                    cell.closure={
                        [weak self](a) in
                        UMSocialSnsService.presentSnsIconSheetView(self, appKey: "57b1797067e58e3aab002deb", shareText: "果壳", shareImage:nil, shareToSnsNames: [UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite], delegate: self)
                       
                    }
                    return cell
                }else{
                   
                    let cell=customCell1.createCell1(tableView, atIndexPath: indexPath, dataAll: dataAll[categoryArray[tableView.tag-100]]!)
                    cell.closure={
                        [weak self](a) in
                        UMSocialSnsService.presentSnsIconSheetView(self, appKey: "57b1797067e58e3aab002deb", shareText: "果壳", shareImage:nil, shareToSnsNames: [UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite], delegate: self)
                    
                        
                    }

                    return cell
                }
        }else{
            let cell=UITableViewCell(frame:CGRect(x: 0, y: 0, width: screenWidth, height: 10))
           cell.backgroundColor=UIColor(white: 0.6, alpha: 0.8)
            
            return cell
            }
            
       
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row==1{
        let vc=DetailController()
      
       let cnt=dataAll[categoryArray[tableView.tag-100]]?.result.count
        var array:[resultModel]=[]
        for i in indexPath.section..<cnt!{
            array.append((dataAll[categoryArray[tableView.tag-100]]?.result[i])!)
        }

           vc.dataResult=array
            presentViewController(vc, animated: true, completion: nil)

        }else if indexPath.row==0{
            let vc=sourceGroupViewController()
            vc.group=dataAll[categoryArray[tableView.tag-100]]?.result[indexPath.section].source_data!
             presentViewController(vc, animated: true, completion: nil)
        }
       tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
}



















