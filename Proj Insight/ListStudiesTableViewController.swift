//
//  ListStudiesTableViewController.swift
//  Proj Insight
//
//  Created by Mackenzie Kary on 2016-10-24.
//  Copyright © 2016 Mackenzie Kary. All rights reserved.
//

import UIKit
import Firebase
import ResearchKit


// class which will contain 
class ListStudiesTableViewController: UITableViewController, ORKTaskViewControllerDelegate{
  
    
    @IBAction func signOutPressed(_ sender: Any) {
        do {
            try FIRAuth.auth()!.signOut()
            //dismiss(animated: true, completion: nil)
        } catch {
            
        }

    }
    
    // MARK: Properties
    var runthrough: Int = 0
    var studyCompletedName: String = ""
    
    var studyToDoArr = [Task]()
    var studies = [Study]()
    var filteredStudies = [Study]()    //for when searching and need to filter results.

    let usersRef = FIRDatabase.database().reference(withPath: "online")
    var user: User!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    func filterContentsForSearch(searchString: String, scope: String = "All"){
        filteredStudies = studies.filter{ Study in
            //We only care if the string being search is contained in the items being searched.
            return Study.name.lowercased().contains(searchString.lowercased())
        }
        tableView.reloadData()
    }

   /*
    func displayWalkthroughs()
    {
        // check if walkthroughs have been shown
        //let userDefaults = UserDefaults.standard
        //let displayedWalkthrough = userDefaults.bool(forKey: "DisplayedWalkthrough")
        
        
        // if we haven't shown the walkthroughs, let's show them
        //if !displayedWalkthrough {
        // instantiate neew PageVC via storyboard
        if 
            if let pageViewController = storyboard?.instantiateViewController(withIdentifier: "PageViewController") as? PageViewController {
                self.present(pageViewController, animated: true, completion: nil)
            }
        //}
    }
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        //displayWalkthroughs()
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        //searchController.extendedLayoutIncludesOpaqueBars = true;
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        refreshControl = UIRefreshControl()
        refreshControl!.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl!.addTarget(self, action: #selector(self.refresh), for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshControl!)
        
        loadStudies()
    }
    
    func refresh(sender:AnyObject) {
        loadStudies()
    }
    
    
    func loadStudies() { //Initialize
        studies = ActivitiesConnections.sharedInstance.allStudyArr
        self.tableView.reloadData()

        if (self.refreshControl?.isRefreshing)!
        {
            self.refreshControl?.endRefreshing()
        }
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Check to see if the search bar is being used, and determine the new number of rows displayed.
        if (searchController.isActive && searchController.searchBar.text != ""){
            return filteredStudies.count
        }
        return studies.count        //Return the number of elements in the table view controller (the number of studies)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     // Table view cells are reused and should be dequeued using a cell identifier.
     let cellIdentifier = "AllStudiesTableViewCell"
     let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! AllStudiesTableViewCell
     
     
     let study: Study
     // Now we need to grab the proper meal list.
     // There is a meal list for when the list is being filtered (searching)
     // and a regular meal list whihc is organized by type.
     if searchController.isActive && searchController.searchBar.text != ""{
        study = filteredStudies[(indexPath as NSIndexPath).row]
     }else{
        print(studies[(indexPath as NSIndexPath).row].name)
        study = studies[(indexPath as NSIndexPath).row]
        print("STUDY NAME IS: ", study.name)
     }
    cell.studyName.text = study.name
    
    return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true) // REMEMBER
        studyCompletedName = ActivitiesConnections.sharedInstance.allStudyArr[indexPath.row].name
        studyToDoArr = ActivitiesConnections.sharedInstance.allStudyArr[indexPath.row].getTasks()
        // Create the taskViewControlled based on the task that we have stored in our studyCurrent array.
        let taskViewController = ORKTaskViewController(task: studyToDoArr[runthrough].task, taskRun: nil)
        taskViewController.delegate = self
        // Assign a directory to store `taskViewController` output.
        taskViewController.outputDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        
        let popUpActionSheet = UIAlertController(title: "Study Options", message: "What do you like to do?", preferredStyle: UIAlertControllerStyle.actionSheet)
        let participateAction = UIAlertAction(title: "Participate", style: UIAlertActionStyle.default){ (ACTION) in
            self.present(taskViewController, animated: true, completion: nil)
        }
        
        let infoAction = UIAlertAction(title: "Information", style: UIAlertActionStyle.default){ (ACTION) in
            // Show description of this particular study
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel){ (ACTION) in
            print("Cancel")
        }
        
        
        popUpActionSheet.addAction(participateAction)
        popUpActionSheet.addAction(infoAction)
        popUpActionSheet.addAction(cancelAction)
        
        self.present(popUpActionSheet, animated: true, completion: nil)
        
        
        
        
        
        
        
        
        
        
        
        
//        tableView.deselectRow(at: indexPath, animated: true) // REMEMBER
//        studyCompletedName = ActivitiesConnections.sharedInstance.allStudyArr[indexPath.row].name
//        studyToDoArr = ActivitiesConnections.sharedInstance.allStudyArr[indexPath.row].getTasks()
//        // Create the taskViewControlled based on the task that we have stored in our studyCurrent array.
//        let taskViewController = ORKTaskViewController(task: studyToDoArr[runthrough].task, taskRun: nil)
//        taskViewController.delegate = self
//        // Assign a directory to store `taskViewController` output.
//        taskViewController.outputDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//        
//        present(taskViewController, animated: true, completion: nil)
        
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
        public func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        
            
            taskViewController.dismiss(animated: true, completion: nil)
            runthrough += 1
            
            switch reason{
                case .completed:
                    // Create the taskViewControlled based on the task that we have stored in our studyCurrent array.
                    if(runthrough < studyToDoArr.count){
                        let taskViewController = ORKTaskViewController(task: studyToDoArr[runthrough].task, taskRun: nil)
                        taskViewController.delegate = self
                        // Assign a directory to store `taskViewController` output.
                        taskViewController.outputDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                        
                        //                let taskResult : ORKTaskResult = taskViewController.result
                        //                print(taskResult)
                        
                        present(taskViewController, animated: true, completion: nil)
                    }else{
                        runthrough = 0
                        let alert = UIAlertController(title: "Study Completed!", message: "Thank you for completing the \(studyCompletedName) study.", preferredStyle: UIAlertControllerStyle.alert)
                        // add an action (button)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        //self.tableView.deselectRow(at: self.index!, animated: true)
                        
                        // show the alert
                        self.present(alert, animated: true, completion: nil)
                }
                case .discarded, .failed, .saved:
                    runthrough = 0
            }
            
            
        }
}
extension ListStudiesTableViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        filterContentsForSearch(searchString: searchController.searchBar.text!)
    }
}
