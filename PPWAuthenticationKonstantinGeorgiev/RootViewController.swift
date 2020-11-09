//
//  RootViewController.swift
//  PPWAuthenticationKonstantinGeorgiev
//
//  Created by Konstantin Georgiev on 20/05/2020.
//  Copyright © 2020 Konstantin Georgiev. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
  // Refferencing the items from the storyboard
    @IBOutlet weak var SignUpButton: UIButton!
    
    @IBOutlet weak var LogInButton: UIButton!
    //function in which aditional set up is being done after loading the view controller
    override func viewDidLoad() {
        super.viewDidLoad()
        //calling setUpElements
        setUpElements()

        // Do any additional setup after loading the view.
    }
    
//function for styling the elements
     func setUpElements() {
                 
                   
        Validation.styleFilledButton(LogInButton)
        Validation.styleHollowButton(SignUpButton)
                 }
}
