//
//  ViewController.swift
//  Notebook
//
//  Created by Frederik Søndergaard Jensen on 21/02/2020.
//  Copyright © 2020 Frederik Søndergaard Jensen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var inputTextView: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var noteTableView: UITableView!
    
    let fileLocationPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("notefile.txt")
    var noteArray = [String]()
    let noteSeperator = "\n***\n"
    let notePlaceholder = "Type your notes in here :)"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputTextView.delegate = self
        noteTableView.delegate = self
        noteTableView.dataSource = self
        saveButton.layer.cornerRadius = 5
        inputTextView.layer.cornerRadius = 5
        noteTableView.layer.cornerRadius = 5
        
        inputTextView.text = notePlaceholder
        inputTextView.textColor = UIColor.lightGray
        
        loadNoteFile()
    }
    
    // Remove the placeholder when editing begins
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
                textView.text = nil
                textView.textColor = UIColor.black
        }
    }
    
    // Number of cells in tableview.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteArray.count
    }
    
    // Populate each cell in the tableview.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notecell")
        cell?.textLabel?.text = noteArray[indexPath.row]
        return cell!
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        inputTextView.endEditing(true)
        
        
        if inputTextView.textColor != UIColor.lightGray {
            let inputText = inputTextView.text
            noteArray.reverse()
            noteArray.append(inputText ?? "")
            noteArray.reverse()
             
            saveNoteFile()
            
            // Return to the 'placeholder' state.
            inputTextView.text = notePlaceholder
            inputTextView.textColor = UIColor.lightGray
        }
        
    }
    
    // Loading the notefile
    func loadNoteFile() {
        do {
            let string = try String(contentsOf: fileLocationPath, encoding: .utf8)
            noteArray = string.components(separatedBy: noteSeperator)
            print(noteArray)
        } catch  {
            print("Error loading the file")
        }
        noteTableView.reloadData()
    }
    
    // Saving to notefile
    func saveNoteFile() {
        let fullNoteString = noteArray.joined(separator: noteSeperator)
        do {
            try fullNoteString.write(to: fileLocationPath, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print("Error writing to file")
        }
        loadNoteFile()
    }
    
    //delete function, swipe on the item to delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
        self.noteArray.remove(at: indexPath.row)
        saveNoteFile()
      }
    }
    
}

