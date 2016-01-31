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

class SessionViewController: UIViewController {

    var session: SchoolSession!
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var goingLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var peopleTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        }
    
        let regionRadius: CLLocationDistance = 1000
        func centerMapOnLocation(location: CLLocation) {
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                regionRadius * 2.0, regionRadius * 2.0)
            mapView.setRegion(coordinateRegion, animated: true)
        }
    
//        let parameters = [
//            "": ""
//        ]
//    
//        var url = "http://45.33.18.17/api/user/sessions/"
//        
//        Alamofire.request(.POST, url , parameters: parameters)
//            
//            .responseJSON { response in
//                
//                guard response.result.error == nil else {
//                    // got an error in getting the data, need to handle it
//                    print("error calling GET on /priority")
//                    print(response.result.error!)
//                    return
//                }
//                
//                // Runs if we get a response from the server
//                if let value: AnyObject = response.result.value {
//                    let post = JSON(value)
//                    
//                    // Conditional that checks if the user info has been
//                    // properly stored in the datdabase
//                    if post["success"].boolValue == true {
//                    }
//                    else {
//                        print("Error")
//                    }
//                }
//        }
}
