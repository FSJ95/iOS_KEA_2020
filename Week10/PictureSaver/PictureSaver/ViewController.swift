//
//  ViewController.swift
//  PictureSaver
//
//  Created by Frederik Søndergaard Jensen on 06/03/2020.
//  Copyright © 2020 Frederik Søndergaard Jensen. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var viewButton: UIButton!
    var chosenImage: UIImage!
    let storage = Storage.storage(url:"gs://picturesaver-f6310.appspot.com/")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }

    @IBAction func uploadButtonTapped(_ sender: Any) {
        showImagePickerNavigation()
    }
    
    @IBAction func viewButtonTapped(_ sender: Any) {
        

    }
    
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
        }
        dismiss(animated: true, completion: nil)
    }
    
    // function for uploading image to google storage
    func uploadImage(image: UIImage) {
        let storageRef = storage.reference()
        let folderRef = storageRef.child("images/" + randomAlphaNumericString(length: 10))
        
        if let imageData = image.jpegData(compressionQuality: 0.1) {
            
            let uploadTask = folderRef.putData(imageData, metadata: nil) { (metadata, error) in
              guard let metadata = metadata else {
                // Uh-oh, an error occurred!
                return
              }
              // Metadata contains file metadata such as size, content-type.
              let size = metadata.size
              // You can also access to download URL after upload.
              folderRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                  // Uh-oh, an error occurred!
                  return
                }
              }
            }
        }
        
    }
    
    // CREATE RANDOM NAME FOR PATH
    func randomAlphaNumericString(length: Int) -> String {
        let allowedChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let allowedCharsCount = UInt32(allowedChars.count)
        var randomString = ""

        for _ in 0..<length {
            let randomNum = Int(arc4random_uniform(allowedCharsCount))
            let randomIndex = allowedChars.index(allowedChars.startIndex, offsetBy: randomNum)
            let newCharacter = allowedChars[randomIndex]
            randomString += String(newCharacter)
        }

        return randomString
    }
    
    
}
