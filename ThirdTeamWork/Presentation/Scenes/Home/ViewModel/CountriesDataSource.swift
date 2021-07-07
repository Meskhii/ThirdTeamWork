//
//  CountriesDataSource.swift
//  ThirdTeamWork
//
//  Created by Beqa Tabunidze on 07.07.21.
//

import UIKit

class CountriesDataSource: NSObject, UITableViewDataSource {
    
    // MARK: - Private properties
    
    private var tableView: UITableView!
    private var viewModel: CountriesListViewModel!
    
    var storyboard = UIStoryboard(name: "MapViewController", bundle: nil)
    let navigationController = UINavigationController()
    
    private var countriesList = [CountryViewModel]()
    
    init(with tableView: UITableView, viewModel: CountriesListViewModel) {
        super.init()
        
        self.tableView = tableView
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.viewModel = viewModel
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
        cell.configure(with: countriesList[indexPath.row])
        return cell
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
        
    }
}

extension CountriesDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = storyboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        self.navigationController.pushViewController(vc, animated: true)
    }
}

