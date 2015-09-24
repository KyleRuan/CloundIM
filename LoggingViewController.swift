//
//  LoggingViewController.swift
//  CloundIM
//
//  Created by Jason on 15/9/22.
//  Copyright © 2015年 KYLERUAN. All rights reserved.
//

import UIKit
import JSAnimatedImagesView


class LoggingViewController: UIViewController,JSAnimatedImagesViewDataSource {
    @IBOutlet weak var LogInStackView: UIStackView!

  
    @IBOutlet weak var WallPaper: JSAnimatedImagesView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.WallPaper.dataSource = self
 
        
    }
 
    func animatedImagesNumberOfImages(animatedImagesView: JSAnimatedImagesView!) -> UInt {
        return 3
    }
    
    func animatedImagesView(animatedImagesView: JSAnimatedImagesView!, imageAtIndex index: UInt) -> UIImage! {
        return UIImage(named: "logInBackground\(index + 1)")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.hidden = true
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
