//
//  ViewController.swift
//  questionBank
//
//  Created by oguz on 9.01.2020.
//  Copyright © 2020 oğuz hendekci. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var wrongEmailLabel: UILabel!
    @IBOutlet weak var wrongPasswordLabel: UILabel!
    @IBOutlet weak var wrongUsernameLabel: UILabel!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    
    

    @IBAction func signUpButton(_ sender: Any) {
        var email = self.emailTextfield.text
        var isSuccess = true
        if validateEmail(email: email) == false {
            wrongEmailLabel.text = "lütfen formata uygun bir email adresi giriniz"
        isSuccess = false
    
            
        }
            var password = self.passwordTextfield.text
        if isValidatePassword(password: password) == false {
        
            wrongPasswordLabel.text = "lütfen en az 6 haneli bir şifre giriniz"
            isSuccess = false
            
        }
        
       
            
        
        if isSuccess == true {
            Auth.auth().createUser(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { (authData, error) in
            
                if error !=  nil {
                   
                }else{
                self.performSegue(withIdentifier: "toCategoryVC", sender: nil)
                }
            }
        }
        
    }
    
    @IBAction func goToLogin(_ sender: Any) {
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
        
      }
    func validateEmail(email:String?) -> Bool {

        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: email)

    }
    func isValidatePassword(password: String?) -> Bool {
        
        return passwordTextfield.text?.count ?? 0 >= 6
    }

    
  
   
    
    }
   



