//
//  CustomCell2.swift
//  果壳
//
//  Created by qianfeng on 2016/10/29.
//  Copyright © 2016年 张冬. All rights reserved.
//

import UIKit

class CustomCell2: UITableViewCell {
    var closure:(()->())?
    @IBOutlet weak var picture: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var content: UILabel!
    
    @IBOutlet weak var comentcount: UILabel!
   
    @IBOutlet weak var likecount: UILabel!
    
   
    @IBAction func btnClick(sender: UIButton) {
        if sender.tag==140{
            
        }else if sender.tag==141{
            content.text=String((content.text! as NSString).integerValue+1)
            let btn=sender.viewWithTag(141) as! UIButton
            btn.setImage(UIImage(named: "comment_like_icon"), forState: .Selected)
            btn.selected=true
            btn.userInteractionEnabled=false
            
            
        }else if sender.tag==142{
            
            if closure != nil{
                closure!()
            }
        }
    }
    func didFinishGetUMSocialDataInViewController(response: UMSocialResponseEntity!) {
        if response.responseCode == UMSResponseCodeSuccess {
    
        }
    }

    
    
    
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    class func createCustomCell2(tableView:UITableView,atIndexPath indexPath:NSIndexPath,dataAll:allModel?)->CustomCell2{
        let model=dataAll!.result[indexPath.section]
        let cell=tableView.dequeueReusableCellWithIdentifier("CustomCell2", forIndexPath: indexPath) as! CustomCell2
        cell.title.text=model.title
        cell.content.text=model.summary
        cell.comentcount.text=String((model.replies_count ?? 0) as Int)
        cell.likecount.text=String(model.likings_count as! Int)
        if model.category=="calendar"{
        cell.picture.kf_setImageWithURL(NSURL(string: model.images![0]))
        }else{
            cell.picture.kf_setImageWithURL(NSURL(string: model.headline_img!))
        }
        return cell
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
