//
//  ViewController.swift
//  Todist
//
//  Created by Patrick Devine on 7/17/16.
//  Copyright © 2016 interview.assignment. All rights reserved.
//

import UIKit

class AddOrEditTodoItemViewController: UIViewController {

    @IBOutlet weak var displayDescription: UITextField!
    @IBOutlet weak var progress: UIPickerView!
    @IBOutlet weak var notes: UITextView!
    @IBOutlet weak var isUrgent: UISwitch!
    @IBOutlet weak var isImportant: UISwitch!
    @IBOutlet weak var deadline: UIDatePicker!
    @IBOutlet weak var saveButton: UIButton!
    
    var index: Int?
    var todoItem: TodoItem?
    override func viewDidLoad() {
        super.viewDidLoad()

        if nil == index {
            todoItem = TodoItem.createEmpty()
        } else {
            todoItem = TodoListDataStore.getInstance().todoList[index!]
            displayDescription.text = todoItem!.displayDescription
            isUrgent.on = todoItem!.isUrgent
            isImportant.on = todoItem!.isImportant
            deadline.date = todoItem!.deadline
            notes.text = todoItem!.notes
            progress.selectRow(todoItem!.progression.rawValue, inComponent: 0, animated: false)
        }
        
        // Keyboard was not disappearing on
        let tapAnywhere: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddOrEditTodoItemViewController.dismissKeyboard))
        view.addGestureRecognizer(tapAnywhere)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func save() {
        let progressionStatus: ProgressStatus = ProgressStatus(rawValue: progress.selectedRowInComponent(0))!
        let newTodoItem: TodoItem = TodoItem(displayDescription: displayDescription.text!, notes: notes.text, dueDate: deadline.date, progression: progressionStatus, isUrgent: isUrgent.on, isImportant: isImportant.on)
        
        if index == nil {
            TodoListDataStore.getInstance().addTodoItem(newTodoItem)
        } else {
            TodoListDataStore.getInstance().todoList[index!] = newTodoItem
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}



extension AddOrEditTodoItemViewController : UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 4
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ProgressStatus(rawValue: row)?.description
    }
    
}
