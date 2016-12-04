//
//  TaskControllers.swift
//  Proj Insight
//
//  Created by Mackenzie Kary on 2016-11-11.
//  Copyright © 2016 Mackenzie Kary. All rights reserved.
//

import Foundation
import UIKit

// Yes or no question
class TitleDescriptionView: UIViewController, UITextFieldDelegate {
    
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
        taskListRow?.setTitle(input: descriptionTextField.text!)
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
// Date picker question
class PlaceholderUnits: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var detailsTextField: UITextField!
    @IBOutlet weak var placeholderTextField: UITextField!
    @IBOutlet weak var unitsTextField: UITextField!
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func saveTaskButton(_ sender: Any) {
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
        taskListRow?.setTitle(input: detailsTextField.text!)
        taskListRow?.setDetailedDescription(input: detailsTextField.text!)
        taskListRow?.setUnitPlaceholder(input: placeholderTextField.text!)
        taskListRow?.setUnitText(input: unitsTextField.text!)
        
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
        titleTextField.delegate = self
        detailsTextField.delegate = self
        placeholderTextField.delegate = self
        unitsTextField.delegate = self
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
// Multiple choices questions
class MultipleChoices: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var detailsTextField: UITextField!
    @IBOutlet weak var choice1: UITextField!
    @IBOutlet weak var choice2: UITextField!
    @IBOutlet weak var choice3: UITextField!
    @IBOutlet weak var choice4: UITextField!
    
    
    
    @IBAction func saveTaskButton(_ sender: Any) {
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
        var choicesEntered = [String]()
        taskListRow?.setTitle(input: titleTextField.text!)
        taskListRow?.setDetailedDescription(input: detailsTextField.text!)
        
        if choice1.text! != ""{
            choicesEntered.append(choice1.text!)}
        if choice2.text! != ""{
            choicesEntered.append(choice2.text!)}
        if choice3.text! != ""{
            choicesEntered.append(choice3.text!)}
        if choice4.text! != ""{
            choicesEntered.append(choice4.text!)}
        
        
        taskListRow?.setChoicesArray(input: choicesEntered)

        
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
        titleTextField.delegate = self
        detailsTextField.delegate = self
        choice1.delegate = self
        choice2.delegate = self
        choice3.delegate = self
        choice4.delegate = self
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
