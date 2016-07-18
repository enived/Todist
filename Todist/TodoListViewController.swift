//
//  ViewController.swift
//  Todist
//
//  Created by Patrick Devine on 7/17/16.
//  Copyright © 2016 interview.assignment. All rights reserved.
//

import UIKit

class TodoListViewController: UIViewController {

    @IBOutlet weak var addTask: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var progressBar: UIProgressView!

    var shouldHideCompletedTodo = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        TodoListDataStore.getInstance().sort()
        updateProgressBar()
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addNewTodo() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let addOrEditTodoItemVC = storyboard.instantiateViewControllerWithIdentifier("AddOrEditTodoItem")
        self.presentViewController(addOrEditTodoItemVC, animated: true, completion: nil)
    }
    
    @IBAction func toggleShowCompletedTodos() {
        shouldHideCompletedTodo = !shouldHideCompletedTodo
        tableView.reloadData()
    }
    func updateProgressBar() {
        let completionFloat = TodoListDataStore.getInstance().completionPercentage()
        progressBar.setProgress(completionFloat, animated: true)
    }
}

extension TodoListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TodoListDataStore.getInstance().todoList.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let defaultHeight: CGFloat = CGFloat(45)
        let todoItem: TodoItem = TodoListDataStore.getInstance().todoList[indexPath.row]
        if todoItem.progression == .Complete {
            if shouldHideCompletedTodo {
                return CGFloat(0)
            } else {
                return defaultHeight
            }
        }
        let priority: Priority = todoItem.priority
        switch priority {
            case .ImportantUrgent : return defaultHeight + 25
            case .ImportantNotUrgent : return defaultHeight + 15
            case .NotImportantUrgent : return defaultHeight + 10
            default : return defaultHeight
        }
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("todoItemTableViewCell", forIndexPath: indexPath) as! TodoItemTableViewCell
        let todoItem: TodoItem = TodoListDataStore.getInstance().todoList[indexPath.row]

        cell.displayDescription.text = todoItem.displayDescription
        cell.progress.text = todoItem.progression.description
        cell.deadline.text = stringFromNSDate(todoItem.deadline)
        cell.priorityLabel.text = todoItem.priority.description
        if todoItem.progression == .Complete {
            cell.backgroundColor = UIColor.greenColor().colorWithAlphaComponent(CGFloat(0.5))
        } else {
            cell.backgroundColor = determineCellBackgroundColor(todoItem.priority)
        }
        return cell
    }
    
    func determineCellBackgroundColor(priority: Priority) -> UIColor {
        switch priority {
        case .ImportantUrgent:
            return UIColor.redColor().colorWithAlphaComponent(CGFloat(0.5))
        case .ImportantNotUrgent:
            return UIColor.orangeColor().colorWithAlphaComponent(CGFloat(0.5))
        case .NotImportantUrgent:
            return UIColor.yellowColor().colorWithAlphaComponent(CGFloat(0.5))
        case .NotImportantNotUrgent:
            return UIColor.grayColor().colorWithAlphaComponent(CGFloat(0.2))
        }
    }
    
    func stringFromNSDate(date: NSDate) -> String {
        let dateFormatter: NSDateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.timeStyle = .ShortStyle
        return dateFormatter.stringFromDate(date)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let addOrEditTodoItemVC: AddOrEditTodoItemViewController = storyboard.instantiateViewControllerWithIdentifier("AddOrEditTodoItem") as! AddOrEditTodoItemViewController
        addOrEditTodoItemVC.index = indexPath.row
        self.presentViewController(addOrEditTodoItemVC, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let completeAction: UITableViewRowAction = UITableViewRowAction(style: .Normal, title: "Done!") { (action: UITableViewRowAction, index:NSIndexPath) in
            TodoListDataStore.getInstance().todoList[index.row].progression = .Complete
            self.updateProgressBar()
            tableView.reloadData()
        }
        completeAction.backgroundColor = UIColor.greenColor()
        let deleteAction: UITableViewRowAction = UITableViewRowAction(style: .Destructive, title: "Remove") { (action:UITableViewRowAction, index:NSIndexPath) in
            TodoListDataStore.getInstance().removeTodoItem(index.row)
            self.updateProgressBar()
            tableView.reloadData()
        }
        deleteAction.backgroundColor = UIColor.redColor()
        return [deleteAction,completeAction]
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
}



