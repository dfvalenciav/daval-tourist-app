//
//  LoginViewController.swift
//  daval_tourinst_app
//
//  Created by Daniel Felipe Valencia Rodriguez on 16/09/22.
//

import Foundation


import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    

    @IBOutlet weak var loginEmailOutlet: UITextField!
    @IBOutlet weak var loginPasswordOutlet: UITextField!
    @IBOutlet weak var pbLoginOutlet: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pbLoginOutlet.isHidden = true
        self.loginEmailOutlet.delegate = self
        self.loginPasswordOutlet.delegate = self
        // Do any additional setup after loading the view.
    }

    @IBAction func loginToRegisterAction(_ sender: Any) {
        performSegue(withIdentifier: "loginToRegister", sender: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.frame.origin.y = 0
        return true
    }
    
    
    @IBAction func loginToMapAction(_ sender: Any) {
        pbLoginOutlet.isHidden = false
        pbLoginOutlet.startAnimating()
        if (isValidEmail(email: loginEmailOutlet.text ?? "")){
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
                    self.genericAlert(message: error!.localizedDescription as String)
                    }
                }
            }
        } else {
            self.pbLoginOutlet.isHidden = true
            self.pbLoginOutlet.stopAnimating()
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
        if (loginEmailOutlet.isFirstResponder || loginPasswordOutlet.isFirstResponder){
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
        
    }
    
    @objc func keyboardWillHide(_notification: Notification) {
        if loginEmailOutlet.isEditing, loginEmailOutlet.isEditing, view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
    }

    func getKeyboardHeight(_ notification:Notification) -> CGFloat {

        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
}
