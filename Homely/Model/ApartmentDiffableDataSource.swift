//
//  ApartmentDiffableDataSource.swift
//  Homely
//
//  Created by Nurmukhanbet Sertay on 09.04.2023.
//

import Foundation
import UIKit

enum Section {
    case all
}

class ApartmentDiffableDataSource: UITableViewDiffableDataSource<Section, Apartment> {
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}
