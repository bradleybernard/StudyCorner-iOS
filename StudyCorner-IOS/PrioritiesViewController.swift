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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableInfoQuake.dataSource = self
        tableInfoQuake.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) ->Int {
        return classList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->   UITableViewCell {
        let cell = UITableViewCell()
        let label = UILabel(frame: CGRect(x:0, y:0, width:200, height:50))
        label.text = "Hello Man"
        cell.addSubview(label)
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
