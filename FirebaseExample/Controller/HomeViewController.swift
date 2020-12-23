//
//  HomeViewController.swift
//  FirebaseExample
//
//  Created by Joan Cabezas on 21/12/20.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {
    
    @IBOutlet weak var usersTableView: UITableView!
    private var users = [User]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usersTableView.delegate = self
        usersTableView.dataSource = self
        
        InterviewAPI().getUsers { (users) in
            self.users = users
            print("Users received \(users.count)")
            self.usersTableView.reloadData()
        }
    }
    
    @IBAction func logoutButtonPressed(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            print("Sign out successful")
//            dismiss(animated: true, completion: nil)
            navigationController?.popViewController(animated: true)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "userViewCell") as? UserViewCell {
            cell.setUserData(user: users[indexPath.row])
            return cell
        }
        return UserViewCell()
    }
}
