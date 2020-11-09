//
//  SignUpViewController.swift
//  PPWAuthenticationKonstantinGeorgiev
//
//  Created by Konstantin Georgiev on 12/05/2020.
//  Copyright © 2020 Konstantin Georgiev. All rights reserved.
//


//adding Firebase libraries
import UIKit
import Firebase
import FirebaseAuth


class SignUpViewController: UIViewController, UITextFieldDelegate {

  
    //creating refference for connecting Firebase Database with the project
   var ref: DatabaseReference!
    //referencing the items from the storyboard
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var rePasswordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var lblStrenght: UILabel!
    //function in which aditional set up is being done after loading the view controller
    override func viewDidLoad() {
        super.viewDidLoad()
        //allowing the textfield to be edited in the code in realtime
        passwordTextField.delegate = self
        //setting the refference for the firebase Database
        ref = Database.database().reference()
        //calling the setUpElements function for designing the elements
        setUpElements()
       
    }
    //password checker in realtime
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //counting the lenght of the password
    if(textField == passwordTextField){
       let strLength = textField.text?.count ?? 0
       let lngthToAdd = string.count
       let lengthCount = strLength + lngthToAdd
       let passLenght = lengthCount
        //clean the password
         let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        //
        var containsSpecialCharacter: Bool {
            //variable for the validator regEx for the strenght of the password when its  weak
           let regex = "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{6,}"
           let testString = NSPredicate(format:"SELF MATCHES %@", regex)
            return testString.evaluate(with: cleanedPassword)
        }
        //variable for the regEx validator when the password is Medium
        var containsSpecialCharacterMedium: Bool {
           let regex = "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}"
           let testString = NSPredicate(format:"SELF MATCHES %@", regex)
            return testString.evaluate(with: cleanedPassword)
        }
        //variable for the regEx validation when the password is strong
        var containsSpecialCharacterStrong: Bool {
           let regex = "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{10,}"
           let testString = NSPredicate(format:"SELF MATCHES %@", regex)
            return testString.evaluate(with: cleanedPassword)
        }
        
        //checking if the textbox is empty to show the label
        if passLenght > 0 {
            lblStrenght.alpha = 1
        }
        //checking the strenght of the password
        if  containsSpecialCharacter == false && containsSpecialCharacterMedium == false && containsSpecialCharacterStrong == false {
            
            lblStrenght.textColor = UIColor.magenta
            self.lblStrenght.text = "Weak password"
        }
        if containsSpecialCharacterMedium == true {
            lblStrenght.textColor = UIColor.orange
            lblStrenght.text = "Medium password"
        }
        if containsSpecialCharacterStrong == true {
            lblStrenght.textColor = UIColor.green
            lblStrenght.text = "Strong password"
        }
        //checking if the text fields is empty to hide the label if nothing is written
        if passLenght < 1 {
            lblStrenght.alpha = 0
        }
        
     
    }
    return true
    }
    
    //function for designing the elements
    func setUpElements() {
              
                  // Hide the error label
                  errorLabel.alpha = 0
        lblStrenght.alpha = 0
              
                  // Style the elements
                  Validation.styleTextField(firstNameTextField)
                  Validation.styleTextField(rePasswordTextField)
                  Validation.styleTextField(emailTextField)
                  Validation.styleTextField(passwordTextField)
                  Validation.styleFilledButton(signUpButton)
              }
    
    
    //function for validatin the fields
    func validateFields() -> String? {
        
        // Check that all fields are filled in
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            rePasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields."
        }
        
        // Check if the passwords match
        if passwordTextField.text != rePasswordTextField.text {
            return "The passwords dont match"
        } else {
            //cleaning the password textfield
            let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                   //checking the password and lettting the users know why it has not been accepted
                   if Validation.isPasswordValid(cleanedPassword) == false {
                       // Password isn't secure enough
                    
                       return "Please make sure your password is at least 8 characters, contains a special character and a number."
                   }
                   return nil
        }
        
       
        
        
        
       
    }
    
    //function for sign up button when tapped
    @IBAction func signUpTapped(_ sender: Any) {
        //clearing the label
        lblStrenght.text = ""
        
              let error = validateFields()
         //checking for errors
         if error != nil {
             
             // There's something wrong with the fields, show error message
             showError(error!)
         }
         else {
             
             // Create cleaned versions of the data
             let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
             let repeatPassword = rePasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
             let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
             let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
             
             // Create the user
             Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                  
                 // Check for errors
                 if err != nil {
                     let localizedDescription = err?.localizedDescription
                     // There was an error creating the user
                    self.showError(localizedDescription ?? "Check out thte input information")
                 }
                 else {
                   
                    //calling the transition to home function to go to home screen
                  
                    self.transitionToHome()
                 }
                 
             }
             
             
             
         }
    }
    //function for showing the error
    func showError(_ message:String) {
        
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    //function for transiting ot home screen
    func transitionToHome() {
        
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        
    }
}



