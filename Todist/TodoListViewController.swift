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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        TodoListDataStore.getInstance().sort()
        let completionFloat = TodoListDataStore.getInstance().completionPercentage()
        progressBar.setProgress(completionFloat, animated: true)
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
    
}

extension TodoListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TodoListDataStore.getInstance().todoList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("todoItemTableViewCell", forIndexPath: indexPath) as! TodoItemTableViewCell
        let todoItem: TodoItem = TodoListDataStore.getInstance().todoList[indexPath.row]
        cell.displayDescription.text = todoItem.displayDescription
        cell.progress.text = todoItem.progression.description
        cell.deadline.text = stringFromNSDate(todoItem.deadline)
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
            return UIColor.grayColor().colorWithAlphaComponent(CGFloat(0.5))
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
}



