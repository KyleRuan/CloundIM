//
//  CommunicationListViewController.swift
//  CloundIM
//
//  Created by Jason on 15/7/15.
//  Copyright © 2015年 KYLERUAN. All rights reserved.
//

import UIKit

class CommunicationListViewController:RCConversationListViewController{
    private var transitionPoint: CGPoint!
    let conVC = CommunicationViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDel = UIApplication.sharedApplication().delegate as? AppDelegate
        appDel?.conenctServer({ () -> Void in
            let typeArr = [RCConversationType.ConversationType_APPSERVICE.rawValue,RCConversationType.ConversationType_CUSTOMERSERVICE.rawValue,RCConversationType.ConversationType_DISCUSSION.rawValue,RCConversationType.ConversationType_GROUP.rawValue,RCConversationType.ConversationType_PRIVATE.rawValue,RCConversationType.ConversationType_PUBLICSERVICE.rawValue,RCConversationType.ConversationType_SYSTEM.rawValue]
            
            self.setDisplayConversationTypes(typeArr)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.hidden = false
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
          self.tabBarController?.tabBar.hidden = true
        
        if let identifier = segue.identifier {
            switch identifier {
            case Constants.ChattingSegue:
                if let VC = segue.destinationViewController as? CommunicationViewController{
                    prepareViewController(VC)
                }
                
            default:
                break
            }
        }
    }
    

    
  private  func   prepareViewController(VC:CommunicationViewController){
        VC.targetId = conVC.targetId
        VC.userName = conVC.userName
        VC.conversationType =  conVC.conversationType
        VC.title = "和王心凌聊天"
        self.tabBarController?.tabBar.hidden = true
    }
    override func onSelectedTableRow(conversationModelType: RCConversationModelType, conversationModel model: RCConversationModel!, atIndexPath indexPath: NSIndexPath!) {
        conVC.targetId = model.targetId
        conVC.userName = model.senderUserName
        conVC.conversationType = model.conversationType
        conVC.title = "和王心凌聊天"
       performSegueWithIdentifier(Constants.ChattingSegue, sender: self)
      
        
    }
  
    struct Constants {
        static let ChattingSegue = "ChattingSegue"
        static let MenuSegue = "menusegue"
        static let contentStoryBoard = "ChattingWithFriends"
    }

}
