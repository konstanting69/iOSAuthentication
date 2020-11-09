//
//  ResetPasswordViewController.swift
//  PPWAuthenticationKonstantinGeorgiev
//
//  Created by Konstantin Georgiev on 20/05/2020.
//  Copyright © 2020 Konstantin Georgiev. All rights reserved.
//

import UIKit
//import firebase dependencies
import Firebase
import FirebaseAuth


class ResetPasswordViewController: UIViewController {
//referencing the items in the storyboard
    @IBOutlet weak var resetPasswordButton: UIButton!
    @IBOutlet weak var txtResetPasswordEmail: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    //function in which aditional set up is being done after loading the view controller
    override func viewDidLoad() {
        super.viewDidLoad()
            //calling setUpElements function to design textfields and buttons
        setUpElements()

        // Do any additional setup after loading the view.
    }
    
    // function when the reset password button is tapped
    @IBAction func resetPasswordTapped(_ sender: Any) {
        
        //calling callFIRPasswordReset function to reset the password
    
            callFIRPasswordReset()
        
        }
    //funciton for reseting Firebase password
    func callFIRPasswordReset(){
          //show loader
        //Firebase request for reseting current users password and sending them email to do it
          Auth.auth().sendPasswordReset(withEmail: self.txtResetPasswordEmail.text!) { (error) in
              DispatchQueue.main.async {
                  //hide loader

                  if let error = error {
                      //show error label
                    self.errorLabel.alpha = 1
                    //show if there is an error localized description straight from the Firebase documentation
                    self.errorLabel.text = error.localizedDescription
                  }
                  else {
                    //show error label
                    self.errorLabel.alpha = 1
                    //leting the user knows that an email has been sent to his email
                    self.errorLabel.text = "We send you an email with instructions on how to reset your password."
                     
                  }
              }
          }
      }
        
    //Designing elemts function
    func setUpElements() {
             
                 //style textfield
        Validation.styleTextField(txtResetPasswordEmail)
        //style button
    Validation.styleFilledButton(resetPasswordButton)
        // Hide the error label
        errorLabel.alpha = 0
             }
        
    

    
     
   
}

