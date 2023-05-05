//
//  DetailTableView.swift
//  Homely
//
//  Created by Nurmukhanbet Sertay on 26.04.2023.
//

import UIKit

class DetailTableView: UITableView {

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        self.dataSource = self
        self.delegate = self
        self.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.register(DetailTableViewCell.self, forCellReuseIdentifier: "descriptionCell")
        self.register(DetailMapCell.self, forCellReuseIdentifier: "mapCell")
        self.register(DetailCallCell.self, forCellReuseIdentifier: "callCell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var apartment = Apartment()
}

extension DetailTableView: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let firstIdentifier = "descriptionCell"
        let secondIdentifier = "mapCell"
        let thirdIdentifier = "callCell"
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: firstIdentifier, for: indexPath) as! DetailTableViewCell
            cell.descriptionText.text = "Комнаты изолированы, тихий двор. ЖК Tamerlan от застройщика Tumar Group.  сдача 3кв 2023года. Успейте приобрести квартиру от надежного застройщика.  квартира по переуступки прав. Возможен обмен на Авто. По остальным вопросам обращайтесь по телефону! Комнаты изолированы, тихий двор. ЖК Tamerlan от застройщика Tumar Group."
            cell.cityText.text = apartment.city
            cell.commisDateText.text = apartment.commisDate
            cell.addressText.text = apartment.address
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: secondIdentifier, for: indexPath) as! DetailMapCell
            cell.selectionStyle = .none
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: thirdIdentifier, for: indexPath) as! DetailCallCell
            cell.selectionStyle = .none
            return cell
        default:
            fatalError("Failed to instantiate the table view cell for deta il view controller")
        }
        
    }

}



