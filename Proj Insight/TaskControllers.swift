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
    
    static var consentDocument: [ORKConsentSection] = []
    static var overviewSection = ORKConsentSection(type: .overview)
    static var dataGatheringSection = ORKConsentSection(type: .dataGathering)
    static var privacySection = ORKConsentSection(type: .privacy)
    static var dataUseSection = ORKConsentSection(type: .dataUse)
    static var timeCommitmentSection = ORKConsentSection (type: .timeCommitment)
    static var studySurveySection = ORKConsentSection (type: .studySurvey)
    static var studyTasksSection = ORKConsentSection (type: .studyTasks)
    static var withdrawingSection = ORKConsentSection (type: .withdrawing)
    @IBOutlet weak var sectionOverviewLongtext: UITextView!
    @IBOutlet weak var sectionOverviewShorttext: UITextField!
    
    
    
    @IBAction func sectionOverviewNextClicked(_ sender: Any) {
       
        ConsentTask.overviewSection.summary = sectionOverviewShorttext.text
        ConsentTask.overviewSection.content = sectionOverviewLongtext.text
        performSegue(withIdentifier: "OverviewNextSegue", sender: self)
    }
   
    
    @IBOutlet weak var sectionDataGatheringShorttext: UITextField!
    
    
    @IBOutlet weak var sectionDataGatheringLongtext: UITextView!
    
    @IBAction func sectionDataGatheringNext(_ sender: Any) {
        ConsentTask.dataGatheringSection.summary = sectionDataGatheringShorttext.text
        ConsentTask.dataGatheringSection.content = sectionDataGatheringLongtext.text
        performSegue(withIdentifier: "DataGatheringNextSegue", sender: self)
    }
    
    @IBOutlet weak var sectionPrivacyShorttext: UITextField!
    
    @IBOutlet weak var sectionPrivacyLongtext: UITextView!
    
    
    @IBAction func sectionPrivacyNext(_ sender: Any) {
        
        ConsentTask.privacySection.summary = sectionPrivacyShorttext.text
        ConsentTask.privacySection.content = sectionPrivacyLongtext.text
        performSegue(withIdentifier: "PrivacyNextSegue", sender: self)
    }
    
    @IBOutlet weak var sectionDataUseShorttext: UITextField!
    
    @IBOutlet weak var sectionDataUseLongtext: UITextView!
    
    @IBAction func sectionDataUseNext(_ sender: Any) {
        ConsentTask.dataUseSection.summary = sectionDataUseShorttext.text
        ConsentTask.dataUseSection.content = sectionDataUseLongtext.text
        performSegue(withIdentifier: "DataUseNextSegue", sender: self)
    }
    
    @IBOutlet weak var sectionTimeCommitShorttext: UITextField!
    
    
    @IBOutlet weak var sectionTimeCommitLongtext: UITextView!
    
    @IBAction func sectionTimeCommitNext(_ sender: Any) {
        
        ConsentTask.timeCommitmentSection.summary = sectionTimeCommitShorttext.text
        ConsentTask.timeCommitmentSection.content = sectionTimeCommitLongtext.text
        performSegue(withIdentifier: "TimeCommitmentNextSegue", sender: self)
    }
    
    @IBOutlet weak var sectionStudySurveyShorttext: UITextField!
    
    @IBOutlet weak var sectionStudySurveyLongtext: UITextView!
   
    @IBAction func sectionStudySurveyNext(_ sender: Any) {

        ConsentTask.studySurveySection.summary = sectionStudySurveyShorttext.text
        ConsentTask.studySurveySection.content = sectionStudySurveyLongtext.text
        performSegue(withIdentifier: "StudySurveyNextSegue", sender: self)
    }
    
    
    @IBOutlet weak var sectionStudyTaskShorttext: UITextField!
    
    @IBOutlet weak var sectionStudyTaskLongtext: UITextView!
    
    
    @IBAction func sectionStudyTaskNext(_ sender: Any) {
        
        ConsentTask.studyTasksSection.summary = sectionStudyTaskShorttext.text
        ConsentTask.studyTasksSection.content = sectionStudyTaskLongtext.text
        performSegue(withIdentifier: "StudyTasksNextSegue", sender: self)
    }
    
    @IBOutlet weak var sectionWithdrawShorttext: UITextField!
    
    @IBOutlet weak var sectionWithdrawLongtext: UITextView!
    
    
    @IBAction func save(_ sender: Any) {
    
        ConsentTask.withdrawingSection.summary = sectionWithdrawShorttext.text
        ConsentTask.withdrawingSection.content = sectionWithdrawLongtext.text
        
      
        
        let theDocument: ORKConsentDocument = ORKConsentDocument.init()
        
        
        theDocument.sections = [ConsentTask.overviewSection,ConsentTask.dataGatheringSection,ConsentTask.privacySection,ConsentTask.dataUseSection,ConsentTask.timeCommitmentSection,
        ConsentTask.studySurveySection,ConsentTask.studyTasksSection,ConsentTask.withdrawingSection]
        
        
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


