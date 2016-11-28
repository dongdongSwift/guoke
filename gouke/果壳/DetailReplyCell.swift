//
//  DetailReplyCell.swift
//  果壳
//
//  Created by qianfeng on 2016/10/31.
//  Copyright © 2016年 陶杰. All rights reserved.
//

import UIKit

class DetailReplyCell: UITableViewCell {

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
    }
        override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    class func createDetailReplyCell(tableView:UITableView,atIndexPath indexPath:NSIndexPath,data:[retModel])->DetailReplyCell{
        let cell=tableView.dequeueReusableCellWithIdentifier("DetailReplyCell", forIndexPath: indexPath) as! DetailReplyCell
        cell.name.text=data[indexPath.row-1].author?.nickname
        cell.content.text=data[indexPath.row-1].content
        cell.time.text=data[indexPath.row-1].date_created
        
        if data[indexPath.row-1].likings_count==0{
            
        }else{cell.like_count.text=String((data[indexPath.row-1].likings_count!))}
        
        cell.icon.kf_setImageWithURL(NSURL(string: (data[indexPath.row-1].author?.avatar?.large)!))
        return cell
    }

    
}
