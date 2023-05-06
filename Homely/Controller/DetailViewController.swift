//
//  DetailViewControllerSK.swift
//  Homely
//
//  Created by Nurmukhanbet Sertay on 26.04.2023.
//

import UIKit


class DetailViewController: UIViewController {
  
    var apartment1 = Apartment()
    let tableView = DetailTableView(frame: .zero, style: .plain)
    let detailUIView = DetailUIView()
    
    private enum UIConstrants {
        static let cornerRadius: CGFloat = 18
        static let cardWidth: CGFloat = 45
        static let tableHeiht: CGFloat = 260
        static let yStackTrailing: CGFloat = 20
        static let cardsToAccountNameSpacing: CGFloat = 12
        static let amountLabelFontSize: CGFloat = 17
    }
    
    func myCustomViewDidDismiss() {
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.apartment = apartment1
        view.backgroundColor = .white
        // MARK: - DetailView Animation
        let startingXPosition = self.view.frame.size.width * 3
        detailUIView.frame = CGRect(x: startingXPosition, y: -200, width: 100, height: 100)
        DetailUIView.animate(withDuration: 1, delay: 0.0, options: .curveEaseInOut, animations: {
            self.detailUIView.frame = CGRect(x: self.view.frame.size.width - self.detailUIView.frame.size.width - 20, y: 100, width: 100, height: 100)
        }, completion: nil)
        
        detailUIView.delegate = self
        detailUIView.backgroundColor = .none
        detailUIView.configure(with: apartment1)
        detailUIView.clipsToBounds = true
        detailUIView.layer.cornerRadius = UIConstrants.cornerRadius
        view.addSubview(detailUIView)
        detailUIView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(55)
            make.bottom.equalTo(detailUIView.snp.bottom).offset(0)
            make.height.equalTo(UIConstrants.tableHeiht)
            make.leading.trailing.equalToSuperview().inset(12)
        }
        
        view.addSubview(tableView)
        
        // MARK: - DetailTableView Animation
        let startingYPosition = self.view.frame.size.height
        tableView.frame = CGRect(x: -200, y: startingYPosition, width: self.view.frame.size.width, height: self.view.frame.size.height)
        DetailTableView.animate(withDuration: 1, delay: 0.0, options: .curveEaseInOut, animations: {
            self.tableView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        }, completion: nil)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(detailUIView.snp.bottom).offset(10)
            make.left.right.bottom.equalToSuperview()
        }
        
        tableView.delegate = self
        
    }
}

extension DetailViewController: MyViewDelegate  {
    func didTapDismissButton() {
        dismiss(animated: true)
    }
}

extension DetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            print("doesn't exist any path")
        case 1:
            let nextVC = MapViewController()
            navigationController?.pushViewController(nextVC, animated: true)
        case 2:
            if let phoneCallURL = URL(string: "tel://\(87082022113)") {
                let application:UIApplication = UIApplication.shared
                if (application.canOpenURL(phoneCallURL)) {
                    application.open(phoneCallURL, options: [:], completionHandler: nil)
                }
            }
        default:
            fatalError("Failed to instantiate the table view cell for deta il view controller")
        }
        
    }
}


