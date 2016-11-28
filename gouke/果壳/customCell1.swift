//
//  customCell1.swift
//  果壳
//
//  Created by qianfeng on 2016/10/24.
//  Copyright © 2016年 张冬. All rights reserved.
//

import UIKit

class customCell1: UITableViewCell {
    var closure:(()->())?
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var content: UILabel!
   
    @IBOutlet weak var picture: UIImageView!
  
   
   
    @IBOutlet weak var comentLabel: UILabel!
  
    @IBOutlet weak var likecountLabel: UILabel!
    @IBAction func btnClick(sender: UIButton) {
        if sender.tag==143{
         
        }else if sender.tag==144{
            likecountLabel.text=String((likecountLabel.text! as NSString).integerValue+1)
            let btn=sender.viewWithTag(144) as! UIButton
            btn.setImage(UIImage(named: "comment_like_icon"), forState: .Selected)
            btn.selected=true
            btn.userInteractionEnabled=false
            
            
        }else if sender.tag==145{
           
            if closure != nil{
                closure!()
            }
        }

    }
    
   
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    class func createCell1(tableView:UITableView,atIndexPath indexPath:NSIndexPath,dataAll:allModel?)->customCell1{
        var model=resultModel()
        if tableView.tag==120{

         model=dataAll!.result[indexPath.row-1]}else{
            model=dataAll!.result[indexPath.section]
        }
        let cell=tableView.dequeueReusableCellWithIdentifier("customCell1", forIndexPath: indexPath) as! customCell1
        cell.title.text=model.title
       
        cell.content.text=model.summary
        cell.comentLabel.text=String((model.replies_count ?? 0) as Int)
        cell.likecountLabel.text=String(model.likings_count as! Int)
        cell.picture.kf_setImageWithURL(NSURL(string: model.headline_img!))
        return cell
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
