//
//  RegisterViewController.swift
//  daval_tourinst_app
//
//  Created by Daniel Felipe Valencia Rodriguez on 16/09/22.
//

import Foundation
import UIKit
import FirebaseAuth



class RegisterViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var registerEmailOutlet: UITextField!
    @IBOutlet weak var registerPasswordOutlet: UITextField!
    @IBOutlet weak var pbRegisterOutlet: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pbRegisterOutlet.isHidden = true
        self.registerEmailOutlet.delegate = self
        self.registerPasswordOutlet.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func signInAction(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.frame.origin.y = 0
        return true
    }
    
    @IBAction func regiterToMapAction(_ sender: Any) {
        pbRegisterOutlet.isHidden = false
        pbRegisterOutlet.startAnimating()
        if (isValidEmail(email: registerEmailOutlet.text!)){
            if(isValidPassword(password: registerPasswordOutlet.text!)) {
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
            } else {
                self.pbRegisterOutlet.isHidden = true
                self.pbRegisterOutlet.stopAnimating()
                self.genericAlert(message: "Invalid Password")
            }
            } else {
                self.pbRegisterOutlet.isHidden = true
                self.pbRegisterOutlet.stopAnimating()
                self.genericAlert(message: "Invalid Email")
            }
        }
    
    func subscribeToKeyboardNotifications() {
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        }
        
    func unsubscribeFromKeyboardNotifications() {
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        if (registerEmailOutlet.isFirstResponder || registerPasswordOutlet.isFirstResponder){
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
        
    }
    
    @objc func keyboardWillHide(_notification: Notification) {
        if registerEmailOutlet.isEditing, registerPasswordOutlet.isEditing, view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
    }

    func getKeyboardHeight(_ notification:Notification) -> CGFloat {

        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    }
