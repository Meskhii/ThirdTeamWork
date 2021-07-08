//
//  HomeTableViewCell.swift
//  ThirdTeamWork
//
//  Created by Beqa Tabunidze on 07.07.21.
//

import UIKit
import MapKit

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var CountryNameLabel: UILabel!
    @IBOutlet weak var capitalNameLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    var coordinator: CoordinatorProtocol?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func configureMap(with item: CountryViewModel, coordinator: CoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func configure(with item: CountryViewModel, coordinator: CoordinatorProtocol) {
        
        let geoCoder = CLGeocoder()
        let location = item.capital
        
        CountryNameLabel.text = item.name
        capitalNameLabel.text = item.capital

        geoCoder.geocodeAddressString(location) { (placemarks, error) in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let placemarks = placemarks {
                
                let placemark = placemarks[0]
                
                let annotation = MKPointAnnotation()
                
                if let location = placemark.location {
                    
                    annotation.coordinate = location.coordinate
                    self.mapView?.addAnnotation(annotation)
                    
                    let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 250, longitudinalMeters: 250)
                    self.mapView?.setRegion(region, animated: false)
                }
            }
        }
        
        self.coordinator = coordinator
    }
    
    
}
