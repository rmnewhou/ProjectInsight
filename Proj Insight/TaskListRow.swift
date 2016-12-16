/*
 Copyright (c) 2015, Apple Inc. All rights reserved.
 Copyright (c) 2015-2016, Ricardo Sánchez-Sáez.

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

import ResearchKit
import AudioToolbox

/**
    Wraps a SystemSoundID.

    A class is used in order to provide appropriate cleanup when the sound is
    no longer needed.
*/
class SystemSound {
    var soundID: SystemSoundID = 0
    
    init?(soundURL: URL) {
        if AudioServicesCreateSystemSoundID(soundURL as CFURL, &soundID) != noErr {
           return nil
        }
    }
    
    deinit {
        AudioServicesDisposeSystemSoundID(soundID)
    }
}


/**
    An enum that corresponds to a row displayed in a `TaskListViewController`.

    Each of the tasks is composed of one or more steps giving examples of the
    types of functionality supported by the ResearchKit framework.
*/
var inputtedDescription = ""
var inputtedDetailedDescription = ""
var inputtedTitle = ""
var inputtedUnitPlaceholder = ""
var inputtedUnitText = ""
var inputtedChoicesArray = [String]()
var studystep: ORKQuestionStep?

enum TaskListRow: Int, CustomStringConvertible {

    case booleanQuestion = 0
    case dateQuestion
    case dateTimeQuestion
    case numericQuestion
    case scaleQuestion
    case textQuestion
    case textChoiceQuestion
    case timeIntervalQuestion
    case timeOfDayQuestion
    case valuePickerChoiceQuestion
    case eligibilityTask
    case consent                //
    case accountCreation        //
    case passcode
    case fitness
    case holePegTest
    case psat
    case reactionTime
    case shortWalk
    case spatialSpanMemory
    case timedWalk
    case toneAudiometry
    case towerOfHanoi
    case tremorTest
    case twoFingerTappingInterval
    case walkBackAndForth
    
    class TaskListRowSection {
        var title: String
        var rows: [TaskListRow]
        
        init(title: String, rows: [TaskListRow]) {
            self.title = title
            self.rows = rows
        }
    }
    
    /// Returns an array of all the task list row enum cases.
    static var sections: [ TaskListRowSection ] {
        return [
            TaskListRowSection(title: "Questions", rows:
                [
                    .booleanQuestion,
                    .dateQuestion,
                    .dateTimeQuestion,
                    .numericQuestion,
                    .scaleQuestion,
                    .textQuestion,
                    .textChoiceQuestion,
                    .timeIntervalQuestion,
                    .timeOfDayQuestion,
                    .valuePickerChoiceQuestion,
                ]),
            TaskListRowSection(title: "Onboarding", rows:
                [
                    .eligibilityTask,
                    .consent,
                    .accountCreation,
                    .passcode,
                ]),
            TaskListRowSection(title: "Active Tasks", rows:
                [
                    .fitness,
                    .holePegTest,
                    .psat,
                    .reactionTime,
                    .shortWalk,
                    .spatialSpanMemory,
                    .timedWalk,
                    .toneAudiometry,
                    .towerOfHanoi,
                    .tremorTest,
                    .twoFingerTappingInterval,
                    .walkBackAndForth
                ]),
        ]}
    
    // MARK: CustomStringConvertible
    
    var description: String {
        switch self {
            
        case .booleanQuestion:
            return NSLocalizedString("Yes/No Question", comment: "")    //Boolean Question
            
        case .dateQuestion:
            return NSLocalizedString("Date Question", comment: "")
            
        case .dateTimeQuestion:
            return NSLocalizedString("Date and Time Question", comment: "")
            
        case .numericQuestion:
            return NSLocalizedString("Numeric Question", comment: "")
            
        case .scaleQuestion:
            return NSLocalizedString("Scale Question", comment: "")
            
        case .textQuestion:
            return NSLocalizedString("Text Question", comment: "")
            
        case .textChoiceQuestion:
            return NSLocalizedString("Text Choice Question", comment: "")
            
        case .timeIntervalQuestion:
            return NSLocalizedString("Time Interval Question", comment: "")
            
        case .timeOfDayQuestion:
            return NSLocalizedString("Time of Day Question", comment: "")
            
        case .valuePickerChoiceQuestion:
            return NSLocalizedString("Value Picker", comment: "")

        case .eligibilityTask:
            return NSLocalizedString("Eligibility Task", comment: "")
            
        case .consent:
            return NSLocalizedString("Consent-Obtaining", comment: "")

        case .accountCreation:
            return NSLocalizedString("Account Creation", comment: "")

        case .passcode:
            return NSLocalizedString("Passcode Creation", comment: "")
            
        case .fitness:
            return NSLocalizedString("Fitness Check", comment: "")
        
        case .holePegTest:
            return NSLocalizedString("Hole Peg Test", comment: "")
            
        case .psat:
            return NSLocalizedString("PSAT", comment: "")
            
        case .reactionTime:
            return NSLocalizedString("Reaction Time", comment: "")
            
        case .shortWalk:
            return NSLocalizedString("Short Walk", comment: "")
            
        case .spatialSpanMemory:
            return NSLocalizedString("Spatial Span Memory", comment: "")
            
        case .timedWalk:
            return NSLocalizedString("Timed Walk", comment: "")
            
        case .toneAudiometry:
            return NSLocalizedString("Tone Audiometry", comment: "")
            
        case .towerOfHanoi:
            return NSLocalizedString("Tower of Hanoi", comment: "")

        case .twoFingerTappingInterval:
            return NSLocalizedString("Two Finger Tapping Interval", comment: "")
            
        case .walkBackAndForth:
            return NSLocalizedString("Walk Back and Forth", comment: "")
            
        case .tremorTest:
            return NSLocalizedString("Tremor Test", comment: "")
        }
    }
    
    var taskType: String {
        switch self {
            
        case .booleanQuestion:
            return NSLocalizedString("Question", comment: "")    //Boolean Question
            
        case .dateQuestion:
            return NSLocalizedString("Question", comment: "")
            
        case .dateTimeQuestion:
            return NSLocalizedString("Question", comment: "")
            
        case .numericQuestion:
            return NSLocalizedString("Question", comment: "")
            
        case .scaleQuestion:
            return NSLocalizedString("Question", comment: "")
            
        case .textQuestion:
            return NSLocalizedString("Question", comment: "")
            
        case .textChoiceQuestion:
            return NSLocalizedString("Question", comment: "")
            
        case .timeIntervalQuestion:
            return NSLocalizedString("Question", comment: "")
            
        case .timeOfDayQuestion:
            return NSLocalizedString("Question", comment: "")
            
        case .valuePickerChoiceQuestion:
            return NSLocalizedString("Question", comment: "")
            
            
        case .eligibilityTask:
            return NSLocalizedString("Onboarding", comment: "")
            
        case .consent:
            return NSLocalizedString("Onboarding", comment: "")
            
        case .accountCreation:
            return NSLocalizedString("Onboarding", comment: "")
            
        case .passcode:
            return NSLocalizedString("Onboarding", comment: "")
            
        case .fitness:
            return NSLocalizedString("Active Tasks", comment: "")
            
        case .holePegTest:
            return NSLocalizedString("Active Tasks", comment: "")
            
        case .psat:
            return NSLocalizedString("Active Tasks", comment: "")
            
        case .reactionTime:
            return NSLocalizedString("Active Tasks", comment: "")
            
        case .shortWalk:
            return NSLocalizedString("Active Tasks", comment: "")
            
        case .spatialSpanMemory:
            return NSLocalizedString("Active Tasks", comment: "")
            
        case .timedWalk:
            return NSLocalizedString("Active Tasks", comment: "")
            
        case .toneAudiometry:
            return NSLocalizedString("Active Tasks", comment: "")
            
        case .towerOfHanoi:
            return NSLocalizedString("Active Tasks", comment: "")
            
        case .twoFingerTappingInterval:
            return NSLocalizedString("Active Tasks", comment: "")
            
        case .walkBackAndForth:
            return NSLocalizedString("Active Tasks", comment: "")
            
        case .tremorTest:
            return NSLocalizedString("Active Tasks", comment: "")
        }
    }

