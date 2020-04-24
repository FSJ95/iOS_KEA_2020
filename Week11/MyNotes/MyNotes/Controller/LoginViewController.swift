//
//  LoginViewController.swift
//  MyNotes
//
//  Created by Frederik Søndergaard Jensen on 03/04/2020.
//  Copyright © 2020 Frederik Søndergaard Jensen. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    var auth = Auth.auth()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Force the interface into lightmode >:)
        overrideUserInterfaceStyle = .light
    
    }
    
    @IBAction func signInButtonPressed(_ sender: Any) {
        showSignInAlert()
    }
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        showSignUpAlert()
    }
    
    // Show the alert prompt to add a title
    func showSignUpAlert() {
        var emailTextField: UITextField?
        var passwordTextField: UITextField?
        var alertController: UIAlertController!
        
        // Creating the AlertController
        alertController = UIAlertController(title: "Sign up", message:
            "Type your information to sign up", preferredStyle: .alert)
        
        // Creating the save button and creates the marker when pressed.
        let userInfo = UIAlertAction(title: "Sign up", style: .cancel) { (save) in
            if let email = emailTextField?.text {
                if let password = passwordTextField?.text {
            
                    self.signUp(email: email, password: password)
                }
            }
            
        }
        
        // Create and adds the texfield to the AlertController
        alertController.addTextField { (emailField) in
            emailTextField = emailField
            emailTextField?.placeholder = "email"
        }
        
        // Create and adds the texfield to the AlertController
        alertController.addTextField { (passwordField) in
            passwordTextField = passwordField
            passwordTextField?.placeholder = "password"
        }
        
        // Adds the save button to the AlertController
        alertController.addAction(userInfo)
        
        // Present the AlertController to the user
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    // Show the alert prompt to add a title
    func showSignInAlert() {
        var emailTextField: UITextField?
        var passwordTextField: UITextField?
        var alertController: UIAlertController!
        
        // Creating the AlertController
        alertController = UIAlertController(title: "Sign in", message:
            "Type your information to sign in", preferredStyle: .alert)
        
        // Creating the save button and creates the marker when pressed.
        let userInfo = UIAlertAction(title: "Sign in", style: .cancel) { (save) in
            if let email = emailTextField?.text {
                if let password = passwordTextField?.text {
            
                    self.signIn(email: email, password: password)
                }
            }
            
        }
        
        // Create and adds the texfield to the AlertController
        alertController.addTextField { (emailField) in
            emailTextField = emailField
            emailTextField?.placeholder = "email"
        }
        
        // Create and adds the texfield to the AlertController
        alertController.addTextField { (passwordField) in
            passwordTextField = passwordField
            passwordTextField?.placeholder = "password"
        }
        
        // Adds the save button to the AlertController
        alertController.addAction(userInfo)
        
        // Present the AlertController to the user
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    func signUp(email:String, password: String) {
        auth.createUser(withEmail: email, password: password) { (result, error) in
            if error == nil {
                print(error.debugDescription)
                print("Ikke oprettet bruger")
            } else {
                self.signIn(email: email, password: password)
            }
        }
    }
    
    func signIn(email:String, password: String) {
        auth.signIn(withEmail: email, password: password) { (result, error) in
            if error == nil {
                print("Ikke logget ind")
            } else {
                print("Logget ind")
                let vc = self.storyboard!.instantiateViewController(withIdentifier: "tabvc") as! UITabBarController
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
    
    
}
