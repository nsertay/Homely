//
//  MainTableViewController.swift
//  Homely
//
//  Created by Nurmukhanbet Sertay on 06.04.2023.
//

import UIKit
import Firebase
import FirebaseStorage


class MainTableViewController: UITableViewController {
    
    let db = Firestore.firestore()
    let storage = Storage.storage()
   
    var apartments: [Apartment] = []
    
    lazy var dataSource = configureDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = dataSource

        getData()
    }
    
    func getData() {
            
            db.collection("apartments").getDocuments { (querySnapshot, error) in
                guard let querySnapshot = querySnapshot else {
                    print("Error getting documents: \(error!.localizedDescription)")
                    return
                }
                for document in querySnapshot.documents {
                    let data = document.data()
                        
                    let apartment = Apartment(
                        name: data["name"] as? String ?? "",
                        price: data["price"] as? String ?? "",
                        address: data["address"] as? String ?? "",
                        city: data["city"] as? String ?? "",
                        commisDate: data["commisDate"] as? String ?? "",
                        image: data["image"] as? String ?? ""
                    )
                    self.apartments.append(apartment)
                }
                  
                var snapshot = NSDiffableDataSourceSnapshot<Section, Apartment>()
                snapshot.appendSections([.all])
                snapshot.appendItems(self.apartments, toSection: .all)
                self.dataSource.apply(snapshot, animatingDifferences: false)
            }
        }
    
    func configureDataSource() -> ApartmentDiffableDataSource {
        
        let cellIdentier = "house"
        
        let dataSource = ApartmentDiffableDataSource (
            tableView: tableView,
            cellProvider: { tableView, indexPath, apartment in
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentier, for: indexPath) as! MainTableViewCell
                
                cell.cellNameLabel.text = apartment.name
                cell.cellCityLabel.text = apartment.city
                cell.cellPriceLabel.text = apartment.price
                cell.cellYearLabel.text = apartment.commisDate
                
                if let url = URL(string: apartment.image) {
                    let task = URLSession.shared.dataTask(with: url) { data, response, error in
                        guard let data = data, error == nil else {
                            print("Error downloading image: \(error?.localizedDescription ?? "Unknown error")")
                            return
                        }
                        
                        DispatchQueue.main.async {
                            if let image = UIImage(data: data) {
                                cell.cellImageView.image = image
                            }
                        }
                    }
                    task.resume()
                }
                cell.selectionStyle = .none
                
                return cell
            }
        )
        return dataSource
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! DetailViewController
                destinationController.apartment = self.apartments[indexPath.row]
            }
        }
    }
  
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apartments.count
    }
}
