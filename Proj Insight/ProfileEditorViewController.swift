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
    
    @IBOutlet weak var DOB: UIDatePicker!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var WeightText: UITextField!
    @IBOutlet weak var GenderText: UITextField!
    @IBOutlet weak var AgeText: UITextField!
    @IBOutlet weak var LastNameText: UITextField!
    @IBOutlet weak var FirstNameText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height+120)
        WeightText.delegate = self
        GenderText.delegate = self
        AgeText.delegate = self
        LastNameText.delegate = self
        FirstNameText.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
        return true
    }
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
        //Add First Name
        let userId = (FIRAuth.auth()!.currentUser?.uid)! as String
        let value1 = FirstNameText.text! as String
        if value1 != "" {
            ref.child("Users").child(userId).updateChildValues(["FirstName": value1])
        }
        
        //Add Last Name
        let value2 = LastNameText.text! as String
        if value2 != "" {
            ref.child("Users").child(userId).updateChildValues(["LastName": value2])
        }
        
        //Add Gender
        let value4 = GenderText.text! as String
        if value4 != "" {
            ref.child("Users").child(userId).updateChildValues(["Gender": value4])
        }
        
        //Add Age
        let value5 = AgeText.text! as String
        if value5 != "" {
            ref.child("Users").child(userId).updateChildValues(["Age": value5])
        }

        //Add Weight
        let value6 = WeightText.text! as String
        if value6 != "" {
            ref.child("Users").child(userId).updateChildValues(["Weight": value6])
        }

        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        var value3 = dateFormatter.string(from: DOB.date)
        ref.child("Users").child(userId).updateChildValues(["DOB": value3])
        

    }
 

}
