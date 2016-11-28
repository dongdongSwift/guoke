//
//  Protocol.swift
//  果壳
//
//  Created by qianfeng on 2016/10/25.
//  Copyright © 2016年 张冬. All rights reserved.
//

import UIKit
import MJRefresh
enum BarButtonPosition {
    case left
    case right
}

protocol addRefreshProtocol:NSObjectProtocol {
        func addRefresh(header:(()->())?,footer:(()->())?)
    }
protocol NavigationProtocol:NSObjectProtocol {
    func addTitle(title:String)
    func addBarButton(title:String?,imageName:String?,bgImageName:String?,postion:BarButtonPosition,select:Selector)
}


extension addRefreshProtocol where Self:UITableViewController{
    func addRefresh(header:(()->())?=nil,footer:(()->())?=nil){
        if header != nil{
        tableView.mj_header=MJRefreshNormalHeader(refreshingBlock: header)
        }
        if footer != nil{
            tableView.mj_footer=MJRefreshAutoNormalFooter(refreshingBlock: footer)
        }
        
        
    }
}

extension NavigationProtocol where Self:UIViewController{
    func addTitle(title:String){
        let label=UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
        label.text=title
        label.font=UIFont.boldSystemFontOfSize(20)
        label.textColor=UIColor.whiteColor()
        label.textAlignment = .Center
        navigationItem.titleView=label
    }
    func addBarButton(title:String?=nil,imageName:String?=nil,bgImageName:String?=nil,postion:BarButtonPosition,select:Selector){
        let button=UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 44))
        if title != nil{
            button.setTitle(title, forState: .Normal)
        }
        if imageName != nil {
            button.setImage(UIImage(named: imageName!), forState: .Normal)
        }
        if bgImageName != nil{
            button.setBackgroundImage(UIImage(named:bgImageName!) , forState: .Normal)
        }
        button.setTitleColor(UIColor.blackColor(), forState: .Normal)
        button.setTitleColor(UIColor.grayColor(), forState: .Highlighted)
        button.addTarget(self, action: select, forControlEvents: .TouchUpInside)
        let barButtonItem=UIBarButtonItem(customView: button)
        if postion == .left {
            if navigationItem.leftBarButtonItems != nil{
                navigationItem.leftBarButtonItems=navigationItem.leftBarButtonItems!+[barButtonItem]
            }else{
                navigationItem.leftBarButtonItems=[barButtonItem]
            }
        }else{
            if navigationItem.rightBarButtonItems != nil{
                navigationItem.rightBarButtonItems=navigationItem.rightBarButtonItems!+[barButtonItem]
            }else{
                navigationItem.rightBarButtonItems=[barButtonItem]
            }
        }
    }
}
