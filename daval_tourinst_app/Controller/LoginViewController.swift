//
//  LoginViewController.swift
//  daval_tourinst_app
//
//  Created by Daniel Felipe Valencia Rodriguez on 16/09/22.
//

import Foundation


import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    

    @IBOutlet weak var loginEmailOutlet: UITextField!
    @IBOutlet weak var loginPasswordOutlet: UITextField!
    @IBOutlet weak var pbLoginOutlet: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pbLoginOutlet.isHidden = true
        // Do any additional setup after loading the view.
    }

    @IBAction func loginToRegisterAction(_ sender: Any) {
        performSegue(withIdentifier: "loginToRegister", sender: nil)
    }
    
    
    @IBAction func loginToMapAction(_ sender: Any) {
        pbLoginOutlet.isHidden = false
        pbLoginOutlet.startAnimating()
        if let email = loginEmailOutlet.text , let password = loginPasswordOutlet.text {
            Auth.auth().signIn(withEmail: email, password: password){
            (result, error) in
            if let result = result, error == nil {
                self.pbLoginOutlet.isHidden = true
                self.pbLoginOutlet.stopAnimating()
                self.performSegue(withIdentifier: "loginToMap", sender: nil)
            }else {
                self.pbLoginOutlet.isHidden = true
                self.pbLoginOutlet.stopAnimating()
                let alertController = UIAlertController(title: "Error", message: "An error has ocurred during login process, please try again!", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
}
}
