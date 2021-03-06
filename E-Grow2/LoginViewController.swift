//
//  LoginViewController.swift
//  E-Grow2
//
//  Created by Kamryn Ohly on 11/7/20.
//  Copyright © 2020 Kamryn Ohly. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        loginButton.layer.cornerRadius = 22
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = UIColor.init(red: 224/255, green: 224/255, blue: 224/255, alpha: 1).cgColor
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
        //TODO: Login the user
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            
            if error != nil {
                print(error!)
                
                let alert = UIAlertController(title: "Please Try Again", message: "Incorrect email or password.", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Okay", style: .cancel) { (action) in
                    print("Okay Pressed")
                }
                alert.addAction(cancelAction)
                self.present(alert, animated: true, completion: nil)
                
            }
            else {
                

                let userID = Auth.auth().currentUser?.uid
                let ref = Database.database().reference().child("users").child(userID!).child("personalInfo")
                
                ref.observe(.value) { (snapshot) in
                    let snapshotThing = snapshot.value as? [String : String] ?? [:]
                    if snapshotThing["name"] != nil {
                        print("Login Successful")
                        self.performSegue(withIdentifier: "goToHome", sender: self)
                    }
                    else {
                        print("This user exists, but something went wrong.")
                    }
                }
            }
            
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
