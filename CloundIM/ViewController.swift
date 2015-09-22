//
//  CommunicationListViewController.swift
//  CloundIM
//
//  Created by Jason on 15/7/15.
//  Copyright © 2015年 KYLERUAN. All rights reserved.


import UIKit
import KxMenu

class ViewController: UIViewController,MenuViewControllerDelegate {

      private var selectedIndex = 0
   private var transitionPoint: CGPoint!
    private var navigator: UINavigationController!
    
    override func viewDidLoad() {
        self.navigator = UINavigationController()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch (segue.identifier, segue.destinationViewController) {
        case (.Some("menusegue"), let menu as MenuViewController):
            menu.selectedItem = selectedIndex
            menu.delegate = self
        case (.Some("embedNavigator"), let navigator as UINavigationController):
                self.navigator = navigator
        default:
            super.prepareForSegue(segue, sender: sender)
        }
    }
    
    func menu(_: MenuViewController, didSelectItemAtIndex index: Int, atPoint point: CGPoint) {
        transitionPoint = point
        selectedIndex = index
        //        //这里处理选中菜单
        //                let content = storyboard!.instantiateViewControllerWithIdentifier("Content")      as! ContentViewController
        //
        //        self.navigationController?.pushViewController(content, animated: true)
        //
        //        self.navigator.setViewControllers([content], animated: true)
        
        dispatch_async(dispatch_get_main_queue()) {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func menuDidCancel(_: MenuViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func addItems(sender: UIBarButtonItem) {
        var frame = sender.valueForKey("view")?.frame
        frame?.origin.y = (frame?.origin.y)! + 30
        let items:[KxMenuItem] = [KxMenuItem.init("扫一扫", image: UIImage(named: "star"), target: self, action: "QRCode")]
        KxMenu.showMenuInView(self.view, fromRect:frame! , menuItems: items)
        
    }
    
    
    
    func QRCode(){
        print("扫一扫")
    }
    
}

