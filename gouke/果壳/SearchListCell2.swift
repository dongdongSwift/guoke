//
//  SearchListCell2.swift
//  果壳
//
//  Created by qianfeng on 2016/11/16.
//  Copyright © 2016年 陶杰. All rights reserved.
//

import UIKit

class SearchListCell2: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var content: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    class func createSearchListCell2(tableView:UITableView,atIndexPath indexPath:NSIndexPath,data:[searchResultModel])->SearchListCell2{
        let cell=tableView.dequeueReusableCellWithIdentifier("SearchListCell2", forIndexPath: indexPath) as! SearchListCell2
        let model=data[indexPath.row]
        //        cell.content.loadHTMLString(model.summary!, baseURL: nil)
        //        cell.title.loadHTMLString(model.title!, baseURL: nil)
        cell.content.text=model.summary
        //model.title="科学<strong style=\"color:yellow;\">美</strong><strong>国</strong>人：<strong>选</strong>择的艺术"
        var range=model.title?.rangeOfString("<strong>")
        while range != nil{
            model.title?.replaceRange(range!, with: "<strong style=\"color:green;\">")
            range=model.title?.rangeOfString("<strong>")}
        var range1=model.summary?.rangeOfString("<strong>")
        while range1 != nil{
            model.summary?.replaceRange(range1!, with: "<strong style=\"color:green;\">")
            range1=model.summary?.rangeOfString("<strong>")}
        let options=[NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType,NSCharacterEncodingDocumentAttribute:NSUTF8StringEncoding]
        let titledata=model.title?.dataUsingEncoding(NSUTF8StringEncoding)
        let contentdata=model.summary!.dataUsingEncoding(NSUTF8StringEncoding)
        cell.title.attributedText=try? NSAttributedString.init(data: titledata!, options:options as! [String : AnyObject] , documentAttributes: nil)
        cell.content.attributedText=try? NSAttributedString.init(data: contentdata!, options:options as! [String : AnyObject] , documentAttributes: nil)
        
               return cell
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
