//
//  ViewController.swift
//  FirebaseExample
//
//  Created by Joan Cabezas on 21/12/20.
//

import UIKit
import GoogleSignIn
import Firebase

class LoginViewController  : UIViewController {
    
    private var firebaseAuth = Auth.auth()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.delegate = self
        
        if let currentUser = firebaseAuth.currentUser {
            print("Current user \(String(describing: currentUser.displayName))")
            self.performSegue(withIdentifier: "signedInSegue", sender: nil)
        }
        
    }
    
    @IBAction func signInButton(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }
 
}

// MARK: Google Sign In

extension LoginViewController : GIDSignInDelegate{
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        guard let auth = user.authentication else { return }
        let credentials = GoogleAuthProvider.credential(withIDToken: auth.idToken, accessToken: auth.accessToken)
        firebaseAuth.signIn(with: credentials) { (authResult, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                if let result = authResult {
                    let name = result.user.displayName ?? ""
                    let email = result.user.email ?? ""
                    let uid = result.user.uid
                    let user = User(id: nil, createdAt: nil, updatedAt: nil,firebaseUid: uid, name: name, email: email)
                    InterviewAPI().createOrUpdateUser(user: user) {
                        print("Login Successful.")
                        self.performSegue(withIdentifier: "signedInSegue", sender: nil)
                    }
                    
                }
            }
        }
        
    }
}
