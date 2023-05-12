//
//  NewsCollectionViewCell.swift
//  Homely
//
//  Created by Nurmukhanbet Sertay on 07.05.2023.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "NewsTableViewCell"
    
    func configure(with viewModel: NewsTableViewModel) {
        
        if let data = viewModel.imageData {
            imageView.image = UIImage(data: data)
        } else if let url = viewModel.imageURL {
            
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(data: data)
                }
            }.resume()
        }
    }
    
    private let view: UIView = {
        let view = UIView()
        return view
    }()
    
    let imageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Ketshi")
    }
}

private extension NewsCollectionViewCell {
    
    func initialize() {
        
        addSubview(view)
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
