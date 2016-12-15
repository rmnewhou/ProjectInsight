/*
 Copyright (c) 2015, Apple Inc. All rights reserved.
 Copyright (c) 2015, Ricardo Sánchez-Sáez.

 Redistribution and use in source and binary forms, with or without modification,
 are permitted provided that the following conditions are met:
 
 1.  Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.
 
 2.  Redistributions in binary form must reproduce the above copyright notice, 
 this list of conditions and the following disclaimer in the documentation and/or 
 other materials provided with the distribution. 
 
 3.  Neither the name of the copyright holder(s) nor the names of any contributors 
 may be used to endorse or promote products derived from this software without 
 specific prior written permission. No license is granted to the trademarks of 
 the copyright holders even if such marks are included in this software. 
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE 
 ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE 
 FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL 
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR 
 SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER 
 CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, 
 OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE 
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. 
*/

import UIKit
import ResearchKit

/**
    This example displays a catalog of tasks, each consisting of one or two steps,
    built using the ResearchKit framework. The `TaskListViewController` displays the
    available tasks in this catalog.

    When you tap a task, it is presented like a participant in a study might
    see it. After completing the task, you can see the results generated by
    the task by switching to the results tab.
*/
class TaskListViewController: UITableViewController, ORKTaskViewControllerDelegate {

    var waitStepViewController: ORKWaitStepViewController?
    var waitStepUpdateTimer: Timer?
    var waitStepProgress: CGFloat = 0.0
    var study: Study?
    
    var task: Task?
    
    // MARK: Types
    
    enum TableViewCellIdentifier: String {
        case `default` = "Default"
    }
    
    // MARK: Properties
    
    /**
        When a task is completed, the `TaskListViewController` calls this closure
        with the created task.
    */
    var taskResultFinishedCompletionHandler: ((ORKResult) -> Void)?
    
