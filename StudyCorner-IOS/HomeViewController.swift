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
        self.title = "Study Sessions"
        print("loaded home")
        self.getSessions()

        // Do any additional setup after loading the view.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) ->Int {
        return sessions.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:  HomePageCell = self.sessionsTableView.dequeueReusableCellWithIdentifier("HomePageCell") as! HomePageCell
        
        cell.time.text = sessions[indexPath.row].time_start
        cell.classTitle.text = sessions[indexPath.row].title
        cell.peopleCount.text = String(sessions[indexPath.row].going_count)
        cell.location.text = sessions[indexPath.row].location
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let sessionVC = self.storyboard?.instantiateViewControllerWithIdentifier("SessionViewController") as! SessionViewController
        sessionVC.session = sessions[indexPath.row]
        sessionVC.user_id = user_id
        self.navigationController?.pushViewController(sessionVC, animated: true)
    }
    
    func getSessions()
    {
        print("before request")
        
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
                        
                        let start_time = dateFormatter.dateFromString(subJson["time_start"].stringValue)!
                        let create_time = dateFormatter.dateFromString(subJson["created_at"].stringValue)!
                        let update_time = dateFormatter.dateFromString(subJson["updated_at"].stringValue)!
                        
                        dateFormatter.timeStyle = .ShortStyle
                        dateFormatter.dateStyle = .NoStyle
                        
                        let time_start = dateFormatter.stringFromDate(start_time)
                        let created_at = dateFormatter.stringFromDate(create_time)
                        let updated_at = dateFormatter.stringFromDate(update_time)
                        
                        self.sessions.append(
                            
                            SchoolSession(created_at: created_at, title: subJson["title"].stringValue, details: subJson["details"].stringValue, latitude: subJson["latitude"].doubleValue, location: subJson["location"].stringValue, owner_id: subJson["owner_id"].intValue, priority: subJson["priority"].boolValue, going_count: subJson["going_count"].intValue, time_start: time_start, id: subJson["study_id"].intValue, updated_at: updated_at, longitude: subJson["longitude"].doubleValue, user_id: subJson["user_id"].intValue, time_end: subJson["time_end"].stringValue, class_id: subJson["class_id"].intValue, class_name: subJson["class_name"].stringValue, status: subJson["status"].intValue)
                        )
                        
                        print(subJson["title"].stringValue)
                        
                    }
                    
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                        // do some task
                        dispatch_async(dispatch_get_main_queue(), {
                             self.sessionsTableView.reloadData()
                            print(self.sessions.count)
                            SwiftSpinner.hide()
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
