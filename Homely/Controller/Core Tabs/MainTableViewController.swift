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
    
    @IBOutlet weak var changeCityOutlet: UITabBarItem!
    
    let db = Firestore.firestore()
    let storage = Storage.storage()
    
    var cities: [String] = ["All cities", "Astana", "Almaty", "Shymkent", "Aktobe", "Karagandy", "Semey", "Aktau", "Atyrau", "Kokshetau", "Pavlodar", "Taldykorgan", "Saryozek"]
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height / 2
    
    var selectedRow = 0
    var apartments: [Apartment] = []
    var apartmentsCopy: [Apartment] = []
    var apartment = Apartment()
    
    lazy var dataSource = configureDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
 
        if let appearance = navigationController?.navigationBar.standardAppearance {
            appearance.configureWithTransparentBackground()
            
            if let customFont = UIFont(name: "Nunito-Bold", size: 50.0) {
                appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "MainColor")!]
                appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "MainColor")!, .font: customFont]
            }
            
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.compactAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
                
        }
        
        tableView.delegate = self
        tableView.dataSource = dataSource

        getData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        handleNotAuthenticated()
    }
    
    private func handleNotAuthenticated() {
        if Auth.auth().currentUser == nil {
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: false)
        }
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
            self.apartmentsCopy = self.apartments
            self.updateSnapshot(city: "All cities")
            
        }
    }
    
    func updateSnapshot(city: String, animatingChange: Bool = false) {
        
        apartments = apartmentsCopy
        
        if city != "All cities" {
            let filtredApartments = apartments.filter { $0.city == city }
            apartments = filtredApartments
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Apartment>()
        snapshot.appendSections([.all])
        snapshot.appendItems(self.apartments, toSection: .all)
        
        self.dataSource.apply(snapshot, animatingDifferences: false)
        
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
                                cell.cellImageView.contentMode = .scaleAspectFill
                                cell.clipsToBounds = true
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
  
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let rootVC = DetailViewController()
        rootVC.apartment1 = apartments[indexPath.row]
        
        let navigationController = UINavigationController(rootViewController: rootVC)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apartments.count
    }
      
}

extension MainTableViewController: UIPickerViewDelegate,  UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 30))
        label.text = cities[row]
        label.sizeToFit()

        return label
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
      
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return cities.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        
        return 60
    }
    
    @IBAction func changeCity(_ sender: UIBarButtonItem) {
  
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: screenWidth, height: screenHeight)
       
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.selectRow(selectedRow, inComponent: 0, animated: false)
        vc.view.addSubview(pickerView)
        pickerView.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        pickerView.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor).isActive = true
        
        let alert = UIAlertController(title: "Select city", message: nil, preferredStyle: .actionSheet)
        alert.setValue(vc, forKey: "contentViewController")
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Select", style: .default, handler: { UIAlertAction in
            self.selectedRow = pickerView.selectedRow(inComponent: 0)
            let selected = self.cities[self.selectedRow]
            self.changeCityOutlet.title = selected
            self.updateSnapshot(city: selected)
        }))
        self.present(alert, animated: true)
        
    }
}
