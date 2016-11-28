//
//  SearchListCell.swift
//  果壳
//
//  Created by qianfeng on 2016/11/15.
//  Copyright © 2016年 陶杰. All rights reserved.
//

import UIKit

class SearchListCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var content: UILabel!
    
//    @IBOutlet weak var title: UITextView!
    
//    @IBOutlet weak var content: UITextView!
//    @IBOutlet weak var title: UIWebView!
    
//    @IBOutlet weak var content: UIWebView!
    
    @IBOutlet weak var pic: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    class func createSearchListCell(tableView:UITableView,atIndexPath indexPath:NSIndexPath,data:[searchResultModel])->SearchListCell{
    let cell=tableView.dequeueReusableCellWithIdentifier("SearchListCell", forIndexPath: indexPath) as! SearchListCell
        let model=data[indexPath.row]
        
        cell.content.text=model.summary
        cell.content.textColor=UIColor.grayColor()
//model.title="科学<strong style=\"color:yellow;\">美</strong><strong>国</strong>人：<strong>选</strong>择的艺术"
        var range=model.title?.rangeOfString("<strong>")
        while range != nil{
            
            model.title?.replaceRange(range!, with: "<strong style=\"color:green;\">")
         range=model.title?.rangeOfString("<strong>")}
        
        var range1=cell.content.text!.rangeOfString("<strong>")
        while range1 != nil{
            cell.content.text!.replaceRange(range1!, with: "<strong style=\"color:green;\">")
            range1=cell.content.text!.rangeOfString("<strong>")}
        let options=[NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType,NSCharacterEncodingDocumentAttribute:NSUTF8StringEncoding]
        let titledata=model.title?.dataUsingEncoding(NSUTF8StringEncoding)
        let contentdata=cell.content.text!.dataUsingEncoding(NSUTF8StringEncoding)
       cell.title.attributedText=try? NSAttributedString.init(data: titledata!, options:options as! [String : AnyObject] , documentAttributes: nil)
        
      cell.content.attributedText=try? NSAttributedString.init(data: contentdata!, options:options as! [String : AnyObject] , documentAttributes: nil)
      
       
            cell.pic.kf_setImageWithURL(NSURL(string: model.headline_img!))
        
        return cell
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
