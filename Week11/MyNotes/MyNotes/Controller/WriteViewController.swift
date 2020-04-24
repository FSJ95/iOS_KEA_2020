//
//  ViewController.swift
//  MyNotes
//
//  Created by Frederik Søndergaard Jensen on 16/03/2020.
//  Copyright © 2020 Frederik Søndergaard Jensen. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class WriteViewController: UIViewController, UIGestureRecognizerDelegate, UITextViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var appTitle: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet weak var imageLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var saveButton: UIButton!
    
    // Firebase variables.
    var db: Firestore!
    var usr: User!
    let storage = Storage.storage(url:"gs://mynotes-4136d.appspot.com/")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Force the interface into lightmode >:)
        overrideUserInterfaceStyle = .light
        
        // Add UITapGestureRecognizer to the imageView (tap event).
        let UITapRecognizer = UITapGestureRecognizer(target: self, action: #selector(WriteViewController.imageTapped(_:)))
        UITapRecognizer.delegate = self
        self.imageView.addGestureRecognizer(UITapRecognizer)
        self.imageView.isUserInteractionEnabled = true
        
        // Setting delegates
        noteTextView.delegate = self
        titleTextField.delegate = self
        
        // Firebase auth stuff.
        usr = Auth.auth().currentUser
        db = Firestore.firestore()
    }
    
    // Opens the image source navigator, runs after the image is tapped.
    @objc func imageTapped(_ sender: UITapGestureRecognizer) {
        showImagePickerNavigation()
    }
    
    // Function runs when the saveButton is tapped.
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        // Check if there is a title, text and the image is not the placeholder.
        if let noteTitle = self.titleTextField.text {
            if let noteText = self.noteTextView.text {
                    // Adds the note fields to the firestore database.
                    self.db.collection("users").document(self.usr.uid).collection("notes").document().setData([
                        "title": noteTitle,
                        "text": noteText,
                        "image": titleTextField.text!.replacingOccurrences(of: " ", with: "_"),
                        "date": NSDate().timeIntervalSince1970
                    ]) { err in
                        if err != nil {
                        
                            // There was an error uploading the note.
                            // Display alert with a custom message.
                            self.showAlert(msg: "Could not add note, please try again.", success: false)
                            
                        } else {
                            
                            // The note was uploaded successfully.
                            // Display alert with a custom message.
                            self.showAlert(msg: "Note added!", success: true)
                            
                            // Reset the fields/image back to empty.
                            self.reset()
                    }
                }
            }
        }
    }
    
    // Function to reset note form
    func reset() {
        self.titleTextField.text = ""
        self.noteTextView.text = ""
        self.imageView.image = UIImage(systemName: "plus")
    }
    
    // Remove keyboard when a touch is detected.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        titleTextField.endEditing(true)
        noteTextView.endEditing(true)
    }
    
    // Show alerts with message and success/error title
    func showAlert(msg: String, success: Bool) {
        var alertController: UIAlertController!
        if (success) {
            alertController = UIAlertController(title: "Success", message:
                msg, preferredStyle: .alert)
        } else {
            alertController = UIAlertController(title: "Error", message:
                msg, preferredStyle: .alert)
        }
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
}

//MARK: IMAGE PICKER & NAVIGATION CONTROLLER
extension WriteViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // function to present the alert for picking sourcetype
    func showImagePickerNavigation() {
        let alert = UIAlertController(title: "Choose your image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Photo libary", style: .default, handler: { action in
            self.showImagePickerController(sourceType: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { action in
            self.showImagePickerController(sourceType: .camera)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    // function to present imagepickercontroller
    func showImagePickerController(sourceType: UIImagePickerController.SourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = false
        imagePickerController.sourceType = sourceType
        present(imagePickerController, animated: true, completion: nil)
    }
    
    // function to use and dismiss the imagepickercontroller when image picked
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            uploadImage(image: originalImage)
            imageView.image = originalImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    // function for uploading image to google storage
    func uploadImage(image: UIImage) {
        let folderRef = storage.reference().child("images/" + titleTextField.text!.replacingOccurrences(of: " ", with: "_"))
        if let imageData = image.jpegData(compressionQuality: 0.1) {
            _ = folderRef.putData(imageData, metadata: nil) { (metadata, error) in
            }
        }
    }
}
