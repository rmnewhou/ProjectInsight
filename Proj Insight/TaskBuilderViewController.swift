//
//  TaskBuilderViewController.swift
//  Proj Insight
//
//  Created by Mackenzie Kary on 2016-11-10.
//  Copyright © 2016 Mackenzie Kary. All rights reserved.
//

import UIKit
import ResearchKit

class TaskBuilderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ORKTaskViewControllerDelegate {
    
    var study = ActivitiesConnections.sharedInstance.studyCurrent
    var indexNumberOfStudy: Int = -1
    //var tempStudy = Study(name: "first")
    var taskResultFinishedCompletionHandler: ((ORKResult) -> Void)?
    
    let taskNotification = Notification.Name("on-task-selection")
    
    

    @IBAction func cancelButtonPressed(_ sender: AnyObject) {
        // Remove the tasks from the study's task array because the builder has been cancelled. 
       ActivitiesConnections.sharedInstance.studyCurrent = Study(name: "Start Over")
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonPressed(_ sender: AnyObject) {
        if (indexNumberOfStudy != -1){          //If we are just editing a previously made study
            ActivitiesConnections.sharedInstance.studyArr[indexNumberOfStudy] = ActivitiesConnections.sharedInstance.studyCurrent!
            indexNumberOfStudy = -1
            
        }else{                                  //If we are adding a brand new study. Append to back of array
//            ActivitiesConnections.sharedInstance.studyArr.append((ActivitiesConnections.sharedInstance.studyCurrent)!)
            
            let alertController = UIAlertController(title: "Study Name", message: "Please input a name for your study:", preferredStyle: .alert)
            
            let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (_) in
                if let field = alertController.textFields?[0] {
                    // store your data
                    UserDefaults.standard.set(field.text, forKey: "studyName")
                    UserDefaults.standard.synchronize()
                    ActivitiesConnections.sharedInstance.studyCurrent?.name = field.text!
                    
                    NotificationCenter.default.post(name: .reload, object: nil)
                    
                    ActivitiesConnections.sharedInstance.studyArr.append((ActivitiesConnections.sharedInstance.studyCurrent)!)

                    NotificationCenter.default.post(name: .reload, object: nil)
                    ActivitiesConnections.sharedInstance.studyCurrent = Study(name: "Start Over")
                    self.dismiss(animated: true, completion: nil)
                    
                } else {
                    // user did not fill field
                }
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
            
            alertController.addTextField { (textField) in
                textField.placeholder = "Study name"
            }
            
            alertController.addAction(confirmAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        }
    
 
        
        NotificationCenter.default.post(name: .reload, object: nil)
        
        //self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func unwindToTaskBuilder(_ sender: UIStoryboardSegue) {
        
    }

    @IBOutlet weak var taskTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        study = ActivitiesConnections.sharedInstance.studyCurrent
        //indexNumberOfStudy
        

        taskTableView.backgroundColor = UIColor.clear

        // Do any additional setup after loading the view.
        
        self.taskTableView.delegate = self
        self.taskTableView.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableData(_:)), name: .reload, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20.0
    }
    
    // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    
    
    func reloadTableData(_ notification: Notification) {
        taskTableView.reloadData()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return (study?.getTasks().count)!+1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //
        return 1
    }
    
    
    enum TableViewCellIdentifier: String {
        case `default` = "Default"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "addTaskCell")
            
            //set the data here
            cell.textLabel?.text = "Add New Task"
            cell.textLabel?.textAlignment = .center
            cell.backgroundColor = UIColor(red: 0/255, green: 184/255, blue: 142/255, alpha: 1.0)
            cell.textLabel?.textColor = UIColor.white
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)

            return cell
        }
        else {
            //let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "builderTableView")
            let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskCell

            // Make if statments or anything to make sure that the indexPath.section-1 is not out of range. This crashes. 
            let taskArray = study?.getTasks()  //Get
            
            let taskName = taskArray?[indexPath.section-1].name    //Get the name of the activity/task
            let taskPhoto = taskArray?[indexPath.section-1].photo
            let taskType = taskArray?[indexPath.section-1].type

            
            
            cell.taskLabel.text = taskName
            cell.taskLabel?.textColor = UIColor.white
            cell.taskImage.image = taskPhoto
            cell.taskTypeLabel.text = taskType
            cell.taskTypeLabel?.textColor = UIColor.white
            
            
            cell.layer.cornerRadius=3.0 //set corner radius here
            cell.backgroundColor = UIColor(red: 0/255, green: 150/255, blue: 150/255, alpha: 1.0)
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.borderWidth = 1.0 // set border width here
            
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        if indexPath.section == 0 {
            performSegue(withIdentifier: "addTaskSegue", sender: self)
        }
        else{
            // Present the task view controller that the user asked for.
            let taskListRow = ActivitiesConnections.sharedInstance.studyCurrent?.getTasks()[indexPath.section-1].task
            
            
            // Create the taskViewControlled based on the task that we have stored in our studyCurrent array.
            let taskViewController = ORKTaskViewController(task: taskListRow, taskRun: nil)
            taskViewController.delegate = self
            // Assign a directory to store `taskViewController` output.
            taskViewController.outputDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            
            present(taskViewController, animated: true, completion: nil)
        }
        
    }
    //This code was taken from the TaskListRowController. It is incharge of determining the state when a task is finished.
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        /*
         The `reason` passed to this method indicates why the task view
         controller finished: Did the user cancel, save, or actually complete
         the task; or was there an error?
         
         The actual result of the task is on the `result` property of the task
         view controller.
         */
        taskResultFinishedCompletionHandler?(taskViewController.result)
        
        //Get results 
        
        //taskViewController.result.res
        taskViewController.dismiss(animated: true, completion: nil)
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
extension Notification.Name {
    static let reload = Notification.Name("reload")
}
