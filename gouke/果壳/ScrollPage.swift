//
//  ScrollPage.swift
//  果壳
//
//  Created by qianfeng on 2016/10/27.
//  Copyright © 2016年 陶杰. All rights reserved.
//

import UIKit

class ScrollPage: UIScrollView {
    
    private var tableview1:UITableView?
    private var pageNum:Int?
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var tableArray:[UITableView]=[]
     init(frame: CGRect,pageNum:Int) {
        super.init(frame: frame)
        self.pageNum=pageNum
        configView()
    }
    
        func configView(){
        
      self.contentSize=CGSize(width: screenWidth*CGFloat(pageNum!), height: self.frame.height)
        let pageWidth=self.frame.width
        let pageHeight=self.frame.height
        for i in 0..<pageNum!{
            let tableview = UITableView(frame: CGRect(x: pageWidth*CGFloat(i), y:0, width: pageWidth, height: pageHeight))
            tableArray.append(tableview)
            self.addSubview(tableview)

        
    }
   
}
}