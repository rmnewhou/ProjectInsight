//
//  ProfileEditorViewController.swift
//  Proj Insight
//
//  Created by Braden Woloschuk on 2016-12-15.
//  Copyright © 2016 Mackenzie Kary. All rights reserved.
//

import UIKit
import Firebase


class ProfileEditorViewController: UIViewController, UITextFieldDelegate {
    let ref = FIRDatabase.database().reference()
    
    @IBOutlet weak var WeightText: UITextField!
    @IBOutlet weak var GenderText: UITextField!
    @IBOutlet weak var AgeText: UITextField!
    @IBOutlet weak var LastNameText: UITextField!
    @IBOutlet weak var FirstNameText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        WeightText.delegate = self
        GenderText.delegate = self
        AgeText.delegate = self
        LastNameText.delegate = self
        FirstNameText.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func FirstNameEntered(_ sender: UITextField) {
        let userId = (FIRAuth.auth()!.currentUser?.uid)! as String
        let value = sender.text! as String
        ref.child("Users").child(userId).updateChildValues(["FirstName": value])
        
        
       let alert = UIAlertController(title: "First Name Edit", message: "First Name Successfully Changed!", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
       self.present(alert, animated: true, completion: nil)
    
       // FirstNameText.resignFirstResponder()
    
    }
    
    func LastNameEntered(_ sender: UITextField) {
        let userId = (FIRAuth.auth()!.currentUser?.uid)! as String
        let value = sender.text! as String
        ref.child("Users").child(userId).updateChildValues(["LastName": value])
        let alert = UIAlertController(title: "Last Name Edit", message: "Surname Name Successfully Changed!", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func DOBPicker(_ sender: UIDatePicker) {
        let userId = (FIRAuth.auth()!.currentUser?.uid)! as String
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        var value = dateFormatter.string(from: sender.date)
        ref.child("Users").child(userId).updateChildValues(["DOB": value])
    }
    
 func AgeEntered(_ sender: UITextField) {
        let userId = (FIRAuth.auth()!.currentUser?.uid)! as String
        let value = sender.text! as String
        ref.child("Users").child(userId).updateChildValues(["Age": value])
        let alert = UIAlertController(title: "Age Edit", message: "Age Successfully Changed!", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
  func GenderEntered(_ sender: UITextField) {
        let userId = (FIRAuth.auth()!.currentUser?.uid)! as String
        let value = sender.text! as String
        ref.child("Users").child(userId).updateChildValues(["Gender": value])
        let alert = UIAlertController(title: "Gender Edit", message: "Gender Successfully Changed!", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
  func WeightEntered(_ sender: UITextField) {
        let userId = (FIRAuth.auth()!.currentUser?.uid)! as String
        let value = sender.text! as String
        ref.child("Users").child(userId).updateChildValues(["Weight": value])
        let alert = UIAlertController(title: "Weight Edit", message: "Weight Successfully Changed!", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        switch(textField){
        case FirstNameText:
            FirstNameEntered(textField)
            break
        case LastNameText:
            LastNameEntered(textField)
            break
        case AgeText:
            AgeEntered(textField)
            break
        case GenderText:
            GenderEntered(textField)
        case WeightText:
            WeightEntered(textField)
        default: break
            
        }
        
        return true
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
