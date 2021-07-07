//
//  SelectedCountryOnMapViewController.swift
//  ThirdTeamWork
//
//  Created by user200328 on 7/7/21.
//

import UIKit
import MapKit

class SelectedCountryOnMapViewController: BaseViewController, MKMapViewDelegate {

    // MARK: - IBOutlet
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: - Variables
    private var latitude: CLLocationDegrees = -8.409518
    private var longitude: CLLocationDegrees = 115.188919
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        checkSavedUserDefaults()
        setupMapView()
    }
    
    // MARK: - Setuper
    private func setupMapView() {
        mapView.delegate  = self
        let centerLocation = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)

        let pin = PinAnnotation(coordinate: centerLocation, title:"Dragable Pin",subtitle:"")
        mapView.addAnnotation(pin)
        
        let region = MKCoordinateRegion(center: centerLocation, latitudinalMeters: 100_000, longitudinalMeters: 100_00)
        
        self.mapView.setRegion(region, animated: true)
    }

    // MARK: - Map View Helpers
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        if annotation is PinAnnotation {

            let pinAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "myPin")
            pinAnnotationView.pinTintColor = .purple
            pinAnnotationView.isDraggable = true
            pinAnnotationView.canShowCallout = true
            pinAnnotationView.animatesDrop = true

            return pinAnnotationView
        }

        return nil
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let lat = view.annotation?.coordinate.latitude
        let long = view.annotation?.coordinate.longitude

        print("Clic pin lat \(String(describing: lat)) long \(String(describing: long))")

        saveLongLatToUserDefaults(lat: lat, long: long)

    }
    
    // MARK: - UserDefaults Logic
    private func saveLongLatToUserDefaults(lat: CLLocationDegrees?, long: CLLocationDegrees? ) {
        guard let lat = lat else {return}
        guard let long = long else {return}
        UserDefaults.standard.set(lat, forKey: "latitude")
        UserDefaults.standard.set(long, forKey: "longitude")
    }
    
    private func checkSavedUserDefaults() {
        if UserDefaults.standard.value(forKey: "latitude") != nil {
            latitude = UserDefaults.standard.value(forKey: "latitude") as! CLLocationDegrees
        }
        
        if UserDefaults.standard.value(forKey: "longitude") != nil {
            longitude = UserDefaults.standard.value(forKey: "longitude") as! CLLocationDegrees
        }
        
    }
    
}


