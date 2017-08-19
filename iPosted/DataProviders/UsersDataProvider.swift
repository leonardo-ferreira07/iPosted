//
//  UsersDataProvider.swift
//  iPosted
//
//  Created by Antonio da Silva on 19/08/2017.
//  Copyright © 2017 TNTStudios. All rights reserved.
//

import Foundation
import UIKit

class UsersDataProvider : NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var users: [User]?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        return users?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath)
    }

    
}