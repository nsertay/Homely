//
//  NewsDetailUIView.swift
//  Homely
//
//  Created by Nurmukhanbet Sertay on 10.05.2023.
//

import UIKit

class NewsDetailUIView: UIView {
    
    weak var delegate: MyViewDelegate?
   
    func configure(with viewModel: NewsTableViewModel) {
        
        if let data = viewModel.imageData {
            newsImage.image = UIImage(data: data)
        } else if let url = viewModel.imageURL {
            
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self?.newsImage.image = UIImage(data: data)
                }
            }.resume()
        }
    }
    
    init() {
        super.init(frame: .zero)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let newsImage: UIImageView = {
        
        let view = UIImageView()
        return view
    }()
    
    private enum UIConstrants {
        static let cornerRadius: CGFloat = 18
        static let ButtonHeightWidth: CGFloat = 35
        static let ButtonTop: CGFloat = 40
        static let ButtonLeading: CGFloat = 20
        
    }
    
    private enum UIColors {
        static let labelColor = UIColor(named: "labelColorWhite")
        static let blackWithOpacityLow = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
    }

}

private extension NewsDetailUIView {
    
    func initialize() {
        addSubview(newsImage)
        newsImage.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(260)
        }
        
        let shareButton = UIButton()
        shareButton.setImage(UIImage(systemName: "square.and.arrow.down"), for: .normal)
        shareButton.tintColor = UIColors.labelColor
        shareButton.backgroundColor = UIColors.blackWithOpacityLow
        shareButton.layer.cornerRadius = UIConstrants.cornerRadius
        newsImage.addSubview(shareButton)
        shareButton.snp.makeConstraints { make in
            make.height.width.equalTo(UIConstrants.ButtonHeightWidth)
            make.trailing.equalToSuperview().inset(UIConstrants.ButtonLeading)
            make.top.equalToSuperview().inset(UIConstrants.ButtonTop)
        }
        
        let backButton = UIButton()
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.tintColor = .white
        backButton.backgroundColor = UIColors.blackWithOpacityLow
        backButton.layer.cornerRadius = UIConstrants.cornerRadius
        newsImage.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.height.width.equalTo(UIConstrants.ButtonHeightWidth)
            make.top.equalToSuperview().inset(UIConstrants.ButtonTop)
            make.leading.equalToSuperview().inset(UIConstrants.ButtonLeading)
            
        }
        
        let backButtonHidden = UIButton()
        addSubview(backButtonHidden)
        backButtonHidden.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
        backButtonHidden.snp.makeConstraints { make in
            make.height.width.equalTo(UIConstrants.ButtonHeightWidth)
            make.top.equalToSuperview().inset(UIConstrants.ButtonTop)
            make.leading.equalToSuperview().inset(UIConstrants.ButtonLeading)
        }
        
        
    }
    @objc private func dismissButtonTapped() {
        delegate?.didTapDismissButton()
    }
    
}
