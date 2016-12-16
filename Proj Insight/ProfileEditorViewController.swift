//
//  ProfileEditorViewController.swift
//  Proj Insight
//
//  Created by Braden Woloschuk on 2016-12-15.
//  Copyright © 2016 Mackenzie Kary. All rights reserved.
//

import UIKit
import Firebase


class ProfileEditorViewController: UIViewController {
    let ref = FIRDatabase.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func FirstNameEntered(_ sender: UITextField) {
        let userId = (FIRAuth.auth()!.currentUser?.uid)! as String
        let value = sender.text! as String
        ref.child("Users").child(userId).updateChildValues(["FirstName": value])
        sender.text = ""
    }

    @IBAction func LastNameEntered(_ sender: UITextField) {
        let userId = (FIRAuth.auth()!.currentUser?.uid)! as String
        let value = sender.text! as String
        ref.child("Users").child(userId).updateChildValues(["LastName": value])
        sender.text = ""
    }
    @IBAction func DOBPicker(_ sender: UIDatePicker) {
        let userId = (FIRAuth.auth()!.currentUser?.uid)! as String
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        var value = dateFormatter.string(from: sender.date)
        ref.child("Users").child(userId).updateChildValues(["DOB": value])
    }

    @IBAction func AgeEntered(_ sender: UITextField) {
        let userId = (FIRAuth.auth()!.currentUser?.uid)! as String
        let value = sender.text! as String
        ref.child("Users").child(userId).updateChildValues(["Age": value])
        sender.text = ""
    }
    @IBAction func GenderEntered(_ sender: UITextField) {
        let userId = (FIRAuth.auth()!.currentUser?.uid)! as String
        let value = sender.text! as String
        ref.child("Users").child(userId).updateChildValues(["Gender": value])
        sender.text = ""
    }
    @IBAction func WeightEntered(_ sender: UITextField) {
        let userId = (FIRAuth.auth()!.currentUser?.uid)! as String
        let value = sender.text! as String
        ref.child("Users").child(userId).updateChildValues(["Weight": value])
        sender.text = ""
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
