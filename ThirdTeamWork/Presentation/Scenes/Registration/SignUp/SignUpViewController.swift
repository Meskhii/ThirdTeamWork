//
//  SignUpViewController.swift
//  ThirdTeamWork
//
//  Created by CodergirlTM on 08.07.21.
//

import UIKit
import CoreLocation

class SignUpViewController: BaseViewController {
    private var countryManager: CountriesManagerProtocol!
    
    var currentCountries = [Country]()
    var myIndex = 0
    
    var locationManager: CLLocationManager?
    
    
    @IBOutlet weak var pickerView: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        fetchCountry()
        locationManager = CLLocationManager()
        locationManager?.requestAlwaysAuthorization()
        locationManager?.delegate = self
        
    }
    private func fetchCountry() {
        countryManager = CountriesManager()
        countryManager.fetchCountries(completion: { currentCountries in
            self.currentCountries = currentCountries
            DispatchQueue.main.async {
                self.pickerView.reloadAllComponents()
            }
        })
    }
    @IBAction func registrationBtn(_ sender: Any) {
    }
    
}

extension SignUpViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }


    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currentCountries.count

    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currentCountries[row].name
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        myIndex = row
        let sb = UIStoryboard(name: "CountryPinsViewController", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "CountryPinsViewController") as! CountryPinsViewController
        navigationController?.pushViewController(vc, animated: true)
        vc.currentCountries = self.currentCountries
        vc.myIndex = self.myIndex
    }
    
    
}

extension SignUpViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager?.startUpdatingLocation()
        case .denied, .restricted:
            openSettingsAlert()
        case .notDetermined:
            print("მომხმარებელს ჯერ არ ამოურჩევია")
        default:
            break
        }
    }
    private func openSettingsAlert() {
        let alert = UIAlertController(
            title: "ყურადღებით",
            message: "იმისთვის რომ აპლიკაციას წვდომა ქონდეს ლოკაციის სერვისთან აუცილებელია რომ გადახვიდეთ პარამეტრებში და გააქტიუროთ ხელით",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "გაუქმება", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "პარამეტრები", style: .default, handler: { _ in
            guard let url = URL(string: UIApplication.openSettingsURLString) else { return }

            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }))
        
        self.present(alert, animated: true)
    }
}
