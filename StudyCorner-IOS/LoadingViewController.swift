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
    
    // Fields
    var user_id : String!

    override func viewDidLoad() {
        
        super.viewDidLoad()
    
        // Hides the nav bar
        self.navigationController?.navigationBarHidden = true
        
        // Connects to the pusher to communicate with the server
        let pusher = Pusher(key: "afb83e6e44409f2b1b3b")
        pusher.connect()
        
        // Subscribes to the channel based on the user_id sent
        // sent back from the server
        let myChannel = pusher.subscribe("user" + self.user_id)
        
        // Begins listening to an event from the server
        myChannel.bind("register", callback: { (data: AnyObject?) -> Void in
            
            print("working")
            print(JSON (data!))
            
            // Creates an array with SchoolClass objects by reading
            // through the JSON object sent by the server
            var json = JSON (data!)
            var classList = [SchoolClass]()
            print(json["message"])
            for (key,subJson):(String, JSON) in json["message"] {
                //Do something you want
                
                classList.append(SchoolClass(user_id: subJson["user_id"].stringValue, class_id: subJson["class_id"].stringValue,class_name: subJson["class_name"].stringValue, priority: subJson["priority"].boolValue))
            }
            
            // Changes view to the next page
            var priorityVC = self.storyboard?.instantiateViewControllerWithIdentifier("PriorityVC") as! PrioritiesViewController
            
            priorityVC.classList = classList
            
            self.navigationController?.pushViewController(priorityVC, animated: true)
        })
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
