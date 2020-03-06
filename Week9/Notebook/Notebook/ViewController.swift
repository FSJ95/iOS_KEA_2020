//
//  ViewController.swift
//  Notebook
//
//  Created by Frederik Søndergaard Jensen on 21/02/2020.
//  Copyright © 2020 Frederik Søndergaard Jensen. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UITextViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var inputTextView: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var noteTableView: UITableView!
    
    var noteArray = [String]()
    var titleArray = [String]()
    
    let notePlaceholder = "Type your notes in here :)"
    
    var db: Firestore!
    var usr: User!
    
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
        
        Auth.auth().signInAnonymously() { (authResult, error) in
        }
        usr = Auth.auth().currentUser
        
        db = Firestore.firestore()
        
        loadNoteFile()
        
    }
    
    // MARK: FUNCTIONS
    

    // Loading the notefile
    func loadNoteFile() {
        noteArray = [String]()
        db.collection("users").document(usr.uid).collection("messages").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    self.noteArray.append(document.data()["message"] as! String)
                    self.titleArray.append(document.documentID)
                    
                }
                self.noteTableView.reloadData()
            }
        }
        
    }
    
    // MARK: BUTTON
    @IBAction func saveButtonTapped(_ sender: Any) {
        inputTextView.endEditing(true)
        
        
        if inputTextView.textColor != UIColor.lightGray {
            let inputText = inputTextView.text
            db.collection("users").document(usr.uid).collection("messages").document().setData([
                "message": inputText!,
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
            }
             
            loadNoteFile()
            
            // Return to the 'placeholder' state.
            inputTextView.text = notePlaceholder
            inputTextView.textColor = UIColor.lightGray
        }
        
    }
    
    // MARK: TABLEVIEW
    
    //delete function, swipe on the item to delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
        self.noteArray.remove(at: indexPath.row)
        db.collection("users").document(usr.uid).collection("messages").document(titleArray[indexPath.row]).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
        loadNoteFile()
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
    
    // MARK: TEXTVIEW
    
    // Remove the placeholder when editing begins
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
                textView.text = nil
                textView.textColor = UIColor.black
        }
    }
}