    // MARK: Types

    /**
        Every step and task in the ResearchKit framework has to have an identifier.
        Within a task, the step identifiers should be unique.

        Here we use an enum to ensure that the identifiers are kept unique. Since
        the enum has a raw underlying type of a `String`, the compiler can determine
        the uniqueness of the case values at compile time.

        In a real application, the identifiers for your tasks and steps might
        come from a database, or in a smaller application, might have some
        human-readable meaning.
    */
    private enum Identifier {
        // Task with a form, where multiple items appear on one page.
        case formTask
        case formStep
        case formItem01
        case formItem02
        case formItem03

        // Survey task specific identifiers.
        case surveyTask
        case introStep
        case questionStep
        case summaryStep
        
        // Task with a Boolean question.
        case booleanQuestionTask
        case booleanQuestionStep

        // Task with an example of date entry.
        case dateQuestionTask
        case dateQuestionStep
        
        // Task with an example of date and time entry.
        case dateTimeQuestionTask
        case dateTimeQuestionStep
        
        // Task with examples of numeric questions.
        case numericQuestionTask
        case numericQuestionStep
        case numericNoUnitQuestionStep

        // Task with examples of questions with sliding scales.
        case scaleQuestionTask
        case discreteScaleQuestionStep
        case continuousScaleQuestionStep
        case discreteVerticalScaleQuestionStep
        case continuousVerticalScaleQuestionStep
        case textScaleQuestionStep
        case textVerticalScaleQuestionStep

        // Task with an example of free text entry.
        case textQuestionTask
        case textQuestionStep
        
        // Task with an example of a multiple choice question.
        case textChoiceQuestionTask
        case textChoiceQuestionStep

        // Task with an example of time of day entry.
        case timeOfDayQuestionTask
        case timeOfDayQuestionStep

        // Task with an example of time interval entry.
        case timeIntervalQuestionTask
        case timeIntervalQuestionStep

        // Task with a value picker.
        case valuePickerChoiceQuestionTask
        case valuePickerChoiceQuestionStep
        
        // Eligibility task specific indentifiers.
        case eligibilityTask
        case eligibilityIntroStep
        case eligibilityFormStep
        case eligibilityFormItem01
        case eligibilityFormItem02
        case eligibilityFormItem03
        case eligibilityIneligibleStep
        case eligibilityEligibleStep
        
        // Consent task specific identifiers.
        case consentTask
        case visualConsentStep
        case consentSharingStep
        case consentReviewStep
        case consentDocumentParticipantSignature
        case consentDocumentInvestigatorSignature
        
        // Account creation task specific identifiers.
        case accountCreationTask
        case registrationStep
        case waitStep
        case verificationStep
        

        // Passcode task specific identifiers.
        case passcodeTask
        case passcodeStep

        // Active tasks.
        case fitnessTask
        case holePegTestTask
        case psatTask
        case reactionTime
        case shortWalkTask
        case spatialSpanMemoryTask
        case timedWalkTask
        case toneAudiometryTask
        case towerOfHanoi
        case tremorTestTask
        case twoFingerTappingIntervalTask
        case walkBackAndForthTask
    }
    
    // MARK: Properties
    
    /// Returns a new `ORKTask` that the `TaskListRow` enumeration represents.
    var representedTask: ORKTask {
        switch self {
            
        case .booleanQuestion:
            return booleanQuestionTask
            
        case .dateQuestion:
            return dateQuestionTask
            
        case .dateTimeQuestion:
            return dateTimeQuestionTask
            
        case .numericQuestion:
            return numericQuestionTask
            
        case .scaleQuestion:
            return scaleQuestionTask
            
        case .textQuestion:
            return textQuestionTask
            
        case .textChoiceQuestion:
            return textChoiceQuestionTask

        case .timeIntervalQuestion:
            return timeIntervalQuestionTask

        case .timeOfDayQuestion:
                return timeOfDayQuestionTask
        
        case .valuePickerChoiceQuestion:
                return valuePickerChoiceQuestionTask

        
        case .eligibilityTask:
            return eligibilityTask
            
        case .consent:
            return consentTask
            
        case .accountCreation:
            return accountCreationTask

        case .passcode:
            return passcodeTask

        case .fitness:
            return fitnessTask
            
        case .holePegTest:
            return holePegTestTask
            
        case .psat:
            return PSATTask
            
        case .reactionTime:
            return reactionTimeTask
            
        case .shortWalk:
            return shortWalkTask
            
        case .spatialSpanMemory:
            return spatialSpanMemoryTask

        case .timedWalk:
            return timedWalkTask
            
        case .toneAudiometry:
            return toneAudiometryTask
            
        case .towerOfHanoi:
            return towerOfHanoiTask
            
        case .twoFingerTappingInterval:
            return twoFingerTappingIntervalTask
            
        case .walkBackAndForth:
            return walkBackAndForthTask
            
        case .tremorTest:
            return tremorTestTask
        }
    }

    // MARK: Task Creation Convenience
    
    
    
    /// This task presents just a single "Yes" / "No" question.
    private var booleanQuestionTask: ORKTask {
        let answerFormat = ORKBooleanAnswerFormat()
        
        // We attach an answer format to a question step to specify what controls the user sees.
        var titleText: String = ""
        if (inputtedTitle != ""){
            titleText = inputtedTitle
        }else{
            titleText = exampleDescription
        }
        let questionStep = ORKQuestionStep(identifier: String(describing:Identifier.booleanQuestionStep), title: titleText, answer: answerFormat)
        
        // The detail text is shown in a small font below the title.
        if (inputtedDetailedDescription != ""){
            questionStep.text = inputtedDetailedDescription
        }else{
            questionStep.text = exampleDetailText
        }
        
        return ORKOrderedTask(identifier: String(describing:Identifier.booleanQuestionTask), steps: [questionStep])
    }

