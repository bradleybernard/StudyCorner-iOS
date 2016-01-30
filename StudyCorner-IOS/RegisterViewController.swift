//
//  RegisterViewController.swift
//  StudyCorner-IOS
//
//  Created by Spencer Albrecht on 1/29/16.
//  Copyright © 2016 Brad Bernard. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var cruzID: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Register"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func completeEmail(sender: AnyObject) {
        email.text = cruzID.text!+"@ucsc.edu"
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
