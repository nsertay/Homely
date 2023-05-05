//
//  DetailMapCell.swift
//  Homely
//
//  Created by Nurmukhanbet Sertay on 27.04.2023.
//

import UIKit
import MapKit

class DetailMapCell: UITableViewCell {

    var mapView = MKMapView()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    func initialize() {
        
        addSubview(mapView)
        mapView.layer.cornerRadius = 20
        mapView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(15)
            make.top.bottom.equalToSuperview().inset(10)
            make.height.equalTo(120)
        }
        
    }

}
