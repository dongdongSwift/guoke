//
//  sourceGroupViewController.swift
//  果壳
//
//  Created by qianfeng on 2016/10/29.
//  Copyright © 2016年 陶杰. All rights reserved.
//

import UIKit
import MJRefresh
class sourceGroupViewController: UIViewController {
    var group:sourceDataModel?{
        didSet{
            showData()
        }
    }
    var currentOffSet=0
    var tableview:UITableView?
    var data=allModel()
    func loadData(){
       
        let downloader=SourceDataDownloader()
        downloader.download(data, group: (group?.key)!,tableview: tableview!, currentOffSet: currentOffSet) { (a) in
            self.tableview?.reloadData()
//            print("\(self.data.result.count)=-=-")
        }

    }
    func showData(){
        
        
         initUI()
        loadData()
        
        
       
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor=UIColor.whiteColor()
        
//        initUI()
    }
    func initUI(){
        let
        customNavBar=UIView(frame: CGRect(x: 0, y: 20, width: screenWidth, height: 44))
        customNavBar.backgroundColor=UIColor.whiteColor()
        self.view.addSubview(customNavBar)
        let v=UIView(frame: CGRect(x: 0, y: 43, width: screenWidth, height: 1))
        v.backgroundColor=UIColor.lightGrayColor()
        customNavBar.addSubview(v)
        let leftbtn=UIButton.createBtn(UIImage(named:"bar_dismiss_icon"))
        leftbtn.frame=CGRect(x: 5, y: 5, width: 32, height: 32)
        leftbtn.addTarget(self, action: #selector(btnClick(_:)), forControlEvents: .TouchUpInside)
        customNavBar.addSubview(leftbtn)
        tableview=UITableView(frame: CGRect(x: 0, y: 64, width: screenWidth, height: screenHeight-64))
        view.addSubview(tableview!)
        tableview!.tag=120
        tableview?.showsHorizontalScrollIndicator=false
        tableview?.delegate=self
        tableview?.dataSource=self
        tableview!.mj_header=MJRefreshNormalHeader(refreshingBlock: {
            self.currentOffSet=0
            self.loadData()
            self.tableview!.reloadData()
        })
        tableview!.mj_footer=MJRefreshAutoNormalFooter(refreshingBlock: {
            self.currentOffSet+=20
            self.loadData()
            self.tableview!.reloadData()
        })

        tableview?.registerNib(UINib(nibName: "firstCellTableViewCell", bundle: nil), forCellReuseIdentifier: "FirstCell")
        tableview!.registerNib(UINib(nibName: "customCell1", bundle: nil), forCellReuseIdentifier:"customCell1")
    }
    func btnClick(btn:UIButton){
         self.dismissViewControllerAnimated(true, completion: nil)
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
extension sourceGroupViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard data.now != nil else{
            return 1
        }
        return (data.result.count)+1
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 115
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row==0{
            let cell=firstCellTableViewCell.createFirstCell(tableView, atIndexPath: indexPath, sourceData: group)
            return cell
        }else{
        
        let cell=customCell1.createCell1(tableView, atIndexPath: indexPath, dataAll: data)
            return cell
        
        }

    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row>0{
            let vc=DetailController()
            let cnt=data.result.count
            var array:[resultModel]=[]
            for i in (indexPath.row-1)..<cnt{
                array.append((data.result[i]))
            }
             vc.dataResult=array
            presentViewController(vc, animated: true, completion: nil)
           
        }
    tableView.deselectRowAtIndexPath(indexPath, animated:true)
    }
    
}








