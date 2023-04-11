//
//  DetailViewController.swift
//  Homely
//
//  Created by Nurmukhanbet Sertay on 10.04.2023.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var headerView: DetailHeaderView!
    
    var apartment: Apartment = Apartment()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.hidesBarsOnSwipe = true
        

        print(apartment)
        headerView.apartmentNameLabel.text = apartment.name
        headerView.apartmentCityLabel.text = apartment.city
        headerView.apartmentYearLabel.text = apartment.commisDate
        
        if let url = URL(string: apartment.image) {
            let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                guard let self = self, let data = data, error == nil else {
                    print("Error downloading image: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                        
                DispatchQueue.main.async {
                    if let image = UIImage(data: data) {
                        self.headerView.detailImageView.image = image
                    }
                }
            }
            task.resume()
        }
        
    }
    
}
