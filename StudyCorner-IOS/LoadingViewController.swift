//
//  LoadingViewController.swift
//  StudyCorner-IOS
//
//  Created by Spencer Albrecht on 1/29/16.
//  Copyright © 2016 Brad Bernard. All rights reserved.
//

import UIKit
import PusherSwift

class LoadingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
        // Do any additional setup after loading the view.
        
        let pusher = Pusher(key: "afb83e6e44409f2b1b3b")
        pusher.connect()
        
        let myChannel = pusher.subscribe("user")
        
        myChannel.bind("register-event", callback: { (data: AnyObject?) -> Void in
            print("working")
        })
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
