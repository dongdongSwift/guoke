//
//  DetailCellHead1.swift
//  果壳
//
//  Created by qianfeng on 2016/10/31.
//  Copyright © 2016年 陶杰. All rights reserved.
//

import UIKit

class DetailCellHead1: UITableViewCell {

       
    @IBOutlet weak var content: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       
        let g = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        
        addGestureRecognizer(g)

    }
    func tapAction(tap:UIGestureRecognizer){
        print("101")
        let view=tap.view?.viewWithTag(301) as! UILabel
        if view.text=="查看全部评论"{
        print("123456")
        }
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
