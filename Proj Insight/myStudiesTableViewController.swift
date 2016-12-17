//
//  myStudiesTableViewController.swift
//  Proj Insight
//
//  Created by Mackenzie Kary on 2016-10-24.
//  Copyright © 2016 Mackenzie Kary. All rights reserved.
//

import UIKit
import FirebaseAuth

class myStudiesTableViewController: UITableViewController {
    
    @IBOutlet weak var addStudyButton: UIBarButtonItem!

    @IBOutlet weak var NavigationItem: UINavigationItem!
    var studyNumber = 0
    //var user: User!
    var index: IndexPath?
    
    //var allStudies = ActivitiesConnections.sharedInstance.studyArr
    @IBAction func buttonPressed(_ sender: Any) {
        do {
            try FIRAuth.auth()!.signOut()
            dismiss(animated: true, completion: nil)
        } catch {
            
        }

    }

    
    @IBOutlet var studyTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.studyTableView.delegate = self
        self.studyTableView.dataSource = self
        NotificationCenter.default.addObserver(self, selector: #selector(reloadStudyTableData(_:)), name: .reload, object: nil)

    }
    
    func reloadStudyTableData(_ notification: Notification) {
        studyNumber = 0;
        studyTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        //print("All studies count = ", allStudies.count)
        return (ActivitiesConnections.sharedInstance.studyArr.count)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myStudyCell", for: indexPath) as! myStudiesTableViewCell
        
            //cell.myStudyName.text = "Study \(studyNumber)"
            //cell.myStudyName.text = "Study \(indexPath.section)" // keep this for now, but down the line, we will want to give the studies a name
        
            cell.myStudyName.text = "\(ActivitiesConnections.sharedInstance.studyArr[indexPath.section].name)"
            cell.layer.cornerRadius=3.0 //set corner radius here
            cell.backgroundColor = UIColor(red: 0/255, green: 150/255, blue: 150/255, alpha: 1.0)
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.borderWidth = 1.0 // set border width here
        
        studyNumber += 1;
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "studyClickedSegue" {
            let popUpActionSheet = UIAlertController(title: "Study Options", message: "What do you like to do?", preferredStyle: UIAlertControllerStyle.actionSheet)
            let submitAction = UIAlertAction(title: "Submit", style: UIAlertActionStyle.default){ (ACTION) in
                
                //Save study to AllStudies...
                if let indexPath = self.studyTableView.indexPathForSelectedRow{
                    ActivitiesConnections.sharedInstance.allStudyArr.append(ActivitiesConnections.sharedInstance.studyArr[indexPath.section])
                    self.tableView.deselectRow(at: self.index!, animated: true)
                }
                        
                // create the alert
                let alert = UIAlertController(title: "Study Submitted", message: "Find your study in the \"List All Studies\" tab!", preferredStyle: UIAlertControllerStyle.alert)
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                //self.tableView.deselectRow(at: self.index!, animated: true)

                // show the alert
                self.present(alert, animated: true, completion: nil)
            }
            
            let editAction = UIAlertAction(title: "Edit Study", style: UIAlertActionStyle.default){ (ACTION) in
                    let nav = segue.destination as! UINavigationController
                    let DestViewController = nav.topViewController as! TaskBuilderViewController
                    if let indexPath = self.studyTableView.indexPathForSelectedRow{
                        
                        //let studyTemp: Study
                        //studyTemp = ActivitiesConnections.sharedInstance.studyArr[(indexPath as NSIndexPath).row]
                        
                        DestViewController.indexNumberOfStudy = indexPath.section
                        
                        //print("\n\n",ActivitiesConnections.sharedInstance.studyArr.count,"\n\n")
                        ActivitiesConnections.sharedInstance.studyCurrent = ActivitiesConnections.sharedInstance.studyArr[indexPath.section]
                        self.performSegue(withIdentifier: "addStudySegue", sender: self)
                    }
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel){ (ACTION) in
                print("Cancel")
            }
            
            
            popUpActionSheet.addAction(submitAction)
            popUpActionSheet.addAction(editAction)
            popUpActionSheet.addAction(cancelAction)
            self.present(popUpActionSheet, animated: true, completion: nil)
        
        }else{
            //Just segue
        }
    }

    @IBAction func addStudy(_ sender: AnyObject) {
        /* 
         * Button was clicked, we need to
         * open the windows which will
         * let us create a new study
        */
        
    }

}
