//
//  PrioritiesViewController.swift
//  StudyCorner-IOS
//
//  Created by Spencer Albrecht on 1/30/16.
//  Copyright © 2016 Brad Bernard. All rights reserved.
//

import UIKit

class PrioritiesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableInfoQuake: UITableView!
    
    var classList = [SchoolClass] ()
    
    @IBAction func prioritySwitch(sender: AnyObject) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableInfoQuake.dataSource = self
        tableInfoQuake.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) ->Int {
        return classList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //var cell:UITableViewCell = self.tableInfoQuake.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        //cell.textLabel?.text = self.classList[indexPath.row].user_id
        //cell.textLabel?.text = UIImage(named:self.classList[indexPath.row])
        
        //return cell
        let cell:TableViewCell = self.tableInfoQuake.dequeueReusableCellWithIdentifier("priorityCell") as! TableViewCell
        
        cell.className.text = classList[indexPath.row].class_name
        
        cell.prioritySwitch.on = classList[indexPath.row].priority
        
        return cell
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
