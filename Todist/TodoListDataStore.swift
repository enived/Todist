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
    var todoList: [TodoItem] = [TodoItem(displayDescription: "Todo item test first", notes: "This is a test for the notes section", dueDate: NSDate(), progression: .InProgress, isUrgent: false, isImportant: true),TodoItem(displayDescription: "Todo item test second", notes: "This is a test for the notes section", dueDate: NSDate(), progression: .NotStarted, isUrgent: true, isImportant: true)]
    class func getInstance() -> TodoListDataStore {
        if _instance == nil {
            _instance = TodoListDataStore()
        }
        return _instance!
    }
    
    
    func sort() {
        todoList.sortInPlace { $0.deadline.compare($1.deadline) == .OrderedAscending }
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
