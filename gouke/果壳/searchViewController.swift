//
//  searchViewController.swift
//  果壳
//
//  Created by qianfeng on 2016/11/7.
//  Copyright © 2016年 陶杰. All rights reserved.
//

import UIKit
import Alamofire
class searchViewController: UIViewController {
    var customNavBar:UIView?
    var searchView:SearchList?
    var searchBar:UITextField?
    var keyWordsData:keyWordsModel?{
        didSet{
            initKeyWords()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
view.backgroundColor=UIColor.whiteColor()
        initUI()
        loadData()
        
    }
    func loadData(){
        Alamofire.request(.GET, keywordsUrl).responseData{ [weak self](response) in
            guard response.result.error == nil else{
               return
            }

            self!.keyWordsData=keyWordsModel.parseData(response.result.value!)
          
           
            
        }
    }
    func initKeyWords(){
        
        let array=keyWordsData?.result![0].items
        var x:CGFloat=20
        let y:CGFloat=84
        let h:CGFloat=25
        var row:CGFloat=0
        for i in 0..<array!.count{
            let w=NSString(string: array![i].text!).boundingRectWithSize(CGSizeMake(screenWidth-20*2, 40), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName : UIFont.systemFontOfSize(18)], context: nil).size.width+20
            if  (x+w)<=(screenWidth-20) {
               
            }else{
                row+=1
                x=20
            }
            let label=UIButton(frame: CGRectMake(x, y+row*(h+20), w, h))
            label.userInteractionEnabled=true
             label.tag=600+i
            label.layer.borderWidth=1
            label.layer.borderColor=UIColor.brownColor().CGColor
            label.layer.cornerRadius=5
            label.layer.masksToBounds=true
            label.setTitle(array![i].text!, forState: .Normal)
            label.setTitleColor(UIColor.brownColor(), forState: .Normal)
            label.titleLabel?.text=array![i].text!
            label.titleLabel?.textAlignment = .Center
//            label.textAlignment = .Center
//            label.text=array![i].text!
            x+=w+20
            view.addSubview(label)
            label.addTarget(self, action: #selector(tapAction(_:)), forControlEvents:.TouchUpInside)
//            let tap=UITapGestureRecognizer(target: self, action: #selector(tapAction(_:)))
//            tap.numberOfTapsRequired=1
//            tap.numberOfTouchesRequired=1
//            label.addGestureRecognizer(tap)
        }
        
    }
    func tapAction(tap:UIButton){
        
        let index=tap.tag-600
        let key=keyWordsData?.result![0].items![index].text
        searchBar?.text=key
        if searchBar!.isFirstResponder(){
            searchBar?.resignFirstResponder()}else{
            showList(String(format: searchUrl, "%d",(self.searchBar?.text)!))
        }
//        showSingleton.shareShow.show { [weak self](a) in
//             self!.showList(String(format: searchUrl, "%d",(self!.searchBar?.text)!))
//        }
//        struct Static {
//            static var onceToken: dispatch_once_t = 0
//            
//        }
//        dispatch_once(&Static.onceToken) {
//            self.showList(String(format: searchUrl, "%d",(self.searchBar?.text)!))
//        }
//        showList(String(format: searchUrl, "%d",(self.searchBar?.text)!))
        
        
    }
    func showList(url:String?){
        
        searchView=SearchList(frame: CGRect(x: 0, y: 64, width: screenWidth, height: screenHeight-64), url: url)
        self.view.addSubview(searchView!)
//        searchBar?.resignFirstResponder()
    }
    func initUI(){
        automaticallyAdjustsScrollViewInsets=false
        customNavBar=UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 64))
        customNavBar?.backgroundColor=UIColor.brownColor()
        self.view.addSubview(customNavBar!)
        let leftbtn=UIButton.createBtn(UIImage(named:"bar_back_icon"))
        let rightbtn1=UIButton.createBtn(UIImage(named:"search_ic"))
       
        leftbtn.frame=CGRect(x: 5, y: 27, width: 32, height: 32)
        rightbtn1.frame=CGRect(x: screenWidth-45, y: 27, width: 40, height: 32)
        
        leftbtn.tag=104
        rightbtn1.tag=105
        customNavBar?.addSubview(leftbtn)
        customNavBar?.addSubview(rightbtn1)
      
        leftbtn.addTarget(self, action: #selector(btnClick(_:)), forControlEvents: .TouchUpInside)
        rightbtn1.addTarget(self, action: #selector(btnClick(_:)), forControlEvents: .TouchUpInside)
        
        searchBar=UITextField(frame: CGRect(x: 0, y: 24, width: 200, height: 40))
        searchBar?.center.x=(customNavBar?.center.x)!
         searchBar?.textColor=UIColor.whiteColor()
        searchBar?.delegate=self
        
searchBar?.attributedPlaceholder=NSAttributedString(string: "   请输入关键词", attributes: [NSForegroundColorAttributeName:UIColor.whiteColor()])
       
        searchBar?.returnKeyType = .Search
        searchBar?.tintColor=UIColor.whiteColor()
        searchBar?.clearButtonMode = .Always
        searchBar?.borderStyle = .None
        
        searchBar?.becomeFirstResponder()
    
        customNavBar?.addSubview(searchBar!)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardDidHide(_:)), name:UIKeyboardDidHideNotification, object: nil)
    }
    
    func btnClick(btn:UIButton){
        if btn.tag==104{
            navigationController?.popViewControllerAnimated(true)
        }else if btn.tag==105{
            print("11")
            if searchBar?.text != ""{
                if (searchBar!.isFirstResponder()){
                    searchBar?.resignFirstResponder()
                }else{
                    showList(String(format: searchUrl, "%d",(searchBar?.text)!))
                }
            }
        }
    }
//    键盘隐藏执行的方法
    func keyboardDidHide(not:NSNotification){
        if searchBar?.text != ""{
            print("keyhide")
           showList(String(format: searchUrl, "%d",(searchBar?.text)!))}else{
            
        }
//        searchBar?.resignFirstResponder()
    }
    
     deinit{
        
            NSNotificationCenter.defaultCenter().removeObserver(self)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    

}
extension searchViewController:UITextFieldDelegate{
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        searchBar?.resignFirstResponder()
        return true
    }
    func textFieldShouldClear(textField: UITextField) -> Bool{
        searchView?.removeFromSuperview()
        searchBar?.resignFirstResponder()
        
        return true
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        searchBar?.resignFirstResponder()
    }
}