//
//  Customcell.swift
//  果壳
//
//  Created by qianfeng on 2016/10/24.
//  Copyright © 2016年 陶杰. All rights reserved.
//

import UIKit

class Customcell: UITableViewCell {

    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var author: UILabel!
    
    @IBOutlet weak var category: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        icon.layer.cornerRadius=8
        icon.layer.masksToBounds=true

    }
    class func createHeadCell(tableView:UITableView,atIndexPath indexPath:NSIndexPath,dataAll:allModel?)->Customcell{
//        print(dataAll?.result.count)
        
//        print("\(indexPath.section)sec")
//        print("\(dataAll?.result.count)data")
        let model=dataAll!.result[indexPath.section]
        let cell=tableView.dequeueReusableCellWithIdentifier("customCell", forIndexPath: indexPath) as! Customcell
        cell.author.text=model.source_data?.key
        cell.category.text=model.category
        cell.icon.kf_setImageWithURL(NSURL(string: (model.source_data?.image)!))
        return cell
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
           
        // Configure the view for the selected state
    }
    
}
