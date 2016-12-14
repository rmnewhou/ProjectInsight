//
//  DashboardTableViewController.swift
//  Dashboard Demo
//
//  Created by Zach Scott on 2016-11-22.
//  Copyright © 2016 Zach Scott. All rights reserved.
//

import ResearchKit

class DashboardViewController: UIViewController {
    @IBAction func refeshButton(_ sender: Any) {
        self.viewDidLoad()
    }

    @IBOutlet weak var pieChart: ORKPieChartView!
    /* future graph implementation */
//    @IBOutlet weak var discreteGraph: ORKDiscreteGraphChartView!
//    @IBOutlet weak var lineGraph: ORKLineGraphChartView!
//    @IBOutlet weak var barGraph: ORKBarGraphChartView!

    //let pieChartDataSource = PieChartDataSource()
    
    /* future graph implementation */
//    let discreteGraphDataSource = DiscreteGraphDataSource()
//    let lineGraphDataSource = LineGraphDataSource()
//    let barGraphDataSource = BarGraphDataSource()
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the data source for each graph
        pieChart.dataSource = PieChartDataSource()
        
//        // Pie Chart Customization
        pieChart.title = NSLocalizedString("Like Pie?", comment: "")
        pieChart.titleColor = UIColor(red: 82/255.0, green: 196/255.0, blue: 148/255.0, alpha: 1)
        pieChart.tintColor = UIColor(red: 82/255.0, green: 196/255.0, blue: 148/255.0, alpha: 1)
    }

}
