    //
    //  DetailUIView.swift
    //  Homely
    //
    //  Created by Nurmukhanbet Sertay on 26.04.2023.
    //

    import UIKit
    import SnapKit

    protocol MyViewDelegate: AnyObject {
        func didTapDismissButton()
    }

    class DetailUIView: UIView {
        
        weak var delegate: MyViewDelegate?
       
        func configure(with info: Apartment) {
            apartmentImageView.image = UIImage(named: "esentay")
            
//            if let url = URL(string: info.image) {
//                let task = URLSession.shared.dataTask(with: url) { data, response, error in
//                    guard let data = data, error == nil else {
//                        print("Error downloading image: \(error?.localizedDescription ?? "Unknown error")")
//                        return
//                    }
//
//                    DispatchQueue.main.async {
//                        if let image = UIImage(data: data) {
//                            self.apartmentImageView.image = image
//                        }
//                    }
//                }
//                task.resume()
//            }
        }
        
        init() {
            super.init(frame: .zero)
            
            initialize()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private let apartmentImageView: UIImageView = {
            
            let view = UIImageView()
            return view
        }()
        
        private enum UIConstrants {
            static let cornerRadius: CGFloat = 18
            static let ButtonHeightWidth: CGFloat = 35
            static let ButtonConstarints: CGFloat = 20
            
        }
        
        private enum UIColors {
            static let labelColor = UIColor(named: "labelColorWhite")
            static let blackWithOpacityLow = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        }
      
        
    }

    private extension DetailUIView {
        
        func initialize() {
            
            apartmentImageView.clipsToBounds = true
            apartmentImageView.layer.cornerRadius = UIConstrants.cornerRadius
            addSubview(apartmentImageView)
            apartmentImageView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
     
            let shareButton = UIButton()
            shareButton.setImage(UIImage(systemName: "square.and.arrow.down"), for: .normal)
            shareButton.tintColor = UIColors.labelColor
            shareButton.backgroundColor = UIColors.blackWithOpacityLow
            shareButton.layer.cornerRadius = UIConstrants.cornerRadius
            apartmentImageView.addSubview(shareButton)
            shareButton.snp.makeConstraints { make in
                make.height.width.equalTo(UIConstrants.ButtonHeightWidth)
                make.trailing.top.equalToSuperview().inset(UIConstrants.ButtonConstarints)
            }
            
            let backButton = UIButton()
            backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
            backButton.tintColor = .white
            backButton.backgroundColor = UIColors.blackWithOpacityLow
            backButton.layer.cornerRadius = UIConstrants.cornerRadius
            apartmentImageView.addSubview(backButton)
            backButton.snp.makeConstraints { make in
                make.height.width.equalTo(UIConstrants.ButtonHeightWidth)
                make.leading.top.equalToSuperview().inset(UIConstrants.ButtonConstarints)
            }
            
            let backButtonHidden = UIButton()
            backButtonHidden.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
            addSubview(backButtonHidden)
            backButtonHidden.snp.makeConstraints { make in
                make.height.width.equalTo(UIConstrants.ButtonHeightWidth)
                make.leading.top.equalToSuperview().inset(UIConstrants.ButtonConstarints)
            }
            
        }

        @objc private func dismissButtonTapped() {
            delegate?.didTapDismissButton()
        }
           
    }
