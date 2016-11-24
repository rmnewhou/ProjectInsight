//
//  TaskBuilderTableViewController.swift
//  Proj Insight
//
//  Created by Mackenzie Kary on 2016-11-07.
//  Copyright © 2016 Mackenzie Kary. All rights reserved.
//
/*
import UIKit
import ResearchKit

class TaskBuilderTableViewController: UITableViewController, ORKTaskViewControllerDelegate {
    
    @IBAction func saveButtonPressed(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil) // Normally, this will add the study to the My studies table view controller
    }
    
    @IBAction func cancelButton(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    var study = ActivitiesConnections.sharedInstance.studyCurrent
    var taskResultFinishedCompletionHandler: ((ORKResult) -> Void)?
    
    let taskNotification = Notification.Name("on-task-selection")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableData(_:)), name: .reload, object: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
/*
    override func viewDidAppear(_ animated: Bool) {
        if let tableView = tableView {
            //let dataSource = tableView.dataSource! as! TaskListViewController
            tableView.reloadData()
        }
    }*/
    

    
    
    
    // Set the spacing between sections
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20.0
    }
    
    // Make the background color show through
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    
    
    func reloadTableData(_ notification: Notification) {
        tableView.reloadData()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return (study?.getStudyTasksArray().count)!+1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print("Study array count: ",study?.getStudyTasksArray().count)
        return 1
    }

    
    enum TableViewCellIdentifier: String {
        case `default` = "Default"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
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
            let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "builderTableView")
            
            let namesArray = study?.getTaskNamesArray()
            let studyActivityName = namesArray?[indexPath.section-1]
            
            cell.textLabel?.text = studyActivityName
            cell.textLabel?.textAlignment = .center
            cell.layer.cornerRadius=3.0 //set corner radius here
            cell.backgroundColor = UIColor(red: 0/255, green: 150/255, blue: 150/255, alpha: 1.0)
            cell.layer.borderColor = UIColor.clear.cgColor
            cell.textLabel?.textColor = UIColor.white
            cell.layer.borderWidth = 10.0 // set border width here
            //cell.backgroundView?.frame = cell.frame.offsetBy(dx: 100, dy: 100);
            
            
            
            
            return cell
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        if indexPath.row == 0 {
            performSegue(withIdentifier: "addTaskSegue", sender: self)
        }
        else{
            // Present the task view controller that the user asked for.
            let taskListRow = ActivitiesConnections.sharedInstance.studyCurrent?.getStudyTasksArray()[indexPath.row-1]
        

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
        taskViewController.dismiss(animated: true, completion: nil)
    }



    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

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
*/
