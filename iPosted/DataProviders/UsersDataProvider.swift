//
//  UsersDataProvider.swift
//  iPosted
//
//  Created by Antonio da Silva on 19/08/2017.
//  Copyright © 2017 TNTStudios. All rights reserved.
//

import Foundation
import UIKit

protocol DidSelectUserDelegate: class {
    func didSelectUser(atIndex: Int)
}

class UsersDataProvider: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Variables
    
    var users: [User]?
    weak var delegate: DidSelectUserDelegate?
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        let rows = users?.count ?? 0
        if rows == 0 {
            tableView.setEmptyMessage("No users found, pull to refresh...".localized)
        }  else {
            tableView.restore()
        }
        return rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserCell
        if let user = users?[indexPath.row] {
            cell.configCell(with: user)
        }
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.didSelectUser(atIndex: indexPath.row)
    }
    
}
