//
//  ViewController.swift
//  Todist
//
//  Created by Patrick Devine on 7/17/16.
//  Copyright © 2016 interview.assignment. All rights reserved.
//
import Foundation

private var _instance: TodoListDataStore?

class TodoListDataStore {
    
    // default sample data
    var todoList: [TodoItem] = [TodoItem(displayDescription: "This is an over due task", notes: "This is a test for the notes section", dueDate: NSDate(), progression: .InProgress, isUrgent: false, isImportant: true),TodoItem(displayDescription: "This task is due tomorrow", notes: "", dueDate: NSDate().dateByAddingTimeInterval(NSTimeInterval(86400)), progression: .NotStarted, isUrgent: true, isImportant: true), TodoItem(displayDescription: "Example completed task", notes: "this task was completed", dueDate: NSDate(), progression: .Complete, isUrgent: true, isImportant: true)]
    class func getInstance() -> TodoListDataStore {
        if _instance == nil {
            _instance = TodoListDataStore()
        }
        return _instance!
    }
    
    
    func sort() {
        todoList.sortInPlace { (todo1, todo2) -> Bool in
            if todo1.priority == todo2.priority {
                return todo1.deadline.compare(todo2.deadline) == .OrderedAscending
            }
            return todo1.priority.rawValue < todo2.priority.rawValue
        }
    }
    
    func addTodoItem(newItem: TodoItem) {
        todoList.append(newItem)
        sort()
    }
    
    func removeTodoItem(index: Int) {
        todoList.removeAtIndex(index)
    }
    
    func completionPercentage() -> Float {
        var todosCompleted: Float = 0.0
        for todoItem in todoList {
            if todoItem.progression == .Complete {
                todosCompleted = todosCompleted + 1
            }
        }
        return todosCompleted / Float(todoList.count)
    }
    
}
