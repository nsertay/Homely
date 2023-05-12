//
//  NewsViewController.swift
//  Homely
//
//  Created by Nurmukhanbet Sertay on 07.05.2023.
//

import UIKit
import SnapKit
import SafariServices

class NewsViewController: UIViewController {
    
    var articles: [Article] = []
    private var viewModels = [NewsTableViewModel]()
    
    private var collectionView: UICollectionView!

    private var mainLabel: UILabel  = {
        let label = UILabel()
        label.text = "News"
        label.numberOfLines = 1
        label.font = UIFont(name: "Nunito-Bold", size: 50.0)
        label.textColor = UIColor(named: "MainColor")
       
        return label
    }()
    
    private var latestLabel: UILabel  = {
        let label = UILabel()
        label.text = "Latest news"
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 35, weight: .bold)
       
        return label
    }()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        
        return table
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        constaintInitialize()
        collectionViewInitialize()
        APIService()
    }
}

extension NewsViewController {
    
    func constaintInitialize() {
       
        view.addSubview(mainLabel)
        mainLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(50)
            make.leading.equalToSuperview().inset(30)
            
        }
        
        view.addSubview(latestLabel)
        latestLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(330)
            make.leading.equalToSuperview().inset(30)
        }
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { make in
            make.top.equalTo(latestLabel.snp.bottom).offset(10)
            make.bottom.leading.trailing.equalToSuperview().inset(5)
        }
      
    }
    
    
    func collectionViewInitialize() {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalToSuperview().inset(120)
            make.height.equalTo(205)
        }
        collectionView.register(NewsCollectionViewCell.self, forCellWithReuseIdentifier: NewsCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        
    }
   
    
    func APIService() {
        APICaller.shared.getTopStories { [weak self] result in
            switch result {
            case .success(let articles):
                self?.viewModels = articles.compactMap({
                    NewsTableViewModel(
                        title: $0.title,
                        subtitle: $0.description ?? "No Desc",
                        url: $0.url ,
                        imageURL: URL(string: $0.urlToImage ?? "")
                    )
                })
                DispatchQueue.main.async {
                    self!.tableView.reloadData()
                    self!.collectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
    }
}

extension NewsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCollectionViewCell.identifier, for: indexPath) as? NewsCollectionViewCell else {
            fatalError()
        }
        cell.imageView.layer.cornerRadius = 30
        cell.imageView.clipsToBounds = true
        cell.configure(with: viewModels[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let url = URL(string: viewModels[indexPath.row].url) else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
//        let rootVC = NewsDetailViewController()
//        rootVC.article = viewModels[indexPath.row]
//
//        let navigationController = UINavigationController(rootViewController: rootVC)
//        navigationController.modalPresentationStyle = .fullScreen
//        present(navigationController, animated: true)
    }
   
}

extension NewsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 350, height: 200)
    }
}


extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell else {
            fatalError()
        }
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        guard let url = URL(string: viewModels[indexPath.row].url) else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
//        let rootVC = NewsDetailViewController()
//        rootVC.article = viewModels[indexPath.row]
//
//        let navigationController = UINavigationController(rootViewController: rootVC)
//        navigationController.modalPresentationStyle = .fullScreen
//        present(navigationController, animated: true)
    }

    
}
