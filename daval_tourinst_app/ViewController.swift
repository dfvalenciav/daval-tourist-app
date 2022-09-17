//
//  ViewController.swift
//  daval_tourinst_app
//
//  Created by Daniel Felipe Valencia Rodriguez on 11/09/22.
//

import UIKit
import FirebaseAnalytics
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var passwordoOutlet: UITextField!
    @IBOutlet weak var emailOtlet: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Analytics.logEvent("init analytics", parameters: ["message" : "scree initialization"])
    }

    @IBAction func LoginAction(_ sender: Any) {
        if let email = emailOtlet.text, let password = passwordoOutlet.text {
            Auth.auth().createUser(withEmail: email, password: password) {
                (result, error) in
                if let result = result ,  error == nil {
                    print("usuario registrado")
                } else {
                    print("error al registrar")
                }
            }
        }
           
    }
    
}

