//
//  DetailTableViewCell.swift
//  Homely
//
//  Created by Nurmukhanbet Sertay on 26.04.2023.
//

import UIKit
import SnapKit

class DetailTableViewCell: UITableViewCell {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    private enum UIConstraints {
        static let labelSize: CGFloat = 20
    }
    
    private enum UIFonts {
        static let mainFont = UIFont(name: "Nunito-Bold", size: UIConstraints.labelSize)
    }
    
    private enum UIColors {
        static let labelColor = UIColor(named: "labelColorWhite")
        static let staticLabelColor = UIColor.gray
        static let dynamicLabelColor = UIColor.black
        static let homelyColor = UIColor(named: "MainColor")
        
    }
    
    private let aboutApartmentFooter: UILabel = {
        
        let label = UILabel()
        label.text = "About apartment"
        label.textColor = UIColors.homelyColor
        label.font = UIFonts.mainFont
        return label
    }()
    
    private let cityFooter: UILabel = {
        
        let label = UILabel()
        label.text = "City"
        label.textColor = UIColors.staticLabelColor
        label.font = UIFonts.mainFont
        return label
    }()
    
    let cityText: UILabel = {
        
        let label = UILabel()
        label.textColor = UIColors.dynamicLabelColor
        label.font = UIFonts.mainFont
        return label
    }()
    
    private let addressFooter: UILabel = {
        
        let label = UILabel()
        label.text = "Address"
        label.textColor = UIColors.staticLabelColor
        label.font = UIFonts.mainFont
        return label
    }()
    
    let addressText: UILabel = {
        
        let label = UILabel()
        label.textColor = UIColors.dynamicLabelColor
        label.font = UIFonts.mainFont
        return label
    }()
    
    private let commisDateFooter: UILabel = {
        
        let label = UILabel()
        label.text = "Commis date"
        label.textColor = UIColors.staticLabelColor
        label.font = UIFonts.mainFont
        return label
    }()
    
    let commisDateText: UILabel = {
        
        let label = UILabel()
        label.textColor = UIColors.dynamicLabelColor
        label.font = UIFonts.mainFont
        return label
    }()
    
    private let descriptionFooter: UILabel = {
        
        let label = UILabel()
        label.text = "Description"
        label.textColor = UIColors.homelyColor
        label.font = UIFonts.mainFont
        return label
    }()
    
   let descriptionText: UILabel = {
        
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private let view: UIView = {
        
        let view = UIView()
        return view
    }()

    func initialize() {
        
        let cityXStackView = UIStackView()
        let commisXStackView = UIStackView()
        let addressXStackView = UIStackView()
    
        addSubview(view)
        
        view.addSubview(aboutApartmentFooter)
        aboutApartmentFooter.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
        }
        
        view.addSubview(cityXStackView)
        cityXStackView.addArrangedSubview(cityFooter)
        cityXStackView.addArrangedSubview(cityText)
        cityXStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalTo(aboutApartmentFooter.snp.top).inset(35)
        }
        
        view.addSubview(addressXStackView)
        addressXStackView.addArrangedSubview(addressFooter)
        addressXStackView.addArrangedSubview(addressText)
        addressXStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalTo(cityXStackView.snp.top).inset(25)
        }
        
        view.addSubview(commisXStackView)
        commisXStackView.addArrangedSubview(commisDateFooter)
        commisXStackView.addArrangedSubview(commisDateText)
        commisXStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalTo(addressXStackView.snp.top).inset(25)
        }
        
        view.addSubview(descriptionFooter)
        descriptionFooter.snp.makeConstraints { make in
            make.top.equalTo(commisXStackView.snp.top).inset(35)
            make.leading.equalToSuperview().inset(10)
        }
        
        view.addSubview(descriptionText)
        descriptionText.snp.makeConstraints { make in
            make.top.equalTo(descriptionFooter.snp.top).inset(25)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        view.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(descriptionText.snp.height).offset(155)
            make.top.bottom.equalToSuperview().inset(5)
        }
    }
}
