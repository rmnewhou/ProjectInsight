//
//  ConsentDocument.swift
//  Proj Insight
//
//  Created by Ryan Newhouse on 2016-12-07.
//  Copyright © 2016 Mackenzie Kary. All rights reserved.
//

import ResearchKit

class ConsentDocument: ORKConsentDocument {
    // MARK: Properties
    
    
    // MARK: Initialization
    
    override init() {
        super.init()
        
        addOverviewSection(summary: "Hello", content: "World")
        
        title = NSLocalizedString("Consent Form", comment: "")
        
        sections = []
        
        
        let signature = ORKConsentSignature(forPersonWithTitle: nil, dateFormatString: nil, identifier: "ConsentDocumentParticipantSignature")
        addSignature(signature)
    }
    
    func addOverviewSection(summary: String, content: String){
        let section = ORKConsentSection(type: .overview)
        section.summary = summary
        section.content = content
        
        sections?.append(section)
        
    }
    
    func addDataGatheringSection(summary: String, content: String){
        
    }
    func addPrivacySection(summary: String, content: String){
        
    }
    func addDataUseSection(summary: String, content: String){
        
    }
    func addTimeCommitmentSection(summary: String, content: String){
        
    }
    func addStudySurveySection(summary: String, content: String){
        
    }
    func addStudyTasksSection(summary: String, content: String){
        
    }
    func addWithdrawingSection(summary: String, content: String){
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ORKConsentSectionType: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .overview:
            return "Overview"
            
        case .dataGathering:
            return "Data Gathering"
            
        case .privacy:
            return "Privacy"
            
        case .dataUse:
            return "Data Use"
            
        case .timeCommitment:
            return "Time Commitment"
            
        case .studySurvey:
            return "Study Survey"
            
        case .studyTasks:
            return "Study Tasks"
            
        case .withdrawing:
            return "Withdrawing"
            
        case .custom:
            return "Custom"
            
        case .onlyInDocument:
            return "Only In Document"
        }
    }
}
