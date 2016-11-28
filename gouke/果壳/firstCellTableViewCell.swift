//
//  firstCellTableViewCell.swift
//  果壳
//
//  Created by qianfeng on 2016/10/31.
//  Copyright © 2016年 张冬. All rights reserved.
//

import UIKit

class firstCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var content: UILabel!
    
    
    class func createFirstCell(tableView:UITableView,atIndexPath indexPath:NSIndexPath,sourceData:sourceDataModel?)->firstCellTableViewCell{
        let cell=tableView.dequeueReusableCellWithIdentifier("FirstCell", forIndexPath: indexPath) as! firstCellTableViewCell
        
        //        let sourcedata=dataAll?.result[indexPath.section].source_data
        cell.content.text=sourceData!.summary
        cell.title.text=sourceData!.title
        cell.icon.kf_setImageWithURL(NSURL(string: (sourceData?.image)!))
        return cell
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.icon.layer.cornerRadius=38.5
        self.icon.layer.borderWidth=1
        self.layer.borderColor=UIColor.grayColor().CGColor
        self.icon.clipsToBounds=true
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
