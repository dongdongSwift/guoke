//
//  DetailReplyCell2.swift
//  果壳
//
//  Created by qianfeng on 2016/11/6.
//  Copyright © 2016年 陶杰. All rights reserved.
//

import UIKit

class DetailReplyCell2: UITableViewCell {
    
    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var time: UILabel!
    
   
    
    @IBOutlet weak var content: UILabel!
   
    @IBOutlet weak var like_count: UILabel!
    var data:[retModel]?

    override func awakeFromNib() {
        super.awakeFromNib()
        icon.layer.cornerRadius=15
        icon.layer.masksToBounds=true
        icon.layer.borderWidth=0.5
        icon.layer.borderColor=UIColor.blueColor().CGColor
//        content.scrollView.bounces=false
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    class func createDetailReplyCell2(tableView:UITableView,atIndexPath indexPath:NSIndexPath,data:[retModel])->DetailReplyCell2{
        let cell=tableView.dequeueReusableCellWithIdentifier("DetailReplyCell2", forIndexPath: indexPath) as! DetailReplyCell2
        cell.name.text=data[indexPath.row-1].author?.nickname
       
        let options=[NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType,NSCharacterEncodingDocumentAttribute:NSUTF8StringEncoding]
        
        let contentdata=data[indexPath.row-1].content!.dataUsingEncoding(NSUTF8StringEncoding)
        cell.content!.attributedText=try? NSAttributedString.init(data: contentdata!, options:options as! [String : AnyObject] , documentAttributes: nil)
//        cell.content.loadHTMLString(data[indexPath.row-1].html!, baseURL:nil)
        
        
        
        
        
        
        cell.time.text=data[indexPath.row-1].date_created
        
        if data[indexPath.row-1].likings_count==0{
            
        }else{cell.like_count.text=String((data[indexPath.row-1].likings_count!))}
        
        cell.icon.kf_setImageWithURL(NSURL(string: (data[indexPath.row-1].author?.avatar?.large)!))
        return cell
    }

    
}