    /// This task demonstrates a question which asks for a date.
    private var dateQuestionTask: ORKTask {
        /*
        The date answer format can also support minimum and maximum limits,
        a specific default value, and overriding the calendar to use.
        */
        
        var titleText: String = ""
        if (inputtedTitle != ""){
            titleText = inputtedTitle
        }else{
            titleText = exampleDescription
        }

        let answerFormat = ORKAnswerFormat.dateAnswerFormat()
        
        let step = ORKQuestionStep(identifier: String(describing:Identifier.dateQuestionStep), title: titleText, answer: answerFormat)
        
        // The detail text is shown in a small font below the title.
        if (inputtedDetailedDescription != ""){
            step.text = inputtedDetailedDescription
        }else{
            step.text = exampleDetailText
        }

        
        return ORKOrderedTask(identifier: String(describing:Identifier.dateQuestionTask), steps: [step])
    }
    
    /// This task demonstrates a question asking for a date and time of an event.
    private var dateTimeQuestionTask: ORKTask {
        /*
        This uses the default calendar. Use a more detailed constructor to
        set minimum / maximum limits.
        */
        var titleText: String = ""
        if (inputtedTitle != ""){
            titleText = inputtedTitle
        }else{
            titleText = exampleDescription
        }

        let answerFormat = ORKAnswerFormat.dateTime()
        
        let step = ORKQuestionStep(identifier: String(describing:Identifier.dateTimeQuestionStep), title: titleText, answer: answerFormat)
        
        if (inputtedDetailedDescription != ""){
            step.text = inputtedDetailedDescription
        }else{
            step.text = exampleDetailText
        }

        
        return ORKOrderedTask(identifier: String(describing:Identifier.dateTimeQuestionTask), steps: [step])
    }


    
    /**
        This task demonstrates use of numeric questions with and without units.
        Note that the unit is just a string, prompting the user to enter the value
        in the expected unit. The unit string propagates into the result object.
    */
    private var numericQuestionTask: ORKTask {
        // This answer format will display a unit in-line with the numeric entry field.
        
        var titleText: String = ""
        if (inputtedTitle != ""){
            titleText = inputtedTitle
        }else{
            titleText = exampleDescription
        }
        // Check if different unit text is added like "lbs"
        var unitText: String = ""
        if (inputtedUnitText != ""){
            unitText = inputtedUnitText
        }else{
            unitText = "Your unit"
        }
        // Check if different unit placeholder is added
        var unitPlaceholder: String = ""
        if (inputtedUnitPlaceholder != ""){
            unitPlaceholder = inputtedUnitPlaceholder
        }else{
            unitPlaceholder = "Your placeholder."
        }
        
        let localizedQuestionStep1AnswerFormatUnit = NSLocalizedString(unitText, comment: "")
        let questionStep1AnswerFormat = ORKAnswerFormat.decimalAnswerFormat(withUnit: localizedQuestionStep1AnswerFormatUnit)
        
        let questionStep1 = ORKQuestionStep(identifier: String(describing:Identifier.numericQuestionStep), title: titleText, answer: questionStep1AnswerFormat)
        
        if (inputtedDetailedDescription != ""){
            questionStep1.text = inputtedDetailedDescription
        }else{
            questionStep1.text = exampleDetailText
        }

        questionStep1.placeholder = NSLocalizedString(unitPlaceholder, comment: "")
        
        /*
        // This answer format is similar to the previous one, but this time without displaying a unit.
        let questionStep2 = ORKQuestionStep(identifier: String(describing:Identifier.numericNoUnitQuestionStep), title: exampleQuestionText, answer: ORKAnswerFormat.decimalAnswerFormat(withUnit: nil))
        
        questionStep2.text = exampleDetailText
        questionStep2.placeholder = NSLocalizedString("Placeholder without unit.", comment: "")
        */
        return ORKOrderedTask(identifier: String(describing:Identifier.numericQuestionTask), steps: [
            questionStep1
        ])
    }
    
    /// This task presents two options for questions displaying a scale control.
    private var scaleQuestionTask: ORKTask {
        // The first step is a scale control with 10 discrete ticks.
        let step1AnswerFormat = ORKAnswerFormat.scale(withMaximumValue: 10, minimumValue: 1, defaultValue: NSIntegerMax, step: 1, vertical: false, maximumValueDescription: exampleHighValueText, minimumValueDescription: exampleLowValueText)
        
        let questionStep1 = ORKQuestionStep(identifier: String(describing:Identifier.discreteScaleQuestionStep), title: exampleQuestionText, answer: step1AnswerFormat)
        
        questionStep1.text = exampleDetailText
        
        // The second step is a scale control that allows continuous movement with a percent formatter.
        let step2AnswerFormat = ORKAnswerFormat.continuousScale(withMaximumValue: 1.0, minimumValue: 0.0, defaultValue: 99.0, maximumFractionDigits: 0, vertical: false, maximumValueDescription: nil, minimumValueDescription: nil)
        step2AnswerFormat.numberStyle = .percent
        
        let questionStep2 = ORKQuestionStep(identifier: String(describing:Identifier.continuousScaleQuestionStep), title: exampleQuestionText, answer: step2AnswerFormat)
        
        questionStep2.text = exampleDetailText
        
        // The third step is a vertical scale control with 10 discrete ticks.
        let step3AnswerFormat = ORKAnswerFormat.scale(withMaximumValue: 10, minimumValue: 1, defaultValue: NSIntegerMax, step: 1, vertical: true, maximumValueDescription: nil, minimumValueDescription: nil)
        
        let questionStep3 = ORKQuestionStep(identifier: String(describing:Identifier.discreteVerticalScaleQuestionStep), title: exampleQuestionText, answer: step3AnswerFormat)
        
        questionStep3.text = exampleDetailText
        
        // The fourth step is a vertical scale control that allows continuous movement.
        let step4AnswerFormat = ORKAnswerFormat.continuousScale(withMaximumValue: 5.0, minimumValue: 1.0, defaultValue: 99.0, maximumFractionDigits: 2, vertical: true, maximumValueDescription: exampleHighValueText, minimumValueDescription: exampleLowValueText)
        
        let questionStep4 = ORKQuestionStep(identifier: String(describing:Identifier.continuousVerticalScaleQuestionStep), title: exampleQuestionText, answer: step4AnswerFormat)
        
        questionStep4.text = exampleDetailText
        
        // The fifth step is a scale control that allows text choices.
        let textChoices : [ORKTextChoice] = [ORKTextChoice(text: "Poor", value: 1 as NSCoding & NSCopying & NSObjectProtocol), ORKTextChoice(text: "Fair", value: 2 as NSCoding & NSCopying & NSObjectProtocol), ORKTextChoice(text: "Good", value: 3 as NSCoding & NSCopying & NSObjectProtocol), ORKTextChoice(text: "Above Average", value: 10 as NSCoding & NSCopying & NSObjectProtocol), ORKTextChoice(text: "Excellent", value: 5 as NSCoding & NSCopying & NSObjectProtocol)]

        let step5AnswerFormat = ORKAnswerFormat.textScale(with: textChoices, defaultIndex: NSIntegerMax, vertical: false)
        
        let questionStep5 = ORKQuestionStep(identifier: String(describing:Identifier.textScaleQuestionStep), title: exampleQuestionText, answer: step5AnswerFormat)
        
        questionStep5.text = exampleDetailText
        
        // The sixth step is a vertical scale control that allows text choices.
        let step6AnswerFormat = ORKAnswerFormat.textScale(with: textChoices, defaultIndex: NSIntegerMax, vertical: true)
        
        let questionStep6 = ORKQuestionStep(identifier: String(describing:Identifier.textVerticalScaleQuestionStep), title: exampleQuestionText, answer: step6AnswerFormat)
        
        questionStep6.text = exampleDetailText
        
        return ORKOrderedTask(identifier: String(describing:Identifier.scaleQuestionTask), steps: [
            questionStep1,
            questionStep2,
            questionStep3,
            questionStep4,
            questionStep5,
            questionStep6
            ])
    }
    
