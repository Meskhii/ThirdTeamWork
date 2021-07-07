//
//  SelectedCountriesDataSource.swift
//  ThirdTeamWork
//
//  Created by user200328 on 7/7/21.
//


import UIKit

class SelectedCountriesDataSource: NSObject {
    
    // MARK: - Variables
    private var tableView: UITableView!
    private var countries = [String]()
    
    // MARK: - Init
    init(with tableView: UITableView, countries: [String]) {
        super.init()
        
        self.tableView = tableView
        self.tableView.dataSource = self
        self.tableView.delegate = self

        self.countries = countries
    }
    
}

// MARK: - UITableViewDataSource
extension SelectedCountriesDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.deque(class: CountryCell.self, for: indexPath)
        cell.configure(with: countries[indexPath.row])
        return cell
    }
    
}

// MARK: - UITableViewDelegate
extension SelectedCountriesDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
}
