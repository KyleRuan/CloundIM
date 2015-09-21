//
//  CommunicationViewController.swift
//  CloundIM
//
//  Created by Jason on 15/7/11.
//  Copyright © 2015年 KYLERUAN. All rights reserved.
//

import UIKit



class CommunicationViewController: RCConversationViewController{
    override func viewDidLoad() {
        
        super.viewDidLoad()
  
        //设置聊天信息
//            self.targetId = RCIMClient.sharedRCIMClient().currentUserInfo.userId
//            self.userName = RCIMClient.sharedRCIMClient().currentUserInfo.name
//            self.conversationType = .ConversationType_PRIVATE
//            self.title = "与\(self.userName)聊天"
            self.setMessageAvatarStyle(RCUserAvatarStyle.USER_AVATAR_CYCLE)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
