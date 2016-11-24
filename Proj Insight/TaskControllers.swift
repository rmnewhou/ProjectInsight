//
//  TaskControllers.swift
//  Proj Insight
//
//  Created by Mackenzie Kary on 2016-11-11.
//  Copyright © 2016 Mackenzie Kary. All rights reserved.
//

import Foundation
import UIKit


class YesNoTask: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var descriptionTextField: UITextField!
    
    @IBOutlet weak var detailsTextField: UITextField!
    
    @IBAction func cancelButton(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func saveTaskButton(_ sender: AnyObject) {
        let taskListRow = ActivitiesConnections.sharedInstance.tempTaskListRow
 
        let name = "\(taskListRow!)"
        let type = taskListRow?.taskType
 
 
        var photo = #imageLiteral(resourceName: "activityIcon.png") //Set default photo to be the activtyIcon
        if (type == "Question"){
            photo  = #imageLiteral(resourceName: "questionMarkIcon.png")                           //questionMarkIcon.png
 
        }else if(type == "Onboarding"){
            photo = #imageLiteral(resourceName: "onBoardingIcon.png")                             //onBoardingIcon.png
        }else{
            photo = #imageLiteral(resourceName: "activityIcon.png")                             //activityIcon.png
        }
 
        //Assign the new text in this task to be the text of what was entered
        taskListRow?.setDescription(input: descriptionTextField.text!)
        taskListRow?.setDetailedDescription(input: detailsTextField.text!)
        let task = taskListRow?.representedTask      // Create a task from the `TaskListRow` to present in the `ORKTaskViewController`.


        let taskToStoreInArray = Task(name: name, photo: photo, type: type!, task: task!)
        ActivitiesConnections.sharedInstance.studyCurrent?.addTask(taskToStoreInArray!) //Adding task to study arr
 
 
        NotificationCenter.default.post(name: .reload, object: nil) //Need this to update the tableview in taskbuilderViewController.swift
 
        
        taskListRow?.resetStrings() //This will return the strings to the "Example" strings if a preview is chosen 
        
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController];
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 1], animated: true);
        

        performSegue(withIdentifier: "saveTaskSegue", sender: self)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionTextField.delegate = self
        detailsTextField.delegate = self
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

