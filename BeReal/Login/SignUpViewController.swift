//
//  SignUpViewController.swift
//  BeReal
//
//  Created by Dana Yerlan on 3/26/23.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround() 
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSignUpTapped(_ sender: Any) {
        guard let username = usernameField.text,
                     let email = emailField.text,
                     let password = passwordField.text,
                     !username.isEmpty,
                     !email.isEmpty,
                     !password.isEmpty else {

                   showMissingFieldsAlert()
                   return
               }

               // TODO: Pt 1 - Parse user sign up
               var newUser = User()
               newUser.username = username
               newUser.email = email
               newUser.password = password

               newUser.signup { [weak self] result in

                   switch result {
                   case .success(let user):

                       print("✅ Successfully signed up user \(user)")

                       // Post a notification that the user has successfully signed up.
                       NotificationCenter.default.post(name: Notification.Name("login"), object: nil)

                   case .failure(let error):
                       // Failed sign up
                       self?.showAlert(description: error.localizedDescription)
                   }
               }

           }

           private func showAlert(description: String?) {
               let alertController = UIAlertController(title: "Unable to Sign Up", message: description ?? "Unknown error", preferredStyle: .alert)
               let action = UIAlertAction(title: "OK", style: .default)
               alertController.addAction(action)
               present(alertController, animated: true)
           }

           private func showMissingFieldsAlert() {
               let alertController = UIAlertController(title: "Opps...", message: "We need all fields filled out in order to sign you up.", preferredStyle: .alert)
               let action = UIAlertAction(title: "OK", style: .default)
               alertController.addAction(action)
               present(alertController, animated: true)
           }
       }

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
