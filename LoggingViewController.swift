//
//  LoggingViewController.swift
//  CloundIM
//
//  Created by Jason on 15/9/22.
//  Copyright © 2015年 KYLERUAN. All rights reserved.
//

import UIKit
import JSAnimatedImagesView
import JGProgressHUD

class LoggingViewController: UIViewController,JSAnimatedImagesViewDataSource {
    @IBOutlet weak var LogInStackView: UIStackView!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var WallPaper: JSAnimatedImagesView!
    @IBOutlet weak var rembSwich: UISwitch!
    
    let hub = JGProgressHUD(style: .ExtraLight)
    let defualt = NSUserDefaults.standardUserDefaults()
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.WallPaper.dataSource = self
        rembSwich.on = NSUserDefaults.standardUserDefaults().valueForKey("rmb_pwd") as? Bool ?? false
        if ( rembSwich.on){
            self.password.text = NSUserDefaults.standardUserDefaults().valueForKey("pwd") as? String
            self.userName.text = NSUserDefaults.standardUserDefaults().valueForKey("name") as? String
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animateWithDuration(2) { () -> Void in
            self.LogInStackView.axis =  .Vertical
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 //MARK: - JSAnimatedImagesViewDataSource
    func animatedImagesNumberOfImages(animatedImagesView: JSAnimatedImagesView!) -> UInt {
        return 3
    }
    
    func animatedImagesView(animatedImagesView: JSAnimatedImagesView!, imageAtIndex index: UInt) -> UIImage! {
        return UIImage(named: "logInBackground\(index + 1)")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.hidden = true
        //判断是否第一次启动：
        if rembSwich.on{
            if((NSUserDefaults.standardUserDefaults().boolForKey("IsFirstLaunch") as Bool!) == false){
                print("第一次启动")
                //设置为非第一次启动
                NSUserDefaults.standardUserDefaults().setBool(true, forKey: "IsFirstLaunch")
            }else{
                self.logInTapped()
            }
        }
    }

    
    
    
    
    @IBAction func logInTapped() {
        checkForLog()
        verifyLogInform()
        
    }
    
    //MARK: - Private methods
    
    /**
    确认登入信息是否都填完
    */
 private   func checkForLog(){
        hub.textLabel.text = "Loading..."
        //        hub.indicatorView = JGProgressHUDSuccessIndicatorView()
        hub.showInView(self.view)
        if userName.text!.isEmpty {
            hub.textLabel.text = "用户名为空"
            hub.indicatorView = JGProgressHUDErrorIndicatorView()
            hub.showInView(self.view, animated: true)
            self.performSelector("lasting", withObject: self, afterDelay: NSTimeInterval(2))
            userName.becomeFirstResponder()
            return
        }
        if password.text!.isEmpty {
            hub.textLabel.text = "密码为空"
            hub.indicatorView = JGProgressHUDErrorIndicatorView()
            hub.showInView(self.view, animated: true)
            self.performSelector("lasting", withObject: self, afterDelay: NSTimeInterval(2))
            password.becomeFirstResponder()
            return
        }

    }
    
    /**
     验证登入信息
    */
  private  func verifyLogInform(){
        let query = AVQuery(className: Constants.AVClassName)
        query.whereKey(Constants.AVElementUser, equalTo: userName.text)
        query.getFirstObjectInBackgroundWithBlock { (object, error) -> Void in
           //如果存在用户
            if object != nil  {
                if self.password.text == object.objectForKey(Constants.AVElementPassword) as? String{
                    self.hub.textLabel.text = "登入成功"
                    self.hub.indicatorView = JGProgressHUDSuccessIndicatorView()
                    self.hub.showInView(self.view, animated: true)
                    
                    self.performSegueWithIdentifier("toCommunicationList", sender: self)
                    self.removeFromParentViewController()
                }else{
                    self.hub.textLabel.text = "密码错误"
                    self.hub.indicatorView = JGProgressHUDErrorIndicatorView()
                    self.hub.showInView(self.view, animated: true)
                    self.performSelector("lasting", withObject: self, afterDelay: NSTimeInterval(3))
                }
                
            }else{
                self.performSelector("lasting", withObject: self, afterDelay: NSTimeInterval(3))
                self.hub.textLabel.text = "该用户没有注册"
                self.hub.indicatorView = JGProgressHUDErrorIndicatorView()
                self.hub.showInView(self.view, animated: true)
                self.performSelector("lasting", withObject: self, afterDelay: NSTimeInterval(3))
                //                self.errorNotice("该用户没有注册")
            }
            
            
            let UserNameKey = "name"
            let PwdKey = "pwd"
            let RmbPwdKey = "rmb_pwd"
            //设置存储信息
            NSUserDefaults.standardUserDefaults().setObject(self.userName.text, forKey: UserNameKey)
            NSUserDefaults.standardUserDefaults().setObject(self.password.text, forKey: PwdKey)
            NSUserDefaults.standardUserDefaults().setBool(self.rembSwich.on, forKey: RmbPwdKey)
            //设置同步
            NSUserDefaults.standardUserDefaults().synchronize()
            
            
        }
    
    }
    
  private  func lasting(){
        hub.dismiss()
    }
   
    
    



}
