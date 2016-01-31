//
//  HomeViewController.swift
//  StudyCorner-IOS
//
//  Created by Spencer Albrecht on 1/30/16.
//  Copyright © 2016 Brad Bernard. All rights reserved.
//

import UIKit
import Alamofire
import SwiftSpinner

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var sessionsTableView: UITableView!
    
    var sessions = [SchoolSession]()
    var user_id : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("loaded home")
        self.getSessions()

        // Do any additional setup after loading the view.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) ->Int {
        return sessions.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:  HomePageCell = self.sessionsTableView.dequeueReusableCellWithIdentifier("HomePageCell") as! HomePageCell
        
        cell.time.text = sessions[indexPath.row].time
        cell.classTitle.text = sessions[indexPath.row].title
        cell.peopleCount.text = String(sessions[indexPath.row].people)
        cell.location.text = sessions[indexPath.row].location
        
        return cell
    }
    
    func getSessions()
    {
        print("before request")
//        var json = JSON (data!)
//        var classList = [SchoolClass]()
//        print(json["message"])
//        for (key,subJson):(String, JSON) in json["message"] {
//            //Do something you want
//            
//            classList.append(SchoolClass(user_id: subJson["user_id"].stringValue, class_id: subJson["class_id"].stringValue,class_name: subJson["class_name"].stringValue, priority: subJson["priority"].boolValue))
//        }
//        
//        // Changes view to the next page
//        var priorityVC = self.storyboard?.instantiateViewControllerWithIdentifier("PriorityVC") as! PrioritiesViewController
//        
//        priorityVC.classList = classList
//        
//        SwiftSpinner.hide()

        
        let parameters = [
            "user_id": user_id,
        ]
        
        SwiftSpinner.show("Retrieving your study sessions", animated: true)
        
        Alamofire.request(.POST, "http://45.33.18.17/api/user/sessions", parameters: parameters)
            
            // Reads the response from the server after post
            .responseJSON { response in
                
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    print("error calling GET on /posts/1")
                    print(response.result.error!)
                    return
                }
                
                // Runs if we get a response from the server
                if let value: AnyObject = response.result.value {
                    
                    let post = JSON(value)
                    
                    print("in success")
                    print(post)
                    
                    let dateFormatter = NSDateFormatter()
                    
                    
                    
                    for (key, subJson) : (String, JSON) in post {
                        
                        print(key)
                        print(subJson)
                        
                        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                        
                        let adate = dateFormatter.dateFromString(subJson["time_start"].stringValue)!
                        
                        dateFormatter.timeStyle = .ShortStyle
                        dateFormatter.dateStyle = .NoStyle
                        
                        let time_start = dateFormatter.stringFromDate(adate)
                        
//                        if let datePublished = dateFormatter.dateFromString(subJson["start_time"].stringValue) {
                            //println(datePublished)   // "2015-06-30 17:30:36 +0000" dateFormatter.stringFromDate(datePublished)
                            self.sessions.append(
                                SchoolSession(title: subJson["title"].stringValue, location: subJson["location"].stringValue, time: time_start, people: subJson["going_count"].intValue)
                            )
                            
                            print(subJson["title"].stringValue)
//                        }
                        
                    }
                    
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                        // do some task
                        dispatch_async(dispatch_get_main_queue(), {
                             self.sessionsTableView.reloadData()
                            print(self.sessions.count)
                            });
                        });
                    
                    
                    print("after reload data")
                }
        }
        print("after request")
    }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return 50
//    }
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
