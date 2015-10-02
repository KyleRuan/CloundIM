//
//  RegisterTableViewController.swift
//  CloundIM
//
//  Created by Jason on 15/9/23.
//  Copyright © 2015年 KYLERUAN. All rights reserved.
//

import UIKit
import AJWValidator
import JVFloatLabeledTextField
import JGProgressHUD

class RegisterTableViewController: UITableViewController{
    @IBOutlet weak var doneBTN: UIBarButtonItem!
    @IBOutlet weak var passwordUITextField: JVFloatLabeledTextField!
    @IBOutlet weak var userNameUITextField: JVFloatLabeledTextField!
    @IBOutlet weak var comformPasswordUITextField: JVFloatLabeledTextField!
    @IBOutlet var mustRequried: [JVFloatLabeledTextField]!
    @IBOutlet weak var emailUITextField: JVFloatLabeledTextField!
    
    var inputs :Inputs = []

    let post = AVObject(className: Constants.AVClassName)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "新用户注册"
        doneBTN.enabled = false
        let validator = AJWValidator(type: .String)
        validator.addValidationToEnsureMinimumLength(3, invalidMessage: "至少三位字符")
        validator.addValidationToEnsureMaximumLength(10, invalidMessage: "最多10位字符")
        setValidator(validator, text: userNameUITextField,input: .user)
        
        
        let v2 = AJWValidator(type: .String)
        v2.addValidationToEnsureMinimumLength(3, invalidMessage: "密码至少3位")
        v2.addValidationToEnsureMaximumLength(15, invalidMessage: "最长15位")
        setValidator(v2, text: passwordUITextField,input: .password)
        
        
        let v3 = AJWValidator(type: .String)
        v3.addValidationToEnsureValidEmailWithInvalidMessage("Email格式不对")
        setValidator(v3, text: emailUITextField, input: .email)
        
        
        let v4 = AJWValidator(type: .String)
        v4.addValidationToEnsureCustomConditionIsSatisfiedWithBlock({ (_) -> Bool in
            return self.passwordUITextField.text == self.comformPasswordUITextField.text
            }, invalidMessage: "两次密码不一样")
        setValidator(v4, text: comformPasswordUITextField, input: .comformPassword)
        
    }

    
    
    func setValidator(validator:AJWValidator,text:JVFloatLabeledTextField,input:Inputs){
        text.ajw_attachValidator(validator)
        validator.validatorStateChangedHandler = { (newState: AJWValidatorState) -> Void in
            switch newState {
            case .ValidationStateValid:
               text.layer.borderColor = UIColor.clearColor().CGColor
                self.inputs.unionInPlace(input)
                if self.inputs {
                    self.doneBTN.enabled = true
                }
                
            default:
               text.layer.borderColor = UIColor.redColor().CGColor
                text.layer.borderWidth = 2
                
            }
            
        }
        
    }
    

    
    
    
    
    
    
    
    
    //1 要查找是否已经注册
    //2 已注册则再次注册
    //3 没有注册则返回登入界面
    @IBAction func doneTap(sender: UIBarButtonItem) {
        let hub = JGProgressHUD(style: JGProgressHUDStyle.Dark)
        hub.textLabel.text = "Loading..."
        hub.showInView(self.view)
        post["User"] = userNameUITextField.text
        post["Password"] = passwordUITextField.text
        post["Email"] =  emailUITextField.text
        //        post.save()
        //        let query = AVQuery(className: Constants.AVClassName)
        let query = AVQuery(className: Constants.AVClassName)
        query.whereKey(Constants.AVElementUser, equalTo: userNameUITextField.text)
        query.getFirstObjectInBackgroundWithBlock { (objects, error) -> Void in
            
            if objects != nil{
                hub.textLabel.text = "该用户已注册"
                hub.indicatorView = JGProgressHUDErrorIndicatorView()
                hub.showInView(self.view, animated: true)
                self.doneBTN.enabled = false
                self.userNameUITextField.layer.borderColor = UIColor.redColor().CGColor
                self.userNameUITextField.layer.borderWidth = 2
                self.userNameUITextField.becomeFirstResponder()
            }else{
                self.post.saveInBackgroundWithBlock { (success, error) -> Void in
                    if success{
                        hub.textLabel.text = "注册成功"
                        hub.indicatorView = JGProgressHUDSuccessIndicatorView()
                        hub.showInView(self.view, animated: true)
                        //                         self.successNotice("注册成功")
                        self.navigationController?.popViewControllerAnimated(true)
                    }else{
                        //                          self.errorNotice(error.description)
                        hub.textLabel.text = error.description
                        hub.indicatorView = JGProgressHUDErrorIndicatorView()
                        hub.showInView(self.view, animated: true)
                        
                    }
                }
            }
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.hidden = false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    
    

}
