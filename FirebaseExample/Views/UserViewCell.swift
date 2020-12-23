//
//  UserViewCell.swift
//  FirebaseExample
//
//  Created by Joan Cabezas on 21/12/20.
//

import UIKit

class UserViewCell: UITableViewCell {
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    
    func setUserData(user: User) -> Void {
        userNameLabel.text = user.name
        userEmailLabel.text = user.email
    }
}
