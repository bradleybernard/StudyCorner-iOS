//
//  SessionViewController.swift
//  StudyCorner-IOS
//
//  Created by Aidan Gadberry on 1/30/16.
//  Copyright © 2016 Brad Bernard. All rights reserved.
//

import UIKit
import MapKit
import Alamofire

class SessionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    var session: SchoolSession!
    var user_id: String!
    var people = [String]()
    var status : Bool = false
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var goingLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var peopleTable: UITableView!
    
    @IBOutlet weak var statusButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statusButton.hidden = true
        
        self.updateButton()
        
        titleLabel.text = session.title
        detailsLabel.text = session.details
        timeLabel.text = session.time_start
        goingLabel.text = String(session.going_count)
        
        
        // set initial location in Honolulu
        let sessionPin = CLLocationCoordinate2DMake(session.latitude, session.longitude)
        
        let sessionLocation = CLLocation(latitude: session.latitude, longitude: session.longitude)
        
        centerMapOnLocation(sessionLocation)
        
        let dropPin = MKPointAnnotation()
        dropPin.coordinate = sessionPin
        dropPin.title = "Study Location"
        mapView.addAnnotation(dropPin)
        
        let parameters = [
            "user_id": self.user_id
        ]
        
        
        
        Alamofire.request(.POST,  "http://45.33.18.17/api/user/sessions/" + String(session.id)  , parameters: parameters)
            
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
                    print(post)
                    
                    print("what is post success? ")
                    print(post["success"].boolValue)
                    
                    // Conditional that checks if the user info has been
                    // properly stored in the datdabase
                    if post["success"].boolValue == true {
                        for (key, subJson) : (String, JSON) in post["users"] {
                            print(subJson["cruz_id"].stringValue)
                            self.people.append(subJson["cruz_id"].stringValue)
                        }
                        
                        self.status = post["signed_up"].boolValue
                        dispatch_async(dispatch_get_main_queue()) {
                            self.statusButton.hidden = false
                        }
                        self.goingLabel.text = String(post["users"].count)
                        self.statusButton.hidden = false
                        self.updateButton()
                        print("updated button")
                    }
                    else {
                        print("Error")
                    }
                    
                    self.peopleTable.reloadData()
                }
                
                
        }
    }
    
    func updateButton() {
        if(status) {
            statusButton.setTitle("Leave", forState: .Normal)
        }
        else
        {
            statusButton.setTitle("Join", forState: .Normal)
        }
    }
    
    func toggleStatus() {
        Alamofire.request(.POST, "http://45.33.18.17/api/user/session/changeStatus", parameters: [ "user_id" : user_id, "session_id" : session.id, "status" : (status ? 0 : 1)]).responseJSON { response in
            
            guard response.result.error == nil else {
                // got an error in getting the data, need to handle it
                print("error calling GET on /addUsers")
                print(response.result.error!)
                return
            }
            
            // Runs if we get a response from the server
            if let value: AnyObject = response.result.value {
                let post = JSON(value)
                print(post)
                
                // Conditional that checks if the user info has been
                // properly stored in the datdabase
                if post["success"].boolValue == true {
                    
                    self.status = !self.status
                    
                    if(self.status == true) {
                        self.people.append(post["cruz_id"].stringValue)
                        self.goingLabel.text = String(Int(self.goingLabel.text!)! + 1)
                    }
                    else
                    {
                        for var i = 0; i < self.people.count; ++i {
                            if(self.people[i] == post["cruz_id"].stringValue) {
                                self.people.removeAtIndex(i)
                            }
                        }
                        
                        self.goingLabel.text = String(Int(self.goingLabel.text!)! - 1)
                    }
                    
                    self.updateButton()
                    self.peopleTable.reloadData()
                }
                else {
                    print("Error")
                }
                
            }
            
        }

    }
    
    @IBAction func buttonPressed(sender: AnyObject) {
        //upda
        toggleStatus()
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:  PeopleTableViewCell = self.peopleTable.dequeueReusableCellWithIdentifier("PeopleTableViewCell") as! PeopleTableViewCell
        
        cell.nameLabel.text = people[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
    }
    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}
