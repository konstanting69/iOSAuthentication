//
//  HomeViewController.swift
//  PPWAuthenticationKonstantinGeorgiev
//
//  Created by Konstantin Georgiev on 20/05/2020.
//  Copyright © 2020 Konstantin Georgiev. All rights reserved.
//

//importing Firebase libraries
import UIKit
import Firebase
import FirebaseAuth

class HomeViewController: UIViewController {
//referencing the items in the storyboard
    @IBOutlet weak var verifyEmailButton: UIButton!
    @IBOutlet weak var logOutButotn: UIButton!
    //function in which aditional set up is being done after loading the view controller
    override func viewDidLoad() {
        super.viewDidLoad()
        //calling isEmailVerified to check if the email of the user has been verified
        isEmailVerified()
        setUpElements()
        

       
    }
    //Checking if the email of the user has been verified and show in the view to let the user knows
    func isEmailVerified() {
        //variable for current user
        let user = Auth.auth().currentUser
        
        if user!.isEmailVerified {
            verifyEmailButton.alpha = 0
        } else {
           
            verifyEmailButton.alpha = 1
        }
    }
        
            
   
    func setUpElements() {
                    
                      
        Validation.styleFilledButton(logOutButotn)
                    }
    
    
    
   
   
    @IBAction func verifyButtonTapped(_ sender: Any) {
       Auth.auth().currentUser?.sendEmailVerification { (error) in
        if error != nil {
            print("problem with")
        } else {
            let user = Auth.auth().currentUser
            user?.reload { (error) in
                switch user!.isEmailVerified {
            case true:
                self.isEmailVerified()
            case false:
                self.isEmailVerified()
        }
    
    
    }
        }
        }
    }
    @IBAction func logOutButtonTapped(_ sender: Any) {
        logOut()
        toRootViewController()
    }
    
    
    func toRootViewController() {
        let rootViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.rootViewController) as?
         RootViewController
         self.view.window?.rootViewController = rootViewController
         self.view.window?.makeKeyAndVisible()
    }
    func logOut() {
    let firebaseAuth = Auth.auth()
               do {
                 try firebaseAuth.signOut()
                   
               } catch let signOutError as NSError {
                 print ("Error signing out: %@", signOutError)
               }
    
    }
}
