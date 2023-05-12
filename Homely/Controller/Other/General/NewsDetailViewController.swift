//
//  NewsDetailViewController.swift
//  Homely
//
//  Created by Nurmukhanbet Sertay on 10.05.2023.
//

import UIKit
import SnapKit

class NewsDetailViewController: UIViewController {
    
    var article = NewsTableViewModel(title: "", subtitle: "", url: "", imageURL: URL(string: ""))
    
    let newsDetailView = NewsDetailUIView()
    
    let backButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("Back", for: .normal)
        button.backgroundColor = .systemBlue
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(newsDetailView)
        newsDetailView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(260)
        }
        newsDetailView.configure(with: article)
        
        view.addSubview(backButton)
        backButton.addTarget(self, action: #selector(backFunction), for: .touchUpInside)
        backButton.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
        
        
        print("correct")
    }
    
    @objc func backFunction() {
        dismiss(animated: true)
    }
}

extension NewsDetailViewController: MyViewDelegate  {
    func didTapDismissButton() {
        dismiss(animated: true)
    }
}
