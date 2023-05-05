//
//  MapViewController.swift
//  Homely
//
//  Created by Nurmukhanbet Sertay on 27.04.2023.
//

import UIKit
import MapKit
import SnapKit

class MapViewController: UIViewController {
    
    var mapView = MKMapView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mapView)
        view.backgroundColor = .white
        
        //MARK: - MapView Animation
        let startingXPosition = self.view.frame.size.width * 3
        mapView.frame = CGRect(x: startingXPosition, y: 0, width: 100, height: 100)
        MKMapView.animate(withDuration: 1, delay: 0.0, options: .curveEaseInOut, animations: {
            self.mapView.frame = CGRect(x: self.view.frame.size.width - self.mapView.frame.size.width - 20, y: 100, width: 100, height: 100)
        }, completion: nil)
//
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    


}
