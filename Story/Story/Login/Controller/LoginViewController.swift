//
//  LoginViewController.swift
//  Story
//
//  Created by Aries Dwi Prasetiyo on 11/06/20.
//  Copyright © 2020 Aries Dwi Prasetiyo. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
         self.navigationController?.isNavigationBarHidden = true

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func Login (_ sender:UIButton){
        let email :String = emailTextField.text!
        let pin :String = passwordTextField.text!
        
         
         if email.isEmpty || pin.isEmpty {
             print("is empty")
         }
         
         if (email == "aries@gmail.com" && pin == "1234" ){
             print("true")
            
             performSegue(withIdentifier: "AfterLogin", sender: self)
             
         }else{
             print("false")
         }
    }
}
