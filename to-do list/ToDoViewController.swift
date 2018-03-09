//
//  ToDoViewController.swift
//  to-do list
//
//  Created by Paulina Van der Doe on 02/03/2018.
//  Copyright © 2018 Paulina Van der Doe. All rights reserved.
//

import UIKit

class ToDoViewController: UITableViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var isCompleteButton: UIButton!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var dueDatePickerView: UIDatePicker!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var isPickerHidden = true
    var todo: ToDo?
    
    /// Notes can only be saved if not empty.
    func updateSaveButtonState() {
        let text = titleTextField.text ?? ""
            saveButton.isEnabled = !text.isEmpty
    }
    
    /// Update label to show chosen time.
    func updateDueDateLabel(date: Date) {
        dueDateLabel.text = ToDo.dueDateFormatter.string(from: date)
    }
    
    /// Shows existing information on todo screen.
    override func viewDidLoad() {
        super.viewDidLoad()
        if let todo = todo {
            navigationItem.title = "To-Do"
            titleTextField.text = todo.title
            isCompleteButton.isSelected = todo.isComplete
            dueDatePickerView.date = todo.dueDate
            notesTextView.text = todo.notes
            
        // If new todo is selected only show current time.
        } else {
            dueDatePickerView.date =
                Date().addingTimeInterval(24*60*60)
        }

        // Update and save changes.
        updateDueDateLabel(date: dueDatePickerView.date)
        updateSaveButtonState()
    }
    
    /// Function for adjusting cell height.
    override func tableView(_ tableView: UITableView, heightForRowAt
        indexPath: IndexPath) -> CGFloat {
        let normalCellHeight = CGFloat(44)
        let largeCellHeight = CGFloat(200)
        
        // If date picker is selected switch to large cell height,
        // if unselected switch back to normal cell height.
        switch(indexPath) {
        case [1,0]: //Due Date Cell
            return isPickerHidden ? normalCellHeight:
            largeCellHeight
            
        // Make notes cell large cell height.
        case [2,0]: //Notes Cell
            return largeCellHeight
        
        // Normal cell height for rest of cells.
        default: return normalCellHeight
        }
    }
    
    /// Update color is date picker is hidden.
    override func tableView(_ tableView: UITableView, didSelectRowAt
        indexPath: IndexPath) {
        switch (indexPath) {
        case [1,0]:
            isPickerHidden = !isPickerHidden

            dueDateLabel.textColor =
                isPickerHidden ? .black : tableView.tintColor

            tableView.beginUpdates()
            tableView.endUpdates()
            
        default: break
        }
    }

    /// Saves information for when editing is complete.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "saveUnwind" else { return }
        
        let title = titleTextField.text!
        let isComplete = isCompleteButton.isSelected
        let dueDate = dueDatePickerView.date
        let notes = notesTextView.text

        todo = ToDo(title: title, isComplete: isComplete, dueDate: dueDate, notes: notes)
    }
 
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        updateDueDateLabel(date: dueDatePickerView.date)
    }
    
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    @IBAction func returnPressed(_ sender: UITextField) {
        titleTextField.resignFirstResponder()
    }
    
    @IBAction func isCompleteButtonTapped(_ sender: UIButton) {
        isCompleteButton.isSelected = !isCompleteButton.isSelected
    }
    
}


