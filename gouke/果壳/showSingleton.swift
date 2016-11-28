//
//  showSingleton.swift
//  果壳
//
//  Created by qianfeng on 2016/11/17.
//  Copyright © 2016年 陶杰. All rights reserved.
//

import UIKit

class showSingleton: NSObject {
static let shareShow=showSingleton()
    private override init() {}
    func show(closure:(Void->Void)){
        closure()
    }
}
