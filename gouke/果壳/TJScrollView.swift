//
//  JLScrollView.swift
//  CustomCell-XIB
//
//  Created by 沈家林 on 16/9/14.
//  Copyright © 2016年 沈家林. All rights reserved.
//

import UIKit
import Kingfisher
import Alamofire
import SnapKit
class TJScrollView: UIView,UIScrollViewDelegate{
    var scollView:UIScrollView!
    var pageControl:UIPageControl!
    var guokedata=recommendModel()
    var imageArray:[String]=[]
    var timer:NSTimer!
    var preImageView:UIImageView!
    var nextImageView:UIImageView!
    var currentImageView:UIImageView!
    var label:UILabel{
        let label=UILabel(frame: CGRect(x: 10, y: 150, width: 300, height: 40))
        label.font=UIFont.boldSystemFontOfSize(18)
        label.numberOfLines=0
        label.textColor=UIColor.lightTextColor()
        return label
    }
    var label1:UILabel{
        let label=UILabel(frame: CGRect(x: 10, y: 150, width: 300, height: 40))
        label.font=UIFont.boldSystemFontOfSize(18)
        label.numberOfLines=0
        label.textColor=UIColor.lightTextColor()
        return label
    }
    var label2:UILabel{
        let label=UILabel(frame: CGRect(x: 10, y: 150, width: 300, height: 40))
        label.font=UIFont.boldSystemFontOfSize(18)
        label.numberOfLines=0
        label.textColor=UIColor.lightTextColor()
        return label
    }

    var advImgUrls:[String]=[]
    var curentPage:Int=0
    var viewWidth:CGFloat{
        return self.frame.size.width
    }
    var viewHeight:CGFloat{
        return self.frame.size.height
        
    }
    
//    init(frame: CGRect,imageNames:[String]?=nil) {
//        super.init(frame: frame)
//         imageArray=imageNames
//       
//        configView()
//    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        loadData()
        configView()
        loadData()

    }
    
//    func imageNameArray(array:[String]){
//        imageArray=array
//        
//        loadData()
//    }
    func loadData(){
        
        Alamofire.request(.GET,recommendUrl).responseJSON(completionHandler: { [unowned self] (response) in
            
//            let data=response.result.value as! [String:AnyObject]
//            
//            self.guokedata.now=data["now"] as? String
//            self.guokedata.ok=data["ok"] as? Bool
//            let dataArray=data["result"] as! [AnyObject]
            guard response.result.error == nil else{
                return
            }
            let array=(response.result.value)!["result"] as![AnyObject]
            
            for dic in array{
                let model=recommendResultModel()
                model.setValuesForKeysWithDictionary(dic as! [String : AnyObject])
//         model.picture=dic["picture"] as! String
//                print(model.custom_title)
                self.guokedata.result.append(model)
                
                self.imageArray.append(model.picture!)
                
            }
            self.configView()
            })
       

    }
    func configView(){
        
        if imageArray.count<=1{
            return
        }
        scollView=UIScrollView(frame: CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight))
        scollView.showsHorizontalScrollIndicator=false
        scollView.showsVerticalScrollIndicator=false
        scollView.bounces=false
        scollView.pagingEnabled=true
        self.addSubview(scollView)
        
        preImageView=UIImageView(frame: CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight))
        scollView.addSubview(preImageView)
        
        preImageView.addSubview(label)
        currentImageView=UIImageView(frame: CGRect(x: viewWidth, y: 0, width: viewWidth, height: viewHeight))
        scollView.addSubview(currentImageView)
//       let label1=creatLabel()
        currentImageView.addSubview(label1)
        nextImageView=UIImageView(frame: CGRect(x: 2*viewWidth, y: 0, width: viewWidth, height: viewHeight))
        scollView.addSubview(nextImageView)
//        let label2=creatLabel()
        nextImageView.addSubview(label2)
        scollView.contentSize=CGSize(width: 3*viewWidth, height: viewHeight)
        scollView.contentOffset=CGPoint(x: viewWidth, y: 0)
        scollView.delegate=self
        
        pageControl=UIPageControl(frame: CGRect(x: 0, y: viewHeight-30, width: screenWidth, height: 30))
        pageControl.numberOfPages=imageArray.count
        self.addSubview(pageControl)
        
       
        timer=NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: #selector(timeRun), userInfo: nil, repeats: false)
        
        curentPage=0
//        preImageView.image=UIImage(named: imageArray[imageArray.count-1])
        preImageView.kf_setImageWithURL(NSURL(string: imageArray[imageArray.count-1]), placeholderImage: Image(named: "placeholder-zt"))
        /***************************/
        
        label.text=guokedata.result[imageArray.count-1].custom_title
        
        
        

       //        currentImageView.image=UIImage(named: imageArray[0])
        currentImageView.kf_setImageWithURL(NSURL(string: imageArray[0]), placeholderImage: Image(named: "placeholder-zt"))
//        /***********************/
        label1.text=guokedata.result[0].custom_title

        
       //        nextImageView.image=UIImage(named: imageArray[1])
        nextImageView.kf_setImageWithURL(NSURL(string: imageArray[1]), placeholderImage: Image(named: "placeholder-zt"))
        /***********************/
               label2.text=guokedata.result[1].custom_title
       
        pageControl.currentPage=curentPage
        
    }
    
    func timeRun(){
        UIView.animateWithDuration(0.3, animations: {[unowned self] in
            self.scollView.contentOffset=CGPointMake(self.viewWidth*2, 0)
            }) {[unowned self] (b) in
               self.scrollViewDidEndDecelerating(self.scollView)
        }
    }
      
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        timer.invalidate()
        timer=NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: #selector(timeRun), userInfo: nil, repeats: false)
        if scollView.contentOffset.x==2*viewWidth{
            
            curentPage=(curentPage+1)%imageArray.count
        }else if scollView.contentOffset.x==0{
            
        curentPage=(curentPage-1+imageArray.count)%imageArray.count
        }
//        preImageView.image=UIImage(named: imageArray[(curentPage-1+imageArray.count)%imageArray.count])
        preImageView.kf_setImageWithURL(NSURL(string: imageArray[(curentPage-1+imageArray.count)%imageArray.count]), placeholderImage: Image(named: "placeholder-zt"))
        
       
        
        label.text=guokedata.result[(curentPage-1+imageArray.count)%imageArray.count].custom_title
       
        
//        currentImageView.image=UIImage(named: imageArray[curentPage])
        currentImageView.kf_setImageWithURL(NSURL(string: imageArray[curentPage]), placeholderImage: Image(named: "placeholder-zt"))
        
        
        label1.text=guokedata.result[curentPage].custom_title
        
       
        
//        nextImageView.image=UIImage(named: imageArray[(curentPage+1)%4])
        nextImageView.kf_setImageWithURL(NSURL(string: imageArray[(curentPage+1)%4]), placeholderImage: Image(named: "placeholder-zt"))
       
        
        label2.text=guokedata.result[(curentPage+1)%4].custom_title
        
        pageControl.currentPage=curentPage
        scollView.contentOffset=CGPoint(x: viewWidth, y: 0)
    }
    func creatLabel()->UILabel{
        let label=UILabel(frame: CGRect(x: 10, y: 150, width: 300, height: 40))
        label.font=UIFont.boldSystemFontOfSize(18)
        label.numberOfLines=0
        label.textColor=UIColor.lightTextColor()
       return label
        
 
    }
    
}
