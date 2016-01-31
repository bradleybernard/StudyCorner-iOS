//
//  PrioritiesViewController.swift
//  StudyCorner-IOS
//
//  Created by Spencer Albrecht on 1/30/16.
//  Copyright © 2016 Brad Bernard. All rights reserved.
//

import UIKit
import Alamofire

class PrioritiesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableInfoQuake: UITableView!
    
    var classList = [SchoolClass] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableInfoQuake.dataSource = self
        tableInfoQuake.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) ->Int {
        return classList.count
    }
    
    @IBAction func submitPress(sender: AnyObject) {
        
        var dicts = [Dictionary<String, String>]()
        
        
        for sclass in classList {
            dicts.append([
                "class_id" : sclass.class_id,
                "user_id"   : sclass.user_id,
                "priority" : sclass.priority ? "1" : "0"
                
            ])
        }
        
        print(dicts)
    
        
        let parameters = [
            "classes": dicts
        ]
        
        print(parameters)
        print(" ")
        
        Alamofire.request(.POST, "http://45.33.18.17/api/user/priority", parameters: parameters)
            
            .responseString { response in
                print("Success: \(response.result.isSuccess)")
                print("Response String: \(response.result.value)")
            }
            
            .responseJSON { response in
                
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    print("error calling GET on /priority")
                    print(response.result.error!)
                    return
                }
                
                // Runs if we get a response from the server
                if let value: AnyObject = response.result.value {
                    let post = JSON(value)
                    
                    // Conditional that checks if the user info has been
                    // properly stored in the datdabase
                    if post["success"].boolValue == true {
                        
                        print(post)
                        
                       print("yay")
                        
                    }
                    else {
                        print("Error")
                    }
                }
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //var cell:UITableViewCell = self.tableInfoQuake.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        //cell.textLabel?.text = self.classList[indexPath.row].user_id
        //cell.textLabel?.text = UIImage(named:self.classList[indexPath.row])
        
        //return cell
        let cell:TableViewCell = self.tableInfoQuake.dequeueReusableCellWithIdentifier("priorityCell") as! TableViewCell
        
        cell.className.text = classList[indexPath.row].class_name
        
        cell.prioritySwitch.on = classList[indexPath.row].priority
        
        cell.switchCallback = { [weak self] (switchIsOn) in
            self?.setSwitchValue(switchIsOn, forRowAtIndexPath:indexPath)
            Void()
        }
        
        
        return cell
    }
    
    private func setSwitchValue(switchIsOn: Bool, forRowAtIndexPath indexPath: NSIndexPath) {
        classList[indexPath.row].priority = switchIsOn
    }
    
    // UITableViewDelegate Functions
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
