//
//  RegisterViewController.swift
//  daval_tourinst_app
//
//  Created by Daniel Felipe Valencia Rodriguez on 16/09/22.
//

import Foundation
import UIKit
import FirebaseAuth



class RegisterViewController: UIViewController {

    
    @IBOutlet weak var registerEmailOutlet: UITextField!
    @IBOutlet weak var registerPasswordOutlet: UITextField!
    @IBOutlet weak var pbRegisterOutlet: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pbRegisterOutlet.isHidden = true
        // Do any additional setup after loading the view.
    }

    @IBAction func regiterToMapAction(_ sender: Any) {
        pbRegisterOutlet.isHidden = false
        pbRegisterOutlet.startAnimating()
        if let email = registerEmailOutlet.text , let password = registerPasswordOutlet.text {
            Auth.auth().createUser(withEmail: email, password: password) {
                (result, error) in
            if let result = result, error == nil {
                self.pbRegisterOutlet.isHidden = true
                self.pbRegisterOutlet.stopAnimating()
                self.performSegue(withIdentifier: "registerToMap", sender: nil)
            }else {
                self.pbRegisterOutlet.isHidden = true
                self.pbRegisterOutlet.stopAnimating()
                let alertController = UIAlertController(title: "Error", message: "Se ha producido un error registrando el usuario", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
                self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
}
