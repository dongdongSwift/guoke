//
//  DetailCell2.swift
//  果壳
//
//  Created by qianfeng on 2016/10/27.
//  Copyright © 2016年 陶杰. All rights reserved.
//

import UIKit

class DetailCell1: UITableViewCell {

    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var sourcename: UILabel!
    
    @IBOutlet weak var content: UILabel!
//    var data:[resultModel]?{
//        didSet{
//            showData()
//        }
//    }
//    func showData(){
////        self.content.text=data
//    }
    class func createDeatilCell1(tableView:UITableView,atIndexPath indexPath:NSIndexPath,sourceData:sourceDataModel?)->DetailCell1{
        let cell=tableView.dequeueReusableCellWithIdentifier("DetailCell1", forIndexPath: indexPath) as! DetailCell1
     
//        let sourcedata=dataAll?.result[indexPath.section].source_data
        cell.content.text=sourceData!.summary
        cell.sourcename.text=sourceData!.title
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
