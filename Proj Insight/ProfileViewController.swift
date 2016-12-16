//
//  ProfileViewController.swift
//  Proj Insight
//
//  Created by Braden Woloschuk on 2016-12-15.
//  Copyright © 2016 Mackenzie Kary. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth



class ProfileViewController: UIViewController {
    
    let ref = FIRDatabase.database().reference()
    var FirstName : String = ""
    var LastName = ""
    var DOB = ""
    var Age = ""
    var Gender = ""
    
    @IBOutlet weak var FirstNameLabel: UILabel!
    @IBOutlet weak var EmailLabel: UILabel!
    
    @IBOutlet weak var LastNameLabel: UILabel!
    @IBOutlet weak var DOBlabel: UILabel!
    @IBOutlet weak var Agelabel: UILabel!
    @IBOutlet weak var Genderlabel: UILabel!
    
    @IBOutlet weak var AccountTypeLabel: UILabel!
    @IBOutlet weak var Weightlabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        labelSetup()
        retrieveInfo()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func retrieveInfo(){
        let userId = (FIRAuth.auth()!.currentUser?.uid)! as String
        ref.child("Users").child(userId).observe(.value, with:{ snapshot in
            let value = snapshot.value as? NSDictionary
            self.FirstNameLabel.text = value?["FirstName"] as? String ?? ""
            self.LastNameLabel.text = value?["LastName"] as? String ?? ""
            let age = value?["Age"] as? String ?? ""
            self.Agelabel.text = age + " y/o"
            self.DOBlabel.text = value?["DOB"] as? String ?? ""
            self.Genderlabel.text = value?["Gender"] as? String ?? ""
            let weight = value?["Weight"] as? String ?? ""
            self.Weightlabel.text = weight + " lbs"
            self.AccountTypeLabel.text = value?["AccountType"] as? String ?? ""
        })
        
        EmailLabel.text = FIRAuth.auth()?.currentUser?.email
    }
    
    func labelSetup(){
        DOBlabel.layer.borderWidth = 1.0
        DOBlabel.layer.borderColor = UIColor.gray.cgColor
        DOBlabel.layer.cornerRadius = 8.0
        
        Agelabel.layer.borderWidth = 1.0
        Agelabel.layer.borderColor = UIColor.gray.cgColor
        Agelabel.layer.cornerRadius = 8.0
        
        Genderlabel.layer.borderWidth = 1.0
        Genderlabel.layer.borderColor = UIColor.gray.cgColor
        Genderlabel.layer.cornerRadius = 8.0
        
        LastNameLabel.layer.borderWidth = 1.0
        LastNameLabel.layer.borderColor = UIColor.gray.cgColor
        LastNameLabel.layer.cornerRadius = 8.0
        
        Weightlabel.layer.borderWidth = 1.0
        Weightlabel.layer.borderColor = UIColor.gray.cgColor
        Weightlabel.layer.cornerRadius = 8.0
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
