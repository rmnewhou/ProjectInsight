//
//  TaskControllers.swift
//  Proj Insight
//
//  Created by Mackenzie Kary on 2016-11-11.
//  Copyright © 2016 Mackenzie Kary. All rights reserved.
//

import Foundation
import UIKit
import ResearchKit

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
        taskListRow?.setTitle(input: titleTextField.text!)
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
class ScaleQuestion: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var detailsTextField: UITextField!
    @IBOutlet weak var leftDescriptor: UITextField!
    @IBOutlet weak var rightDescriptor: UITextField!
    @IBOutlet weak var minValue: UITextField!
    @IBOutlet weak var maxValue: UITextField!

    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func savePressed(_ sender: Any) {
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
        taskListRow?.setTitle(input: titleTextField.text!)
        taskListRow?.setDetailedDescription(input: detailsTextField.text!)
        taskListRow?.setLeftDescriptor(input: leftDescriptor.text!)
        taskListRow?.setRightDescriptor(input: rightDescriptor.text!)
        taskListRow?.setMinValue(input: minValue.text!)
        taskListRow?.setMaxValue(input: maxValue.text!)
        
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
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
class ConsentTask: UIViewController, UITextFieldDelegate {
    
    
    var consentDocument: [ORKConsentSection] = []
    var overviewSection = ORKConsentSection(type: .overview)
    var dataGatheringSection = ORKConsentSection(type: .dataGathering)
    var privacySection = ORKConsentSection(type: .privacy)
    var dataUseSection = ORKConsentSection(type: .dataUse)
    var timeCommitmentSection = ORKConsentSection (type: .timeCommitment)
    var studySurveySection = ORKConsentSection (type: .studySurvey)
    var studyTasksSection = ORKConsentSection (type: .studyTasks)
    var withdrawingSection = ORKConsentSection (type: .withdrawing)
    @IBOutlet weak var sectionOverviewLongtext: UITextView!
    @IBOutlet weak var sectionOverviewShorttext: UITextField!
    
    @IBAction func sectionOverviewNextClicked(_ sender: Any) {
       
        overviewSection.summary = sectionOverviewShorttext.text
        overviewSection.content = sectionOverviewLongtext.text
        
        performSegue(withIdentifier: "overviewToDataGatheringSegue", sender: self)

        
        
    }
   
    
    @IBOutlet weak var sectionDataGatheringShorttext: UITextField!
    
    
    @IBOutlet weak var sectionDataGatheringLongtext: UITextView!
    
    @IBAction func sectionDataGatheringNext(_ sender: Any) {
        
        dataGatheringSection.summary = sectionDataGatheringShorttext.text
        dataGatheringSection.content = sectionDataGatheringLongtext.text
        
    }
    
    @IBOutlet weak var sectionPrivacyShorttext: UITextField!
    
    @IBOutlet weak var sectionPrivacyLongtext: UITextView!
    
    
    @IBAction func sectionPrivacyNext(_ sender: Any) {
        
       privacySection.summary = sectionPrivacyShorttext.text
       privacySection.content = sectionPrivacyLongtext.text
        

    }
    
    @IBOutlet weak var sectionDataUseShorttext: UITextField!
    
    @IBOutlet weak var sectionDataUseLongtext: UITextView!
    
    @IBAction func sectionDataUseNext(_ sender: Any) {
        dataUseSection.summary = sectionDataUseShorttext.text
        dataUseSection.content = sectionDataUseLongtext.text
        

    }
    
    @IBOutlet weak var sectionTimeCommitShorttext: UITextField!
    
    
    @IBOutlet weak var sectionTimeCommitLongtext: UITextView!
    
    @IBAction func sectionTimeCommitNext(_ sender: Any) {
        
        timeCommitmentSection.summary = sectionTimeCommitShorttext.text
        timeCommitmentSection.content = sectionTimeCommitLongtext.text
        
    }
    
    @IBOutlet weak var sectionStudySurveyShorttext: UITextField!
    
    @IBOutlet weak var sectionStudySurveyLongtext: UITextView!
   
    @IBAction func sectionStudySurveyNext(_ sender: Any) {

        studySurveySection.summary = sectionStudySurveyShorttext.text
        studySurveySection.content = sectionStudySurveyLongtext.text
        

    }
    
    
    @IBOutlet weak var sectionStudyTaskShorttext: UITextField!
    
    @IBOutlet weak var sectionStudyTaskLongtext: UITextView!
    
    
    @IBAction func sectionStudyTaskNext(_ sender: Any) {
        
        studyTasksSection.summary = sectionStudyTaskShorttext.text
        print("\n\n CHECK:\n", studyTasksSection.summary)
        studyTasksSection.content = sectionStudyTaskLongtext.text
        

    }
    
    @IBOutlet weak var sectionWithdrawShorttext: UITextField!
    
    @IBOutlet weak var sectionWithdrawLongtext: UITextView!
    
    
    @IBAction func save(_ sender: Any) {
    
        print("\n\n CHECK:\n", studyTasksSection.summary)
        withdrawingSection.summary = sectionWithdrawShorttext.text
        withdrawingSection.content = sectionWithdrawLongtext.text
        
      
        
        let theDocument: ORKConsentDocument = ORKConsentDocument.init()
        
        
        theDocument.sections = [overviewSection,dataGatheringSection,privacySection,dataUseSection,timeCommitmentSection,
        studySurveySection,studyTasksSection,withdrawingSection]
        
        
        let sigInit  = ORKConsentSignature(forPersonWithTitle: nil, dateFormatString: nil, identifier: "ConsentDocumentParticipantSignature")
        
        
        
        theDocument.addSignature(sigInit)
        
        let consentStep = ORKVisualConsentStep(identifier: "VisualConsentStep", document: theDocument)
        
       
        
        let signature = theDocument.signatures!.first!
        
        let reviewConsentStep = ORKConsentReviewStep(identifier: "ConsentReviewStep", signature: signature, in: theDocument)
        
        reviewConsentStep.text = "Review the consent form."
        reviewConsentStep.reasonForConsent = "Consent to join the Study."
        reviewConsentStep.title = "Consent"
        
       
        
        let completionStep = ORKCompletionStep(identifier: "CompletionStep")
        completionStep.title = "Welcome aboard."
        completionStep.text = "Thank you for joining this study."
        
        let orderedTask = ORKOrderedTask(identifier: "Join", steps: [consentStep, reviewConsentStep, completionStep])
        
        
        
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
        
      
        let task = orderedTask
        
        
        let taskToStoreInArray = Task(name: name, photo: photo, type: type!, task: task)
        ActivitiesConnections.sharedInstance.studyCurrent?.addTask(taskToStoreInArray!) //Adding task to study arr
        
        
        NotificationCenter.default.post(name: .reload, object: nil) //Need this to update the tableview in taskbuilderViewController.swift
        
        
        taskListRow?.resetStrings() //This will return the strings to the "Example" strings if a preview is chosen
        
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController];
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 1], animated: true);
        
        performSegue(withIdentifier: "saveTaskSegue", sender: self)        
        
    }
    
    

    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


