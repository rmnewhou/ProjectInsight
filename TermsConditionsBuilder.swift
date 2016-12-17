//
//  TermsConditionsBuilder.swift
//  Proj Insight
//
//  Created by Ryan Newhouse on 2016-11-04.
//  Copyright © 2016 Mackenzie Kary. All rights reserved.
//

import UIKit

class TermsConditionsBuilder: UIViewController {

    @IBOutlet weak var overviewSwitch: UISwitch!
    @IBOutlet weak var dataGatheringSwitch: UISwitch!
    
    @IBOutlet weak var privacySwitch: UISwitch!
    
    @IBOutlet weak var dataUseSwitch: UISwitch!
    
    @IBOutlet weak var surveysSwitch: UISwitch!
    @IBOutlet weak var timeCommitmentSwitch: UISwitch!
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
        @IBOutlet weak var withdrawalSwitch: UISwitch!
    @IBOutlet weak var tasksSwitch: UISwitch!
    
    @IBAction func nextButton(_ sender: AnyObject) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
