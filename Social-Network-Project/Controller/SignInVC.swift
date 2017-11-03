//
//  ViewController.swift
//  Social-Network-Project
//
//  Created by Ben Gimbel on 11/2/17.
//  Copyright © 2017 Ben Gimbel. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase

class SignInVC: UIViewController {
    
    @IBOutlet weak var emailField: FancyField!
    @IBOutlet weak var passwordField: FancyField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func facebookBtnTapped(_ sender: Any) {

        let facebookLogin = FBSDKLoginManager()

        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("BEN: Unable to login with Facebook - \(String(describing: error))")
            } else if result?.isCancelled == true {
                print("BEN: User cancelled Facebook authentication")
            } else {
                print("BEN: Successfully authenticated with Facebook")
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
        }

    }

    func firebaseAuth(_ credential: AuthCredential) {
        Auth.auth().signIn(with: credential) { (user, error) in
            if error != nil {
                print("BEN: Unable to authenticate with Firebase - \(String(describing: error))")
            } else {
                print("BEN: Successfully authenticated with Firebase")
            }
        }}
    
    @IBAction func signInTapped(_ sender: Any) {
        
        if let email = emailField.text, let pwd = passwordField.text {
            Auth.auth().signIn(withEmail: email, password: pwd, completion: { (user, error) in
                if error == nil {
                    print("BEN: Email user authenticated with Firebase")
                } else {
                    Auth.auth().createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        if error != nil {
                            print("BEN: Unable to authenticate with Firebase email")
                        } else {
                            print("BEN: Successfully authenticated with Firebase")
                        }
                    })
                }
            })
        }
    
    }
    
}

