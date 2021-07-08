//
//  UserLocationViewController.swift
//  ThirdTeamWork
//
//  Created by Shotiko Klibadze on 07.07.21.
//

import UIKit
import CoreLocation
import MapKit

protocol HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark)
}

class UserLocationViewController: BaseViewController {
    
    var locationManager: CLLocationManager?
    @IBOutlet var mapView: MKMapView!
    
    var selectedPin:MKPlacemark? = nil
    
    var resultSearchController : UISearchController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTable
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        navigationItem.searchController = resultSearchController
        
       
        
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.obscuresBackgroundDuringPresentation = true
        definesPresentationContext = true
        
        locationSearchTable.mapView = mapView
        locationSearchTable.handleMapSearchDelegate = self
       mapView.centerTolocation(initalLocation)
        locationManager = CLLocationManager()
        locationManager?.requestAlwaysAuthorization()
        locationManager?.delegate = self
    }
    
}


extension UserLocationViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            print ("Didn't choose the option yet")
        case .restricted, .denied:
            print ("Infrom user that we need access")
        case .authorizedAlways,.authorizedWhenInUse:
            print ("User agreed")
            locationManager?.startUpdatingLocation()
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        
        print("Lat: \(location.coordinate.latitude) :: Lng: \(location.coordinate.longitude)")
        mapView.centerTolocation(location)
    }

}


private extension MKMapView {
    func centerTolocation (_ location: CLLocation, regionRadius : CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion(
              center: location.coordinate,
              latitudinalMeters: regionRadius,
              longitudinalMeters: regionRadius)
            setRegion(coordinateRegion, animated: true)
//        let pin = MKPointAnnotation()
//        pin.coordinate = location.coordinate
//        addAnnotation(pin)

    }
}

extension UserLocationViewController: HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark){
        // cache the pin
        selectedPin = placemark
        // clear existing pins
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        if let city = placemark.locality,
        let state = placemark.administrativeArea {
            annotation.subtitle = "\(city) \(state)"
        }
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: placemark.coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
}
