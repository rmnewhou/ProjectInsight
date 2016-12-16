//
//  PieChartDataSource.swift
//  Dashboard Demo
//
//  Created by Zach Scott on 2016-11-23.
//  Copyright © 2016 Zach Scott. All rights reserved.
//

import ResearchKit

class PieChartDataSource: NSObject, ORKPieChartViewDataSource {
    // MARK: Types
    
    struct Segment {
        let title: String
        let value: Float
        let color: UIColor
        var bool = ActivitiesConnections.sharedInstance.booleanResultsArray[0]
        }
    
    // MARK: Properties
    
    let segments = [
        Segment(title: "Yes", value: 25.0, color: UIColor(red: 0/255, green: 184/255, blue: 142/255, alpha: 1.0), bool: ActivitiesConnections.sharedInstance.booleanResultsArray[0]),
        Segment(title: "No", value: 35.0, color: UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1), bool: ActivitiesConnections.sharedInstance.booleanResultsArray[1])
    ]
    
    // MARK: ORKPieChartViewDataSource
    
    /* REQUIRED METHODS */
    
    func numberOfSegments(in pieChartView: ORKPieChartView ) -> Int {
        return 2
    }
    
    func pieChartView(_ pieChartView: ORKPieChartView, valueForSegmentAt index: Int) -> CGFloat {
        print("Loading Number: ",segments[index].bool )
        return CGFloat(segments[index].bool)
    }
    
    /*********************/
    
    func pieChartView(_ pieChartView: ORKPieChartView, colorForSegmentAt index: Int) -> UIColor {
        return segments[index].color
    }
    
    func pieChartView(_ pieChartView: ORKPieChartView, titleForSegmentAt index: Int) -> String {
        return segments[index].title
    }
}
