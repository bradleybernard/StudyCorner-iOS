//
//  LandingViewController.swift
//  StudyCorner-IOS
//
//  Created by Aidan Gadberry on 1/29/16.
//  Copyright © 2016 Brad Bernard. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func loginPressed(sender: AnyObject) {
        print("test")
    }
    
    @IBAction func registerPressed(sender: AnyObject) {
        print("reg")
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
