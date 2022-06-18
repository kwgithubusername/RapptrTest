//
//  LoginViewController.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit

class LoginViewController: UIViewController {
    
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     * 1) Make the UI look like it does in the mock-up.
     *
     * 2) Take email and password input from the user
     *
     * 3) Use the endpoint and paramters provided in LoginClient.m to perform the log in
     *
     * 4) Calculate how long the API call took in milliseconds
     *
     * 5) If the response is an error display the error in a UIAlertController
     *
     * 6) If the response is successful display the success message AND how long the API call took in milliseconds in a UIAlertController
     *
     * 7) When login is successful, tapping 'OK' in the UIAlertController should bring you back to the main menu.
     **/
    
    // MARK: - Properties
    private var client: LoginClient?
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        let alpha = 0.5
        emailTextField.backgroundColor = .white.withAlphaComponent(alpha)
        passwordTextField.backgroundColor = .white.withAlphaComponent(alpha)

        title = "Login"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    @IBAction private func backAction(_ sender: Any) {
        let mainMenuViewController = MenuViewController()
        self.navigationController?.pushViewController(mainMenuViewController, animated: true)
    }
    
    @IBAction private func didPressLoginButton(_ sender: Any) {
        guard let email = emailTextField.text else {
            print("No email")
            return
        }
        
        guard let password = passwordTextField.text else {
            print("No password")
            return
        }
        
        if client == nil {
            client = LoginClient()
        }
        
        client?.login(email: email, password: password, completion: { milliseconds in
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Login Success: Response time was \(milliseconds) milliseconds.", message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    self.navigationController?.popViewController(animated: true)
                }))
                self.navigationController?.present(alert, animated: true)
            }
        }, error: { errorString in
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Login Error", message: errorString, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.navigationController?.present(alert, animated: true)
            }
        })
    }
}
