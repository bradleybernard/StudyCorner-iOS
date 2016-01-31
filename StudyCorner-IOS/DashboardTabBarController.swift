//
//  DashboardTabBarController.swift
//  StudyCorner-IOS
//
//  Created by Spencer Albrecht on 1/30/16.
//  Copyright © 2016 Brad Bernard. All rights reserved.
//

import UIKit

class DashboardTabBarController: UITabBarController {

    var user_id : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeVC : HomeNavigationViewController = self.viewControllers![0] as! HomeNavigationViewController
       // homeVC.user_id = user_id
         homeVC.user_id = "1"
        
        let addVC : AddViewController = self.viewControllers![1] as! AddViewController
        //addVC.user_id = user_id
        addVC.user_id = "1"
        // Do any additional setup after loading the view.
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
