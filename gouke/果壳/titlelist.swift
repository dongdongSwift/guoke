//
//  titlelist.swift
//  果壳
//
//  Created by qianfeng on 2016/10/20.
//  Copyright © 2016年 陶杰. All rights reserved.
//

import UIKit

class titlelist:UIView {
    var titlies:[String]=[]
    var labelArray:[UILabel]=[]
    var scroll:UIScrollView?
    var pageChangeClosure:((Int)->())?
    init(frame:CGRect,titlies:[String]){
        super.init(frame: frame)
        self.titlies=titlies
        configUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configUI(){
         scroll=UIScrollView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 50))
       
        scroll?.backgroundColor=UIColor.whiteColor()
        scroll?.userInteractionEnabled=true
        scroll?.contentOffset=CGPoint(x: 0, y: 0)
        
        scroll?.showsVerticalScrollIndicator=false
        scroll?.showsHorizontalScrollIndicator=false
        let labelWidth=Int(screenWidth)/6+5
        for i in 0..<titlies.count{
            
            let label=UILabel(frame: CGRect(x: 0+i*labelWidth, y: 5, width: Int(screenWidth)/6, height: 30))
            label.tag=100+i
            label.userInteractionEnabled=true
            let tapgest=UITapGestureRecognizer(target: self, action: #selector(tapGes(_:)))
            label.addGestureRecognizer(tapgest)
            label.text=titlies[i]
            label.textColor=UIColor.lightGrayColor()
            label.font=UIFont.systemFontOfSize(17)
            label.textAlignment = .Center

           labelArray.append(label)
            scroll?.addSubview(label)
            
            
        }
        scroll?.contentSize=CGSize(width: CGFloat(labelWidth*titlies.count), height: 50)
        self.addSubview(scroll!)
        titleChange(0)
    }
    func tapGes(tap:UITapGestureRecognizer){
       titleChange((tap.view?.tag)!-100)
        if (pageChangeClosure != nil){
            pageChangeClosure!((tap.view?.tag)!-100)
        }
    }
    
    func titleChange(tag:Int){
        for i in 0..<labelArray.count{
            labelArray[i].font=UIFont.systemFontOfSize(17)
        }
 labelArray[tag].font=UIFont.boldSystemFontOfSize(20)
        if (pageChangeClosure != nil){
            pageChangeClosure!(tag)}
    }
        
    
    
}
