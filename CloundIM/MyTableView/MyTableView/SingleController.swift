//
//  SingleController.swift
//  MyTableView
//
//  Created by Jason on 15/10/1.
//  Copyright © 2015年 KYLERUAN. All rights reserved.
//

import UIKit
protocol SingleControllerDelegate{
    func setVaction(str:String)
}

class SingleController: UIViewController {
    var text:String!{
        didSet{
            
        }
    }
    @IBOutlet weak var txtField: UITextField!
    var dateSource:SingleControllerDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
   

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func Done(sender: UIBarButtonItem) {
       
        if sender.tag == 1 {
            //cannel
        }else{
            //done
            
        }
    
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
