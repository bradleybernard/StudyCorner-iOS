//
//  AddViewController.swift
//  StudyCorner-IOS
//
//  Created by Spencer Albrecht on 1/31/16.
//  Copyright © 2016 Brad Bernard. All rights reserved.
//

import UIKit
import MapKit
import Alamofire

class AddViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    
    @IBOutlet weak var locationText: UITextField!
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var detailsText: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var classPicker: UIPickerView!
    @IBOutlet weak var map: MKMapView!
    
    @IBOutlet weak var createButton: UIButton!
    
    var pickerData = [String]()
    var classData = [String]()
    var user_id : String!
    var longitude = ""
    var latitude = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getClasses()
        classPicker.dataSource = self
        classPicker.delegate = self
        let	 uilgr = UILongPressGestureRecognizer(target: self, action: "addAnnotation:")
        uilgr.minimumPressDuration = 2.0
        map.addGestureRecognizer(uilgr)
        
//        let userLocation = map.userLocation
//        
//        let region = MKCoordinateRegionMakeWithDistance(
//            userLocation.location!.coordinate, 2000, 2000)
//        
//        map.setRegion(region, animated: true)
        // Do any additional setup after loading the view.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?	 {
        return pickerData[row]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getClasses(){
        Alamofire.request(.POST,  "http://45.33.18.17/api/user/session/checkClass" , parameters: ["user_id" : user_id])
            
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
                        for (key, subJson) : (String, JSON) in post["classes"] {
                            self.pickerData.append(subJson["class_name"].stringValue)
                            self.classData.append(subJson["class_id"].stringValue)
                        }
                        print(self.classData)
                        print(self.pickerData)
                        print(self.pickerData.count)
                        self.classPicker.reloadAllComponents()
                    }
                    else {
                        print("Error")
                    }
                    
                }
                
                
        }
    }
    
    func submitSession(){
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        
        
        var params = [
            "owner_id": user_id,
            "title": titleText.text,
            "class_id": classData[classPicker.selectedRowInComponent(0)],
            "location": locationText.text,
            "latitude": latitude,
            "longitude": longitude,
            "details": detailsText.text,
            "time_start": dateFormatter.stringFromDate(datePicker.date),
            "status": "1",
            
        ]
        
        
        Alamofire.request(.POST,  "http://45.33.18.17/api/user/createSession" , parameters: params)
            
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
                    }
                    else {
                        print("Error")
                    }
                    
                }
                
                
        }
    }
    
    @IBAction func createPressed(sender: AnyObject) {
        submitSession()
    }
    
    func addAnnotation(gestureRecognizer:UIGestureRecognizer){
        var touchPoint = gestureRecognizer.locationInView(map)
        var newCoordinates = map.convertPoint(touchPoint, toCoordinateFromView: map)
        print(newCoordinates)
        longitude = "\(newCoordinates.longitude)"
        latitude = "\(newCoordinates.latitude)"
        print (longitude)
        print (latitude)
        let annotation = MKPointAnnotation()
        annotation.coordinate = newCoordinates
        map.addAnnotation(annotation)
        
    }
    
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        let location = locations.last as! CLLocation
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.map.setRegion(region, animated: true)
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