    /**
    This task demonstrates asking for text entry. Both single and multi-line
    text entry are supported, with appropriate parameters to the text answer
    format.
    */
    private var textQuestionTask: ORKTask {
        let answerFormat = ORKAnswerFormat.textAnswerFormat()
        
        
        var titleText: String = ""
        if (inputtedDescription != ""){
            titleText = inputtedDescription
        }else{
            titleText = exampleDescription
        }
        
        let step = ORKQuestionStep(identifier: String(describing:Identifier.textQuestionStep), title: titleText, answer: answerFormat)
        
        // The detail text is shown in a small font below the title.
        if (inputtedDetailedDescription != ""){
            step.text = inputtedDetailedDescription
        }else{
            step.text = exampleDetailText
        }
        
        return ORKOrderedTask(identifier: String(describing:Identifier.textQuestionTask), steps: [step])
    }
    
    /**
    This task demonstrates a survey question for picking from a list of text
    choices. In this case, the text choices are presented in a table view
    (compare with the `valuePickerQuestionTask`).
    */
    private var textChoiceQuestionTask: ORKTask {
        
        var titleText: String = ""
        if (inputtedTitle != ""){
            titleText = inputtedTitle
        }else{
            titleText = exampleDescription
        }

        if inputtedChoicesArray.count == 100{ // Just set ot to 100 for right now. Need ot make sure in TaskController more than one input is added
            //This should not be the case
        }else if inputtedChoicesArray.count == 2{
            let textChoiceOneText = NSLocalizedString(inputtedChoicesArray[0], comment: "")
            let textChoiceTwoText = NSLocalizedString(inputtedChoicesArray[1], comment: "")
            
            // The text to display can be separate from the value coded for each choice:
            let textChoices = [
                ORKTextChoice(text: textChoiceOneText, value: "choice_1" as NSCoding & NSCopying & NSObjectProtocol),
                ORKTextChoice(text: textChoiceTwoText, value: "choice_2" as NSCoding & NSCopying & NSObjectProtocol)]
            let answerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices)
            
            let questionStep = ORKQuestionStep(identifier: String(describing:Identifier.textChoiceQuestionStep), title: titleText, answer: answerFormat)
            
            if (inputtedDetailedDescription != ""){
                questionStep.text = inputtedDetailedDescription
            }else{
                questionStep.text = exampleDetailText
            }
            
            return ORKOrderedTask(identifier: String(describing:Identifier.textChoiceQuestionTask), steps: [questionStep])

        }else if inputtedChoicesArray.count == 3{
            let textChoiceOneText = NSLocalizedString(inputtedChoicesArray[0], comment: "")
            let textChoiceTwoText = NSLocalizedString(inputtedChoicesArray[1], comment: "")
            let textChoiceThreeText = NSLocalizedString(inputtedChoicesArray[2], comment: "")
            
            // The text to display can be separate from the value coded for each choice:
            let textChoices = [
                ORKTextChoice(text: textChoiceOneText, value: "choice_1" as NSCoding & NSCopying & NSObjectProtocol),
                ORKTextChoice(text: textChoiceTwoText, value: "choice_2" as NSCoding & NSCopying & NSObjectProtocol),
                ORKTextChoice(text: textChoiceThreeText, value: "choice_3" as NSCoding & NSCopying & NSObjectProtocol)]
            let answerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices)
            
            let questionStep = ORKQuestionStep(identifier: String(describing:Identifier.textChoiceQuestionStep), title: titleText, answer: answerFormat)
            
            if (inputtedDetailedDescription != ""){
                questionStep.text = inputtedDetailedDescription
            }else{
                questionStep.text = exampleDetailText
            }
            
