//
//  DetailRecommendCell.swift
//  果壳
//
//  Created by qianfeng on 2016/10/31.
//  Copyright © 2016年 陶杰. All rights reserved.
//

import UIKit

class DetailRecommendCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var content: UILabel!
    
    @IBOutlet weak var picture: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    class func createDetailRecommendCell(tableView:UITableView,atIndexPath indexPath:NSIndexPath,data:allModel)->DetailRecommendCell{
        let cell=tableView.dequeueReusableCellWithIdentifier("DetailRecommendCell", forIndexPath: indexPath) as! DetailRecommendCell
        cell.title.text=data.result[indexPath.row-1].title
        cell.content.text=data.result[indexPath.row-1].summary
        cell.picture.kf_setImageWithURL(NSURL(string: data.result[indexPath.row-1].headline_img!))
        
        return cell
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
