//
//  WebView.swift
//  果壳
//
//  Created by qianfeng on 2016/10/27.
//  Copyright © 2016年 陶杰. All rights reserved.
//

import UIKit

class WebView: UIWebView,UIWebViewDelegate {
    var webViewH:CGFloat?
    init(frame: CGRect,link:String) {
        super.init(frame: frame)
        
        
        let url=NSURL(string: link)
        let request=NSURLRequest(URL: url!)
       self.scrollView.bounces=false
       self.delegate=self
        self.loadRequest(request)
        self.scrollView.directionalLockEnabled=true
        self.scalesPageToFit=true
//        let tmpView=self.subviews[0] as! UIScrollView
      
//       self.scrollView.addObserver(self, forKeyPath: "contentsize", options: NSKeyValueObservingOptions.New, context: nil)
      
    }
    
//    override func observeValueForKeyPath(keyPath:keyPath, ofObject object:self, change:, context:) {
//        
//    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func webViewDidFinishLoad(webView: UIWebView) {
//        self.webViewH=webView.scrollView.contentSize.height
//    var newframe=webView.frame
//        newframe.size.height=webViewH!
//        webView.frame=newframe
        self.webViewH=CGFloat((webView.stringByEvaluatingJavaScriptFromString("document.body.scrollHeight")! as NSString).floatValue)
//        self.frame.size.height=webViewH!
//        let tmp=webView.subviews[0] as! UIScrollView
//        tmp.frame.size.height=webViewH!
//        webView.frame.size.height=webViewH!
//        tmp.scrollEnabled=false
    }
    
}