            return ORKOrderedTask(identifier: String(describing:Identifier.textChoiceQuestionTask), steps: [questionStep])
            
        }else if inputtedChoicesArray.count == 4{
            let textChoiceOneText = NSLocalizedString(inputtedChoicesArray[0], comment: "")
            let textChoiceTwoText = NSLocalizedString(inputtedChoicesArray[1], comment: "")
            let textChoiceThreeText = NSLocalizedString(inputtedChoicesArray[2], comment: "")
            let textChoiceFourText = NSLocalizedString(inputtedChoicesArray[3], comment: "")
            
            // The text to display can be separate from the value coded for each choice:
            let textChoices = [
                ORKTextChoice(text: textChoiceOneText, value: "choice_1" as NSCoding & NSCopying & NSObjectProtocol),
                ORKTextChoice(text: textChoiceTwoText, value: "choice_2" as NSCoding & NSCopying & NSObjectProtocol),
                ORKTextChoice(text: textChoiceThreeText, value: "choice_3" as NSCoding & NSCopying & NSObjectProtocol),
                ORKTextChoice(text: textChoiceFourText, value: "choice_4" as NSCoding & NSCopying & NSObjectProtocol)]
            let answerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices)
            
            let questionStep = ORKQuestionStep(identifier: String(describing:Identifier.textChoiceQuestionStep), title: titleText, answer: answerFormat)
            
            if (inputtedDetailedDescription != ""){
                questionStep.text = inputtedDetailedDescription
            }else{
                questionStep.text = exampleDetailText
            }
            
            return ORKOrderedTask(identifier: String(describing:Identifier.textChoiceQuestionTask), steps: [questionStep])
            
        }
        // No inputs? WE NEED TO ERROR CHECK FOR THIS
        let textChoiceOneText = NSLocalizedString("Choice 1", comment: "")
        let textChoiceTwoText = NSLocalizedString("Choice 2", comment: "")
        let textChoiceThreeText = NSLocalizedString("Choice 3", comment: "")
        let textChoiceFourText = NSLocalizedString("Choice 4", comment: "")
        
        // The text to display can be separate from the value coded for each choice:
        let textChoices = [
            ORKTextChoice(text: textChoiceOneText, value: "choice_1" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceTwoText, value: "choice_2" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceThreeText, value: "choice_3" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceFourText, value: "choice_4" as NSCoding & NSCopying & NSObjectProtocol)]
        let answerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices)
        
        let questionStep = ORKQuestionStep(identifier: String(describing:Identifier.textChoiceQuestionStep), title: titleText, answer: answerFormat)
        
        questionStep.text = exampleDetailText
        
        return ORKOrderedTask(identifier: String(describing:Identifier.textChoiceQuestionTask), steps: [questionStep])
    }

    /**
        This task demonstrates requesting a time interval. For example, this might
        be a suitable answer format for a question like "How long is your morning
        commute?"
    */
    private var timeIntervalQuestionTask: ORKTask {
        /* 
            The time interval answer format is constrained to entering a time
            less than 24 hours and in steps of minutes. For times that don't fit
            these restrictions, use another mode of data entry.
        */
        let answerFormat = ORKAnswerFormat.timeIntervalAnswerFormat()
        
        let step = ORKQuestionStep(identifier: String(describing:Identifier.timeIntervalQuestionStep), title: exampleQuestionText, answer: answerFormat)
        
        step.text = exampleDetailText
        
        return ORKOrderedTask(identifier: String(describing:Identifier.timeIntervalQuestionTask), steps: [step])
    }

    /// This task demonstrates a question asking for a time of day.
    private var timeOfDayQuestionTask: ORKTask {
        /*
        Because we don't specify a default, the picker will default to the
        time the step is presented. For questions like "What time do you have
        breakfast?", it would make sense to set the default on the answer
        format.
        */
        let answerFormat = ORKAnswerFormat.timeOfDayAnswerFormat()
        
        let questionStep = ORKQuestionStep(identifier: String(describing:Identifier.timeOfDayQuestionStep), title: exampleQuestionText, answer: answerFormat)
        
        questionStep.text = exampleDetailText
        
        return ORKOrderedTask(identifier: String(describing:Identifier.timeOfDayQuestionTask), steps: [questionStep])
    }

    /**
        This task demonstrates a survey question using a value picker wheel.
        Compare with the `textChoiceQuestionTask` and `imageChoiceQuestionTask`
        which can serve a similar purpose.
    */
    private var valuePickerChoiceQuestionTask: ORKTask {
        
        var titleText: String = ""
        if (inputtedTitle != ""){
            titleText = inputtedTitle
        }else{
            titleText = exampleDescription
        }
        
        if inputtedChoicesArray.count == 100{ // Just set ot to 100 for right now. Need ot make sure in TaskController more than one input is added
            //This should not be the case
        }else if inputtedChoicesArray.count == 2{
            let textChoiceOneText = NSLocalizedString(inputtedChoicesArray[0], comment: "")
            let textChoiceTwoText = NSLocalizedString(inputtedChoicesArray[1], comment: "")
            
            // The text to display can be separate from the value coded for each choice:
            let textChoices = [
                ORKTextChoice(text: textChoiceOneText, value: "choice_1" as NSCoding & NSCopying & NSObjectProtocol),
                ORKTextChoice(text: textChoiceTwoText, value: "choice_2" as NSCoding & NSCopying & NSObjectProtocol)]
            let answerFormat = ORKAnswerFormat.valuePickerAnswerFormat(with: textChoices)
            
            let questionStep = ORKQuestionStep(identifier: String(describing:Identifier.valuePickerChoiceQuestionStep), title: titleText, answer: answerFormat)
            
            if (inputtedDetailedDescription != ""){
                questionStep.text = inputtedDetailedDescription
            }else{
                questionStep.text = exampleDetailText
            }
            
            return ORKOrderedTask(identifier: String(describing:Identifier.valuePickerChoiceQuestionStep), steps: [questionStep])
            
        }else if inputtedChoicesArray.count == 3{
            let textChoiceOneText = NSLocalizedString(inputtedChoicesArray[0], comment: "")
            let textChoiceTwoText = NSLocalizedString(inputtedChoicesArray[1], comment: "")
            let textChoiceThreeText = NSLocalizedString(inputtedChoicesArray[2], comment: "")
            
            // The text to display can be separate from the value coded for each choice:
            let textChoices = [
                ORKTextChoice(text: textChoiceOneText, value: "choice_1" as NSCoding & NSCopying & NSObjectProtocol),
                ORKTextChoice(text: textChoiceTwoText, value: "choice_2" as NSCoding & NSCopying & NSObjectProtocol),
                ORKTextChoice(text: textChoiceThreeText, value: "choice_3" as NSCoding & NSCopying & NSObjectProtocol)]
            let answerFormat = ORKAnswerFormat.valuePickerAnswerFormat(with: textChoices)
            
            let questionStep = ORKQuestionStep(identifier: String(describing:Identifier.valuePickerChoiceQuestionStep), title: titleText, answer: answerFormat)
            
            if (inputtedDetailedDescription != ""){
                questionStep.text = inputtedDetailedDescription
            }else{
                questionStep.text = exampleDetailText
            }
            
            return ORKOrderedTask(identifier: String(describing:Identifier.valuePickerChoiceQuestionStep), steps: [questionStep])
            
        }else if inputtedChoicesArray.count == 4{
            let textChoiceOneText = NSLocalizedString(inputtedChoicesArray[0], comment: "")
            let textChoiceTwoText = NSLocalizedString(inputtedChoicesArray[1], comment: "")
            let textChoiceThreeText = NSLocalizedString(inputtedChoicesArray[2], comment: "")
            let textChoiceFourText = NSLocalizedString(inputtedChoicesArray[3], comment: "")
            
            // The text to display can be separate from the value coded for each choice:
            let textChoices = [
                ORKTextChoice(text: textChoiceOneText, value: "choice_1" as NSCoding & NSCopying & NSObjectProtocol),
                ORKTextChoice(text: textChoiceTwoText, value: "choice_2" as NSCoding & NSCopying & NSObjectProtocol),
                ORKTextChoice(text: textChoiceThreeText, value: "choice_3" as NSCoding & NSCopying & NSObjectProtocol),
                ORKTextChoice(text: textChoiceFourText, value: "choice_4" as NSCoding & NSCopying & NSObjectProtocol)]
            let answerFormat = ORKAnswerFormat.valuePickerAnswerFormat(with: textChoices)
            
            let questionStep = ORKQuestionStep(identifier: String(describing:Identifier.valuePickerChoiceQuestionStep), title: titleText, answer: answerFormat)
            
            if (inputtedDetailedDescription != ""){
                questionStep.text = inputtedDetailedDescription
            }else{
                questionStep.text = exampleDetailText
            }
            
            return ORKOrderedTask(identifier: String(describing:Identifier.valuePickerChoiceQuestionStep), steps: [questionStep])
            
        }
        // No inputs? WE NEED TO ERROR CHECK FOR THIS
        let textChoiceOneText = NSLocalizedString("Choice 1", comment: "")
        let textChoiceTwoText = NSLocalizedString("Choice 2", comment: "")
        let textChoiceThreeText = NSLocalizedString("Choice 3", comment: "")
        let textChoiceFourText = NSLocalizedString("Choice 4", comment: "")
        
        // The text to display can be separate from the value coded for each choice:
        let textChoices = [
            ORKTextChoice(text: textChoiceOneText, value: "choice_1" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceTwoText, value: "choice_2" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceThreeText, value: "choice_3" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceFourText, value: "choice_4" as NSCoding & NSCopying & NSObjectProtocol)]
        let answerFormat = ORKAnswerFormat.valuePickerAnswerFormat(with: textChoices)
        
        let questionStep = ORKQuestionStep(identifier: String(describing:Identifier.valuePickerChoiceQuestionStep), title: titleText, answer: answerFormat)
        
        questionStep.text = exampleDetailText
        
        return ORKOrderedTask(identifier: String(describing:Identifier.valuePickerChoiceQuestionStep), steps: [questionStep])
    }

    
    
    
    /**
    A task demonstrating how the ResearchKit framework can be used to determine
    eligibility using a navigable ordered task.
    */
    private var eligibilityTask: ORKTask {
        // Intro step
        let introStep = ORKInstructionStep(identifier: String(describing:Identifier.eligibilityIntroStep))
        introStep.title = NSLocalizedString("Eligibility Task Example", comment: "")
        
        // Form step
        let formStep = ORKFormStep(identifier: String(describing:Identifier.eligibilityFormStep))
        formStep.title = NSLocalizedString("Eligibility", comment: "")
        formStep.text = exampleQuestionText
        formStep.isOptional = false
        
        // Form items
        let textChoices : [ORKTextChoice] = [ORKTextChoice(text: "Yes", value: "Yes" as NSCoding & NSCopying & NSObjectProtocol), ORKTextChoice(text: "No", value: "No" as NSCoding & NSCopying & NSObjectProtocol), ORKTextChoice(text: "N/A", value: "N/A" as NSCoding & NSCopying & NSObjectProtocol)]
        let answerFormat = ORKTextChoiceAnswerFormat(style: ORKChoiceAnswerStyle.singleChoice, textChoices: textChoices)
        
        let formItem01 = ORKFormItem(identifier: String(describing:Identifier.eligibilityFormItem01), text: exampleQuestionText, answerFormat: answerFormat)
        formItem01.isOptional = false
        let formItem02 = ORKFormItem(identifier: String(describing:Identifier.eligibilityFormItem02), text: exampleQuestionText, answerFormat: answerFormat)
        formItem02.isOptional = false
        let formItem03 = ORKFormItem(identifier: String(describing:Identifier.eligibilityFormItem03), text: exampleQuestionText, answerFormat: answerFormat)
        formItem03.isOptional = false
        
        formStep.formItems = [
            formItem01,
            formItem02,
            formItem03
        ]
        
        // Ineligible step
        let ineligibleStep = ORKInstructionStep(identifier: String(describing:Identifier.eligibilityIneligibleStep))
        ineligibleStep.title = NSLocalizedString("You are ineligible to join the study", comment: "")
        
        // Eligible step
        let eligibleStep = ORKCompletionStep(identifier: String(describing:Identifier.eligibilityEligibleStep))
        eligibleStep.title = NSLocalizedString("You are eligible to join the study", comment: "")
        
        // Create the task
        let eligibilityTask = ORKNavigableOrderedTask(identifier: String(describing:Identifier.eligibilityTask), steps: [
            introStep,
            formStep,
            ineligibleStep,
            eligibleStep
            ])
        
        /*
        // Build navigation rules.
        var resultSelector = ORKResultSelector(stepIdentifier: String(describing:Identifier.eligibilityFormStep), resultIdentifier: String(describing:Identifier.eligibilityFormItem01))
        let predicateFormItem01 = ORKResultPredicate.predicateForChoiceQuestionResult(with: resultSelector, expectedAnswerValue: "Yes" as NSCoding & NSCopying & NSObjectProtocol)
        
        resultSelector = ORKResultSelector(stepIdentifier: String(describing:Identifier.eligibilityFormStep), resultIdentifier: String(describing:Identifier.eligibilityFormItem02))
        let predicateFormItem02 = ORKResultPredicate.predicateForChoiceQuestionResult(with: resultSelector, expectedAnswerValue: "Yes" as NSCoding & NSCopying & NSObjectProtocol)
        
        resultSelector = ORKResultSelector(stepIdentifier: String(describing:Identifier.eligibilityFormStep), resultIdentifier: String(describing:Identifier.eligibilityFormItem03))
        let predicateFormItem03 = ORKResultPredicate.predicateForChoiceQuestionResult(with: resultSelector, expectedAnswerValue: "No" as NSCoding & NSCopying & NSObjectProtocol)
        
        let predicateEligible = NSCompoundPredicate(andPredicateWithSubpredicates: [predicateFormItem01, predicateFormItem02, predicateFormItem03])
        let predicateRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [ (predicateEligible, String(describing:Identifier.eligibilityEligibleStep)) ])
        
        eligibilityTask.setNavigationRule(predicateRule, forTriggerStepIdentifier:String(describing:Identifier.eligibilityFormStep))
        
        // Add end direct rules to skip unneeded steps
        let directRule = ORKDirectStepNavigationRule(destinationStepIdentifier: ORKNullStepIdentifier)
        eligibilityTask.setNavigationRule(directRule, forTriggerStepIdentifier:String(describing:Identifier.eligibilityIneligibleStep))
        */
        return eligibilityTask
    }
    
    /// A task demonstrating how the ResearchKit framework can be used to obtain informed consent.
    private var consentTask: ORKTask {
        /*
        Informed consent starts by presenting an animated sequence conveying
        the main points of your consent document.
        */
        let visualConsentStep = ORKVisualConsentStep(identifier: String(describing:Identifier.visualConsentStep), document: consentDocument)
        
        let investigatorShortDescription = NSLocalizedString("Institution", comment: "")
        let investigatorLongDescription = NSLocalizedString("Institution and its partners", comment: "")
        let localizedLearnMoreHTMLContent = NSLocalizedString("Your sharing learn more content here.", comment: "")
        
        /*
        If you want to share the data you collect with other researchers for
        use in other studies beyond this one, it is best practice to get
        explicit permission from the participant. Use the consent sharing step
        for this.
        */
        let sharingConsentStep = ORKConsentSharingStep(identifier: String(describing:Identifier.consentSharingStep), investigatorShortDescription: investigatorShortDescription, investigatorLongDescription: investigatorLongDescription, localizedLearnMoreHTMLContent: localizedLearnMoreHTMLContent)
        
        /*
        After the visual presentation, the consent review step displays
        your consent document and can obtain a signature from the participant.
        
        The first signature in the document is the participant's signature.
        This effectively tells the consent review step which signatory is
        reviewing the document.
        */
        let signature = consentDocument.signatures!.first
        
        let reviewConsentStep = ORKConsentReviewStep(identifier: String(describing:Identifier.consentReviewStep), signature: signature, in: consentDocument)
        
        // In a real application, you would supply your own localized text.
        reviewConsentStep.text = loremIpsumText
        reviewConsentStep.reasonForConsent = loremIpsumText

        return ORKOrderedTask(identifier: String(describing:Identifier.consentTask), steps: [
            visualConsentStep,
            sharingConsentStep,
            reviewConsentStep
            ])
    }
    
    /// This task presents the Account Creation process.
    private var accountCreationTask: ORKTask {
        /*
        A registration step provides a form step that is populated with email and password fields.
        If you wish to include any of the additional fields, then you can specify it through the `options` parameter.
        */
        let registrationTitle = NSLocalizedString("Registration", comment: "")
        let passcodeValidationRegex = "^(?=.*\\d).{4,8}$"
        let passcodeInvalidMessage = NSLocalizedString("A valid password must be 4 and 8 digits long and include at least one numeric character.", comment: "")
        let registrationOptions: ORKRegistrationStepOption = [.includeGivenName, .includeFamilyName, .includeGender, .includeDOB]
        let registrationStep = ORKRegistrationStep(identifier: String(describing:Identifier.registrationStep), title: registrationTitle, text: exampleDetailText, passcodeValidationRegex: passcodeValidationRegex, passcodeInvalidMessage: passcodeInvalidMessage, options: registrationOptions)
        
        /*
        A wait step allows you to upload the data from the user registration onto your server before presenting the verification step.
        */
        let waitTitle = NSLocalizedString("Creating account", comment: "")
        let waitText = NSLocalizedString("Please wait while we upload your data", comment: "")
        let waitStep = ORKWaitStep(identifier: String(describing:Identifier.waitStep))
        waitStep.title = waitTitle
        waitStep.text = waitText
        
        /*
        A verification step view controller subclass is required in order to use the verification step.
        The subclass provides the view controller button and UI behavior by overriding the following methods.
        */
        class VerificationViewController : ORKVerificationStepViewController {
            override func resendEmailButtonTapped() {
                let alertTitle = NSLocalizedString("Resend Verification Email", comment: "")
                let alertMessage = NSLocalizedString("Button tapped", comment: "")
                let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        let verificationStep = ORKVerificationStep(identifier: String(describing:Identifier.verificationStep), text: exampleDetailText, verificationViewControllerClass: VerificationViewController.self)
        
        return ORKOrderedTask(identifier: String(describing:Identifier.accountCreationTask), steps: [
            registrationStep,
            waitStep,
            verificationStep
            ])
    }
    
    
    /// This task demonstrates the Passcode creation process.
    private var passcodeTask: ORKTask {
        /*
        If you want to protect the app using a passcode. It is reccomended to
        ask user to create passcode as part of the consent process and use the
        authentication and editing view controllers to interact with the passcode.
        
        The passcode is stored in the keychain.
        */
        let passcodeConsentStep = ORKPasscodeStep(identifier: String(describing:Identifier.passcodeStep))

        return ORKOrderedTask(identifier: String(describing:Identifier.passcodeStep), steps: [passcodeConsentStep])
    }
    

    /**
        This task presents the Fitness pre-defined active task. For this example,
        short walking and rest durations of 20 seconds each are used, whereas more
        realistic durations might be several minutes each.
    */
    private var fitnessTask: ORKTask {
        return ORKOrderedTask.fitnessCheck(withIdentifier: String(describing:Identifier.fitnessTask), intendedUseDescription: exampleDescription, walkDuration: 20, restDuration: 20, options: [])
    }
    
    /// This task presents the Hole Peg Test pre-defined active task.
    private var holePegTestTask: ORKTask {
        return ORKNavigableOrderedTask.holePegTest(withIdentifier: String(describing:Identifier.holePegTestTask), intendedUseDescription: exampleDescription, dominantHand: .right, numberOfPegs: 9, threshold: 0.2, rotated: false, timeLimit: 300, options: [])
    }
    
    /// This task presents the PSAT pre-defined active task.
    private var PSATTask: ORKTask {
        return ORKOrderedTask.psatTask(withIdentifier: String(describing:Identifier.psatTask), intendedUseDescription: exampleDescription, presentationMode: ORKPSATPresentationMode.auditory.union(.visual), interStimulusInterval: 3.0, stimulusDuration: 1.0, seriesLength: 60, options: [])
    }
    
    /// This task presents the Reaction Time pre-defined active task.
    private var reactionTimeTask: ORKTask {
        /// An example of a custom sound.
        let successSoundURL = Bundle.main.url(forResource:"tap", withExtension: "aif")!
        let successSound = SystemSound(soundURL: successSoundURL)!
        return ORKOrderedTask.reactionTime(withIdentifier: String(describing:Identifier.reactionTime), intendedUseDescription: exampleDescription, maximumStimulusInterval: 10, minimumStimulusInterval: 4, thresholdAcceleration: 0.5, numberOfAttempts: 3, timeout: 3, successSound: successSound.soundID, timeoutSound: 0, failureSound: UInt32(kSystemSoundID_Vibrate), options: [])
    }
    
    /// This task presents the Gait and Balance pre-defined active task.
    private var shortWalkTask: ORKTask {
        return ORKOrderedTask.shortWalk(withIdentifier: String(describing:Identifier.shortWalkTask), intendedUseDescription: exampleDescription, numberOfStepsPerLeg: 20, restDuration: 20, options: [])
    }
    
    /// This task presents the Spatial Span Memory pre-defined active task.
    private var spatialSpanMemoryTask: ORKTask {
        return ORKOrderedTask.spatialSpanMemoryTask(withIdentifier: String(describing:Identifier.spatialSpanMemoryTask), intendedUseDescription: exampleDescription, initialSpan: 3, minimumSpan: 2, maximumSpan: 15, playSpeed: 1.0, maximumTests: 5, maximumConsecutiveFailures: 3, customTargetImage: nil, customTargetPluralName: nil, requireReversal: false, options: [])
    }

    /// This task presents the Timed Walk pre-defined active task.
    private var timedWalkTask: ORKTask {
        return ORKOrderedTask.timedWalk(withIdentifier: String(describing:Identifier.timedWalkTask), intendedUseDescription: exampleDescription, distanceInMeters: 100.0, timeLimit: 180.0,
            includeAssistiveDeviceForm: true, options: [])
    }
    
    /// This task presents the Tone Audiometry pre-defined active task.
    private var toneAudiometryTask: ORKTask {
        return ORKOrderedTask.toneAudiometryTask(withIdentifier: String(describing:Identifier.toneAudiometryTask), intendedUseDescription: exampleDescription, speechInstruction: nil, shortSpeechInstruction: nil, toneDuration: 20, options: [])
    }

    private var towerOfHanoiTask: ORKTask {
        return ORKOrderedTask.towerOfHanoiTask(withIdentifier: String(describing:Identifier.towerOfHanoi), intendedUseDescription: exampleDescription, numberOfDisks: 5, options: [])
    }
    
    /// This task presents the Two Finger Tapping pre-defined active task.
    private var twoFingerTappingIntervalTask: ORKTask {
        return ORKOrderedTask.twoFingerTappingIntervalTask(withIdentifier: String(describing:Identifier.twoFingerTappingIntervalTask), intendedUseDescription: exampleDescription, duration: 10,
        handOptions: [.both], options: [])
    }
    
    /// This task presents a walk back-and-forth task
    private var walkBackAndForthTask: ORKTask {
        return ORKOrderedTask.walkBackAndForthTask(withIdentifier: String(describing:Identifier.walkBackAndForthTask), intendedUseDescription: exampleDescription, walkDuration: 30, restDuration: 30, options: [])
    }
    
    /// This task presents the Tremor Test pre-defined active task.
    private var tremorTestTask: ORKTask {
        return ORKOrderedTask.tremorTest(withIdentifier: String(describing:Identifier.tremorTestTask),
                                                           intendedUseDescription: exampleDescription,
                                                           activeStepDuration: 10,
                                                           activeTaskOptions: [],
                                                           handOptions: [.both],
                                                           options: [])
    }

    // MARK: Consent Document Creation Convenience
    
    /**
        A consent document provides the content for the visual consent and consent
        review steps. This helper sets up a consent document with some dummy
        content. You should populate your consent document to suit your study.
    */
    private var consentDocument: ORKConsentDocument {
        let consentDocument = ORKConsentDocument()
        
        /*
            This is the title of the document, displayed both for review and in
            the generated PDF.
        */
        consentDocument.title = NSLocalizedString("Example Consent", comment: "")
        
        // This is the title of the signature page in the generated document.
        consentDocument.signaturePageTitle = NSLocalizedString("Consent", comment: "")
        
        /* 
            This is the line shown on the signature page of the generated document,
            just above the signatures.
        */
        consentDocument.signaturePageContent = NSLocalizedString("I agree to participate in this research study.", comment: "")
        
        /*
            Add the participant signature, which will be filled in during the
            consent review process. This signature initially does not have a
            signature image or a participant name; these are collected during
            the consent review step.
        */
        let participantSignatureTitle = NSLocalizedString("Participant", comment: "")
        let participantSignature = ORKConsentSignature(forPersonWithTitle: participantSignatureTitle, dateFormatString: nil, identifier: String(describing:Identifier.consentDocumentParticipantSignature))
        
        consentDocument.addSignature(participantSignature)
        
        /*
            Add the investigator signature. This is pre-populated with the
            investigator's signature image and name, and the date of their
            signature. If you need to specify the date as now, you could generate
            a date string with code here.
          
            This signature is only used for the generated PDF.
        */
        let signatureImage = UIImage(named: "signature")!
        let investigatorSignatureTitle = NSLocalizedString("Investigator", comment: "")
        let investigatorSignatureGivenName = NSLocalizedString("Jonny", comment: "")
        let investigatorSignatureFamilyName = NSLocalizedString("Appleseed", comment: "")
        let investigatorSignatureDateString = "3/10/15"

        let investigatorSignature = ORKConsentSignature(forPersonWithTitle: investigatorSignatureTitle, dateFormatString: nil, identifier: String(describing:Identifier.consentDocumentInvestigatorSignature), givenName: investigatorSignatureGivenName, familyName: investigatorSignatureFamilyName, signatureImage: signatureImage, dateString: investigatorSignatureDateString)
        
        consentDocument.addSignature(investigatorSignature)
        
        /* 
            This is the HTML content for the "Learn More" page for each consent
            section. In a real consent, this would be your content, and you would
            have different content for each section.
          
            If your content is just text, you can use the `content` property
            instead of the `htmlContent` property of `ORKConsentSection`.
        */
        let htmlContentString = "<ul><li>Lorem</li><li>ipsum</li><li>dolor</li></ul><p>\(loremIpsumLongText)</p><p>\(loremIpsumMediumText)</p>"
        
        /*
            These are all the consent section types that have pre-defined animations
            and images. We use them in this specific order, so we see the available
            animated transitions.
        */
        let consentSectionTypes: [ORKConsentSectionType] = [
            .overview,
            .dataGathering,
            .privacy,
            .dataUse,
            .timeCommitment,
            .studySurvey,
            .studyTasks,
            .withdrawing
        ]
        
        /*
            For each consent section type in `consentSectionTypes`, create an
            `ORKConsentSection` that represents it.

            In a real app, you would set specific content for each section.
        */
        var consentSections: [ORKConsentSection] = consentSectionTypes.map { contentSectionType in
            let consentSection = ORKConsentSection(type: contentSectionType)
            
            consentSection.summary = loremIpsumShortText
            
            if contentSectionType == .overview {
                consentSection.htmlContent = htmlContentString
            }
            else {
                consentSection.content = loremIpsumLongText
            }
            
            return consentSection
        }
        
        /*
            This is an example of a section that is only in the review document
            or only in the generated PDF, and is not displayed in `ORKVisualConsentStep`.
        */
        let consentSection = ORKConsentSection(type: .onlyInDocument)
        consentSection.summary = NSLocalizedString(".OnlyInDocument Scene Summary", comment: "")
        consentSection.title = NSLocalizedString(".OnlyInDocument Scene", comment: "")
        consentSection.content = loremIpsumLongText
        
        consentSections += [consentSection]
        
        // Set the sections on the document after they've been created.
        consentDocument.sections = consentSections
        
        return consentDocument
    }
    
    // MARK: `ORKTask` Reused Text Convenience
    
    private var exampleDescription: String {
        return NSLocalizedString("Your description goes here.", comment: "")
    }
    
    private var exampleSpeechInstruction: String {
        return NSLocalizedString("Your more specific voice instruction goes here. For example, say 'Aaaah'.", comment: "")
    }
    
    private var exampleQuestionText: String {
        return NSLocalizedString("Your question goes here.", comment: "")
    }
    
    private var exampleHighValueText: String {
        return NSLocalizedString("High Value", comment: "")
    }
    
    private var exampleLowValueText: String {
        return NSLocalizedString("Low Value", comment: "")
    }
    
    private var exampleDetailText: String {
        return NSLocalizedString("Additional text can go here.", comment: "")
    }
    
    private var exampleEmailText: String {
        return NSLocalizedString("jappleseed@example.com", comment: "")
    }
    
    private var loremIpsumText: String {
        return "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
    }
    
    private var loremIpsumShortText: String {
        return "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
    }
    
    private var loremIpsumMediumText: String {
        return "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam adhuc, meo fortasse vitio, quid ego quaeram non perspicis. Plane idem, inquit, et maxima quidem, qua fieri nulla maior potest. Quonam, inquit, modo?"
    }
    
    private var loremIpsumLongText: String {
        return "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam adhuc, meo fortasse vitio, quid ego quaeram non perspicis. Plane idem, inquit, et maxima quidem, qua fieri nulla maior potest. Quonam, inquit, modo? An potest, inquit ille, quicquam esse suavius quam nihil dolere? Cave putes quicquam esse verius. Quonam, inquit, modo?"
    }
    
    public func setDescription(input: String) {
        inputtedDescription = input
    }
    public func getDescription() -> String {
        return inputtedDescription
    }
    public func setDetailedDescription(input: String) {
        inputtedDetailedDescription = input
    }
    public func getDetailedDescription() -> String {
        return inputtedDetailedDescription
    }
    public func setTitle(input: String) {
        inputtedTitle = input
    }
    public func getTitle() -> String {
        return inputtedTitle
    }
    // This is for the "Your unit" Title in numerical question
    public func setUnitPlaceholder(input: String) {
        inputtedUnitPlaceholder = input
    }
    public func getUnitPlaceholder() -> String {
        return inputtedUnitPlaceholder
    }
    // This is for the "Your unit" default text in numerical question
    public func setUnitText(input: String) {
        inputtedUnitText = input
    }
    public func getUnitText() -> String {
        return inputtedUnitText
    }
    public func setChoicesArray(input: [String]) {
        inputtedChoicesArray = input
    }
    public func getChoicesArray() -> [String] {
        return inputtedChoicesArray
    }



    
    public func resetStrings(){
        inputtedDescription = ""
        inputtedDetailedDescription = ""
        inputtedTitle = ""
        inputtedUnitPlaceholder = ""
        inputtedUnitText = ""
        inputtedChoicesArray = [String]()
    }


}