    // MARK: UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return TaskListRow.sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskListRow.sections[section].rows.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return TaskListRow.sections[section].title
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifier.default.rawValue, for: indexPath)
        
        let taskListRow = TaskListRow.sections[(indexPath as NSIndexPath).section].rows[(indexPath as NSIndexPath).row]
        
        cell.textLabel!.text = "\(taskListRow)"
        
        return cell
    }
    
    // MARK: UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        // Present the task view controller that the user asked for.
        let taskListRow = TaskListRow.sections[(indexPath as NSIndexPath).section].rows[(indexPath as NSIndexPath).row]
        ActivitiesConnections.sharedInstance.tempTaskListRow = taskListRow
        
        /*
        *   What needs to happen is this:
        *   1) The user clicks on a cell and a UIActionSheet is brought up
        *   2) The user has a choice between previewing the task or editing then adding one
        *   3) If the user decides to edit, they will be brought to a screen which will ask them to input values like title and description and whatever else is needed for the task to become "fully customized" 
        *   4) After then enter everything, the values are used instead of the example/default ones to create the tasks (located in this file)
        */
        
        
        //1)
        // Could change this for a popover action alert.
        let popUpActionSheet = UIAlertController(title: "Task Options", message: "What do you like to do?", preferredStyle: UIAlertControllerStyle.actionSheet)
        let previewAction = UIAlertAction(title: "Preview", style: UIAlertActionStyle.default){ (ACTION) in
            
            let task = taskListRow.representedTask
            let taskViewController = ORKTaskViewController(task: task, taskRun: nil)
            taskViewController.delegate = self
            // Assign a directory to store `taskViewController` output.
            taskViewController.outputDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            
            self.present(taskViewController, animated: true, completion: nil)
        }
        
        let addEditAction = UIAlertAction(title: "Customize Task", style: UIAlertActionStyle.default){ (ACTION) in
            if (indexPath.section == 0){
                if indexPath.row == 0 /*boolean Question*/          ||
                    indexPath.row == 1 /*Date Question*/            ||
                    indexPath.row == 2 /*Date & Time Question*/     ||
                    indexPath.row == 5 /*Text Question*/            ||
                    indexPath.row == 7 /*Time Interval Question*/   ||
                    indexPath.row == 8 /*Time of Day Question*/{
                    self.performSegue(withIdentifier: "TitleAndDescriptionSegue", sender: self)
                }else if indexPath.row == 3 /*Numeric Question*/{
                    self.performSegue(withIdentifier: "ValuesAndPlaceholders", sender: self)
                }else if indexPath.row == 6 /* Text Choice Question*/||
                    indexPath.row == 9 /*Multiple choices Question*/{
                    self.performSegue(withIdentifier: "MultipleChoiceSegue", sender: self)
                }else if indexPath.row == 4 /* Scale Question*/{
                    self.performSegue(withIdentifier: "ScaleQuestionSegue", sender: self)
                }else{
                    //This is the default one right now
                    self.performSegue(withIdentifier: "TitleAndDescriptionSegue", sender: self)
                }
            }else if (indexPath.section == 1){
                if indexPath.row == 0 /*Consent Question*/{
                    self.performSegue(withIdentifier: "ConsentSegue", sender: self)
                }
            }else{
                // Active tasks section
                if indexPath.row == 0 /* Fitness Check */           ||
                    indexPath.row == 1 /* Hole Peg Test */          ||
                    indexPath.row == 2 /* PSAT */                   ||
                    indexPath.row == 3 /* Reaction Time */          ||
                    indexPath.row == 4 /* Short Walk */             ||
                    indexPath.row == 5 /* Spatial Span Memory */    ||
                    indexPath.row == 6 /* Timed Walk */             ||
                    indexPath.row == 7 /* Tone Audiometry */        ||
                    indexPath.row == 8 /* Tower of Hanoi */         ||
                    indexPath.row == 9 /* Tremor Test */            ||
                    indexPath.row == 10 /* Two Finger Tap */        ||
                    indexPath.row == 11 /* Walk back and forth */    {
                    self.performSegue(withIdentifier: "TitleAndDescriptionSegue", sender: self)
                }else{
                    //This is the default one right now
                    self.performSegue(withIdentifier: "TitleAndDescriptionSegue", sender: self)
                }
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel){ (ACTION) in
            print("Cancel")
        }

        
        popUpActionSheet.addAction(previewAction)
        popUpActionSheet.addAction(addEditAction)
        popUpActionSheet.addAction(cancelAction)
        
        self.present(popUpActionSheet, animated: true, completion: nil)
        
    }
    
    // MARK: ORKTaskViewControllerDelegate
    
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
    
    func taskViewController(_ taskViewController: ORKTaskViewController, stepViewControllerWillAppear stepViewController: ORKStepViewController) {
        // Example data processing for the wait step.
        if stepViewController.step?.identifier == "WaitStepIndeterminate" ||
            stepViewController.step?.identifier == "WaitStep" ||
            stepViewController.step?.identifier == "LoginWaitStep" {
            delay(5.0, closure: { () -> () in
                if let stepViewController = stepViewController as? ORKWaitStepViewController {
                    stepViewController.goForward()
                }
            })
        } else if stepViewController.step?.identifier == "WaitStepDeterminate" {
            delay(1.0, closure: { () -> () in
                if let stepViewController = stepViewController as? ORKWaitStepViewController {
                    self.waitStepViewController = stepViewController;
                    self.waitStepProgress = 0.0
                    self.waitStepUpdateTimer = Timer(timeInterval: 0.1, target: self, selector: #selector(TaskListViewController.updateProgressOfWaitStepViewController), userInfo: nil, repeats: true)
                    RunLoop.main.add(self.waitStepUpdateTimer!, forMode: RunLoopMode.commonModes)
                }
            })
        }
    }
    
    func delay(_ delay:Double, closure:@escaping ()->()) {
        let delayTime = DispatchTime.now() + delay
        let dispatchWorkItem = DispatchWorkItem(block: closure);
        DispatchQueue.main.asyncAfter(deadline: delayTime, execute: dispatchWorkItem)
    }
    
    func updateProgressOfWaitStepViewController() {
        if let waitStepViewController = waitStepViewController {
            waitStepProgress += 0.01
            DispatchQueue.main.async(execute: { () -> Void in
                waitStepViewController.setProgress(self.waitStepProgress, animated: true)
            })
            if (waitStepProgress < 1.0) {
                return
            } else {
                self.waitStepUpdateTimer?.invalidate()
                waitStepViewController.goForward()
                self.waitStepViewController = nil
            }
        } else {
            self.waitStepUpdateTimer?.invalidate()
        }
    }
    @IBAction func cancel(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }

}
