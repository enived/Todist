//
//  TodoItem.swift
//  Todist
//
//  Created by Patrick Devine on 7/17/16.
//  Copyright © 2016 interview.assignment. All rights reserved.
//

import Foundation

class TodoItem {
    var displayDescription: String
    var notes: String
    var deadline: NSDate
    var progression: ProgressStatus
    var priority: Priority!
    var isUrgent: Bool
    var isImportant: Bool
    
    init(displayDescription: String, notes: String, dueDate: NSDate, progression: ProgressStatus, isUrgent: Bool, isImportant: Bool) {
        self.displayDescription = displayDescription
        self.notes = notes
        self.deadline = dueDate
        self.progression = progression
        self.isUrgent = isUrgent
        self.isImportant = isImportant
        self.priority = priorityScore(isImportant, isUrgent: isUrgent)
    }
    
    class func createEmpty() -> TodoItem {
        return TodoItem(displayDescription: "", notes: "", dueDate: NSDate(), progression: .NotStarted, isUrgent: false, isImportant: false)
    }
    
    /*              
                The Eisenhower Priority Matrix
     
                    Urgent  |   Not Urgent
        important:     1           2
    not Important:     3           4
     
     */
    func priorityScore(isImportant: Bool, isUrgent: Bool) -> Priority {
        if isImportant {
            if isUrgent {
                return .ImportantUrgent
            } else {
                return .ImportantNotUrgent
            }
        } else {
            if isUrgent {
                return .NotImportantUrgent
            }
        }
        return .NotImportantNotUrgent
    }
}


enum Priority : Int {
    case ImportantUrgent
    case ImportantNotUrgent
    case NotImportantUrgent
    case NotImportantNotUrgent
    
    var description: String {
        switch self {
        case .ImportantUrgent : return "Important Urgent"
        case .ImportantNotUrgent : return "Important"
        case .NotImportantUrgent : return "Urgent"
        case .NotImportantNotUrgent : return "Eliminate"
        }
    }
}

enum ProgressStatus : Int  {
    case NotStarted
    case InProgress
    case Impeded
    case Complete
    
    var description: String {
        switch self {
        case .NotStarted : return "Not started"
        case .InProgress : return "In progress"
        case .Complete : return "Complete"
        case .Impeded : return "Impeded"
        }
    }
}
