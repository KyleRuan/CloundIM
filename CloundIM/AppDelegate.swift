//
//  AppDelegate.swift
//  CloundIM
//
//  Created by Jason on 15/7/6.
//  Copyright © 2015年 KYLERUAN. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate , RCIMUserInfoDataSource{

    var window: UIWindow?
    
    func getUserInfoWithUserId(userId: String!, completion: ((RCUserInfo!) -> Void)!) {
        let userInfo = RCUserInfo()
        userInfo.userId = userId
        
        
        //这个userId是从服务器中获取的
        switch userId {
            case "kyle":
            userInfo.name = "ruankai"
            userInfo.portraitUri = "http://www.xiaoboswift.com/2.jpg"
        default:
            userInfo.name = "ruankai"
            userInfo.portraitUri = "http://www.xiaoboswift.com/2.jpg"

        }
    
        return completion(userInfo)
    }
    func conenctServer(completion :()->Void){
        //初始化AppKey
        RCIM.sharedRCIM().initWithAppKey("82hegw5uh9zbx")
        
        
        RCIM.sharedRCIM().connectWithToken("1kOoOKIDrI3cNJKQMqXwOyt/ZfhgyVszzCloGFeufKTVwmBpQewFzfqFRBTEEapAUxyLz8mkX//DxlSZwR3EUQ==", success: { (success) -> Void in
         
            RCIMClient.sharedRCIMClient().currentUserInfo = RCUserInfo(userId: "kyle", name: "ruankai", portrait: "")
            
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                completion()
            })
            
            }, error: { (error) -> Void in
                print("error")
            }) { () -> Void in
                //token 不正确的时候
                print("token 不正确")
        }

    }

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        //设置用户信息数据提供者为自己
        RCIM.sharedRCIM().userInfoDataSource = self
              return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

