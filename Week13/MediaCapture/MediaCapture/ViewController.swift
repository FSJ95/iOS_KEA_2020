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
    @IBOutlet weak var bottomImageTextField: UITextField!
    @IBOutlet weak var choosePictureButton: UIButton!
    @IBOutlet weak var addTextButton: UIButton!
    
//    Will handle fetching the image from the system
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func choosePictureButtonTapped(_ sender: Any) {
        showImagePickerNavigation()
    }
    
    @IBAction func addTextButtonTapped(_ sender: Any) {
        if let topText = imageTextField.text {
            if let bottomText = bottomImageTextField.text {
            if let image = imageView.image {
                let topImage = textToImage(drawText: topText, inImage: image, atPoint: CGPoint(x: 0, y: 0))
                let topBottomImage = textToImage(drawText: bottomText, inImage: topImage, atPoint: CGPoint(x: 0, y: topImage.size.height-100))
                imageView.image = topBottomImage
            }
          }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let p = touches.first?.location(in: view) {
            imageView.transform = CGAffineTransform(translationX: p.x, y: 0)
        }
    }
    
    func textToImage(drawText: String, inImage: UIImage, atPoint: CGPoint) -> UIImage{

        // Setup the font specific variables
        let textColor = UIColor.white;
        let textFont = UIFont(name: "Helvetica Bold", size: 100)!

        // Setup the image context using the passed image
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(inImage.size, false, scale)

        // Setup the font attributes that will be later used to dictate how the text should be drawn
        let textFontAttributes = [
            NSAttributedString.Key.font: textFont,
            NSAttributedString.Key.foregroundColor: textColor,
        ]

        // Put the image into a rectangle as large as the original image
        inImage.draw(in: CGRect(x: 0, y: 0, width: inImage.size.width, height: inImage.size.height))

        // Create a point within the space that is as bit as the image
        let rect = CGRect(x: atPoint.x, y: atPoint.y, width: inImage.size.width, height: inImage.size.height)

        // Draw the text into an image
        drawText.draw(in: rect, withAttributes: textFontAttributes)

        // Create a new image out of the images we have created
        let newImage = UIGraphicsGetImageFromCurrentImageContext()

        // End the context now that we have the image we need
        UIGraphicsEndImageContext()
        //Pass the image back up to the caller
        return newImage!
    }
    
    // Remove keyboard when a touch is detected.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        imageTextField.endEditing(true)
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


