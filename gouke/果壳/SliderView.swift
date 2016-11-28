//
//  SliderView.swift
//  果壳
//
//  Created by qianfeng on 2016/10/21.
//  Copyright © 2016年 陶杰. All rights reserved.
//

import UIKit

class SliderView: UIViewController {
    var tableview:UITableView?
    var changeClosure:((NSIndexPath)->())?
    var groupArray=["首页","消息","收藏页","设置"]
    var groupIcon=["home","mail","favourite","setup"]
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor=UIColor.redColor()
        configUI()
    }
    func configUI(){
        tableview=UITableView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        view.addSubview(tableview!)
        tableview?.userInteractionEnabled=true
        tableview?.delegate=self
        tableview?.dataSource=self
        tableview?.bounces=false
        tableview?.separatorStyle = .SingleLine
        tableview?.tableHeaderView=NSBundle.mainBundle().loadNibNamed("headView", owner: nil, options: nil).last as? headView
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}
//MARK:uitablevbiew代理
extension SliderView:UITableViewDelegate,UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell=tableview?.dequeueReusableCellWithIdentifier("cell")
        if cell==nil{
            cell=UITableViewCell(style: .Default, reuseIdentifier: "cell")
            
        }
        
        cell?.imageView?.frame=CGRectMake(0, 0, 60, 60)
        cell?.imageView?.image=UIImage(named: groupIcon[indexPath.row])
        cell?.textLabel?.text=groupArray[indexPath.row]
        return cell!
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        changeClosure!(indexPath)
    }
}