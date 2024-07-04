//
//  UITableViewCell.swift
//  TestCoreData
//
//  Created by Vineeth on 04/07/24.
//

import UIKit

extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
    
    static func registerNib(tableView: UITableView) {
        tableView.register(UINib(nibName: Self.identifier, bundle: nil), forCellReuseIdentifier: Self.identifier)
    }
}
