//
//  ViewController.swift
//  MediaCapture
//
//  Created by Frederik Søndergaard Jensen on 27/03/2020.
//  Copyright © 2020 Frederik Søndergaard Jensen. All rights reserved.
//

import UIKit


// ALLOW THE FOLLOWING:
// Privacy - Photo Library Usage Description
// Privacy - Photo Library Additions Usage Description
// Privacy - Microphone Usage Description
// Privacy - Camera Usage Description

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var choosePictureButton: UIButton!
    
//    Will handle fetching the image from the system
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func choosePictureButtonTapped(_ sender: Any) {
        showImagePickerNavigation()
    }
    
}




//MARK: IMAGE PICKER & NAVIGATION CONTROLLER
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
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = sourceType
        present(imagePickerController, animated: true, completion: nil)
    }
    
    // function to use and dismiss the imagepickercontroller when image picked
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        imageView.image = editedImage
        dismiss(animated: true, completion: nil)
    }
    
}


