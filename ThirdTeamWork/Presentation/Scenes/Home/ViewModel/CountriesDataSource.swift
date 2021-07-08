//
//  CountriesDataSource.swift
//  ThirdTeamWork
//
//  Created by Beqa Tabunidze on 07.07.21.
//

import UIKit
import MapKit

class CountriesDataSource: NSObject, UITableViewDataSource {
    
    // MARK: - Private properties
    
    private var tableView: UITableView!
    private var viewModel: CountriesListViewModel!
    private var coordinator: CoordinatorProtocol!
    
    var storyboard = UIStoryboard(name: "MapViewController", bundle: nil)
    let navigationController = UINavigationController()
    
    private var countriesList = [CountryViewModel]()
    
    var mapView: MKMapView?
    
    init(with tableView: UITableView, viewModel: CountriesListViewModel, coordinator: CoordinatorProtocol) {
        super.init()
        
        self.tableView = tableView
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.allowsMultipleSelection = true
        self.tableView.allowsMultipleSelectionDuringEditing = true
        
        self.viewModel = viewModel
        self.coordinator = coordinator
    }
    
    func refresh() {
        viewModel.getCountriesList { countries in
            self.countriesList.append(contentsOf: countries)
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countriesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.deque(class: HomeTableViewCell.self, for: indexPath)
        cell.configure(with: countriesList[indexPath.row], coordinator: coordinator)
        
        return cell
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 250
        
    }
}

extension CountriesDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        coordinator?.navigateTo(with: countriesList[indexPath.row].capital)
        refresh()
        
    }
//
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        tableView.cellForRow(at: indexPath)?.accessoryType = .none
//    }
}

