//
//  NewsTableViewCell.swift
//  Homely
//
//  Created by Nurmukhanbet Sertay on 07.05.2023.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    static let identifier = "NewsTableViewCell"
    
    private let newsTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    private let subtileLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 13, weight: .regular)
        return label
    }()
    
    private let newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemRed
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let newsTitlesYStackView = UIStackView()
        
        newsTitlesYStackView.axis = .vertical
        newsTitlesYStackView.addArrangedSubview(newsTitleLabel)
        newsTitlesYStackView.addArrangedSubview(subtileLabel)
        
        
        
        let newsCellXStackView = UIStackView()
        addSubview(newsCellXStackView)
        newsCellXStackView.axis = .horizontal
        newsCellXStackView.addArrangedSubview(newsTitlesYStackView)
        newsCellXStackView.addArrangedSubview(newsImageView)
        newsCellXStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
        }
      
        newsImageView.snp.makeConstraints { make in
            make.width.height.equalTo(150)
            make.top.bottom.trailing.equalToSuperview().inset(5)
        }
        newsImageView.layer.cornerRadius = 15
        
        newsTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            
        }
        
        
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
   
  
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(with viewModel: NewsTableViewModel) {
        newsTitleLabel.text = viewModel.title
        subtileLabel.text = viewModel.subtitle
        
        if let data = viewModel.imageData {
            newsImageView.image = UIImage(data: data)
        } else if let url = viewModel.imageURL {
            
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self?.newsImageView.image = UIImage(data: data)
                }
            }.resume()
        }
        
    }
}
