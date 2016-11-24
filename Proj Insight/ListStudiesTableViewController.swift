//
//  ListStudiesTableViewController.swift
//  Proj Insight
//
//  Created by Mackenzie Kary on 2016-10-24.
//  Copyright © 2016 Mackenzie Kary. All rights reserved.
//

import UIKit


// class which will contain 
class ListStudiesTableViewController: UITableViewController {

    
    // MARK: Properties
    
    var studies = [Study]()
    var filteredStudies = [Study]()    //for when searching and need to filter results.
//    var StudyByType = [Study]()
//    var StudyType: String = String()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    func filterContentsForSearch(searchString: String, scope: String = "All"){
        filteredStudies = studies.filter{ Study in
            //We only care if the string being search is contained in the items being searched.
            return Study.name.lowercased().contains(searchString.lowercased())
        }
        tableView.reloadData()
    }

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        /if let savedStudies = loadStudies() {
//            if savedStudies[0].type == mealType{          
//                mealsByType += savedMeals
//            }else{
//                loadSampleMeals()
//            }
//        }else{
//            // Load the sample data.
//            loadSampleStudies()
//        }
        loadSampleStudies()
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        //searchController.extendedLayoutIncludesOpaqueBars = true;
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar

    }
    
    
    func loadSampleStudies() { //Initialize foods
        let study1 = Study(name: "First Study")! // Eventually will need: Name, ID, IsPrivate, Owner (possibly)
        let study2 = Study(name: "Second Study")!
        let study3 = Study(name: "Third Study")!
        let study4 = Study(name: "Fourth Study")!
        studies += [study1, study2, study3, study4]
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
    // NSCoding
    func saveStudies() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(studies, toFile: Study.ArchiveURL.path)
        if !isSuccessfulSave {
            print("Failed to save studies...")
        }
    }
    func loadStudies() -> [Study]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Study.ArchiveURL.path) as? [Study]
    }

}
extension ListStudiesTableViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        filterContentsForSearch(searchString: searchController.searchBar.text!)
    }
}
