//
//  DetailCallCell.swift
//  Homely
//
//  Created by Nurmukhanbet Sertay on 27.04.2023.
//

import UIKit
import SnapKit

class DetailCallCell: UITableViewCell {

    let callButton = UIButton()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    func initialize() {
        
        addSubview(callButton)
        callButton.setTitle("Call", for: .normal)
        callButton.titleLabel?.font = UIFont(name: "Nunito-Bold", size: 20)
        callButton.setTitleColor(.white, for: .normal)
        callButton.layer.cornerRadius = 10
        callButton.backgroundColor = UIColor(named: "MainColor")
        callButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(5)
            make.leading.trailing.equalToSuperview().inset(15)
            make.height.equalTo(50)
        }
    }
}
