//
//  UserLocationViewController.swift
//  ThirdTeamWork
//
//  Created by Shotiko Klibadze on 07.07.21.
//

import UIKit
import CoreLocation
import MapKit



class UserLocationViewController: BaseViewController, UIGestureRecognizerDelegate {
    
    var locationManager: CLLocationManager?
    var destinationAnnotation: MKPointAnnotation!
    var currentCoordinate: CLLocation?
    var destinationCoordinate: CLLocation?
    
    @IBOutlet var mapView: MKMapView!
    @IBOutlet weak var distanceLabel: UILabel!
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGestureRecognizerOnMap()
        destinationAnnotation = MKPointAnnotation()

      //  let initalLocation = CLLocation(latitude: 40.7128, longitude: 74.0060)
       // mapView.centerTolocation(initalLocation)
       // currentCoordinate = initalLocation
        locationManager = CLLocationManager()
        locationManager?.requestAlwaysAuthorization()
        locationManager?.delegate = self
    }
    
    func addGestureRecognizerOnMap(){
        let gestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(handleTap))
        gestureRecognizer.delegate = self
        mapView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func handleTap(gestureRecognizer: UITapGestureRecognizer) {
        mapView.removeAnnotation(destinationAnnotation)
        
        let location = gestureRecognizer.location(in: mapView)
        let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
        
        destinationCoordinate = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        destinationAnnotation.coordinate = coordinate
        destinationAnnotation.title = "Destination"
        mapView.addAnnotation(destinationAnnotation)
        
            calculateDistance()
    }
    
    func calculateDistance(){
        guard let currentCoordinate = currentCoordinate else { return }
        guard let destinationCoordinate = destinationCoordinate else { return }
        
        let distanceInMeters = currentCoordinate.distance(from: destinationCoordinate)
        let result = round(distanceInMeters * 100) / 100.0
        
        distanceLabel.text = "\(result)M"
    }
    
    @IBAction func onCalculate(_ sender: Any) {
        calculateDistance()
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
        currentCoordinate = location
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


