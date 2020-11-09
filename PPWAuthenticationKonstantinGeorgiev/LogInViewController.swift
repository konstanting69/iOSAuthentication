//
//  LogInViewController.swift
//  PPWAuthenticationKonstantinGeorgiev
//
//  Created by Konstantin Georgiev on 19/05/2020.
//  Copyright © 2020 Konstantin Georgiev. All rights reserved.
//


//importing the Firebase libraries
import UIKit
import Firebase
import FirebaseAuth

class LogInViewController: UIViewController {

  
//refferencing the items from the storyboard
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var LogInButton: UIButton!
    
    //function in which aditional set up is being done after loading the view controller
    override func viewDidLoad() {
        super.viewDidLoad()
        //calling setUpElemets for the elements design
        setUpElements()
        // Do any additional setup after loading the view.
    }
    //function for styling the elements
    func setUpElements() {
                
                    // Hide the error label
                    errorLabel.alpha = 0
                
                    // Style the elements
        Validation.styleFilledButton(LogInButton)
                
                    Validation.styleTextField(emailTextField)
        
                    Validation.styleTextField(passwordTextField)
                  
                }
    
    //function for validating the fields
    func validateFields() -> String? {
           
           // Check that all fields are filled in and clearing them from whitespaces and new lines
           if
               emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
               passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
               
                 return "Please fill in all fields."
           }
      
           return "Please fill in all fields"
           
           
           }
           
          
       

    //function for Log in Button tapped
    @IBAction func logInTapped(_ sender: Any) {
       // Create cleaned versions of the text field
              let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
              let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
              
              // Signing in the user in Firebase with email and password
              Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                  //checking if there is an error
                  if error != nil {
                      // Couldn't sign in
                      self.errorLabel.text = error!.localizedDescription
                    //showing the label in which the error will be shown
                      self.errorLabel.alpha = 1
                  }
                  else {
                      //transition to the home view controller/screen
                      let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
                      
                      self.view.window?.rootViewController = homeViewController
                      self.view.window?.makeKeyAndVisible()
                  }
              }
}

}
