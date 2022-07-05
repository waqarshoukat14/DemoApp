//
//  ViewController.swift
//  DemoApp
//
//  Created by Waqar Mac on 05/07/2022.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
    }
    
   private func setUpUI () {
       
        imageView.layer.cornerRadius = imageView.frame.size.height / 2
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.clipsToBounds = true
        
        loginButton.layer.cornerRadius = 10
        emailTF.layer.cornerRadius = 20
        passwordTF.layer.cornerRadius = 20
    }
    
    

    @IBAction func loginAction(_ sender: Any) {
        
    }
    
}

