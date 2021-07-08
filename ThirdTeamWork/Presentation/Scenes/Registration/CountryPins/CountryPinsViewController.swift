//
//  CountryPinsViewController.swift
//  ThirdTeamWork
//
//  Created by CodergirlTM on 08.07.21.
//

import UIKit
import MapKit

class CountryPinsViewController: BaseViewController, MKMapViewDelegate {
    var currentCountries = [Country]()
    var myIndex = 0
    
    @IBOutlet weak var countriesMapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if currentCountries[myIndex].latlng?.count == 2 {
            let initialLocation = CLLocation(latitude: currentCountries[myIndex].latlng![0], longitude: (currentCountries[myIndex].latlng?[1])!)
            centerMapOnLocation(location: initialLocation)
        }
    }
    
    @IBAction func doneBtn(_ sender: Any) {
        coordinator?.popViewController()
    }
    let regionRadius: CLLocationDistance = 3000000



    func centerMapOnLocation(location: CLLocation) {
        if currentCountries[myIndex].latlng?.count == 2 {

            let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                      latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        countriesMapView.setRegion(coordinateRegion, animated: true)

        let countryName = MKPointAnnotation()
        countryName.title = currentCountries[myIndex].name
            countryName.coordinate = CLLocationCoordinate2D(latitude: currentCountries[myIndex].latlng![0], longitude: (currentCountries[myIndex].latlng?[1])!)
        countriesMapView.addAnnotation(countryName)
        }

    }

}
