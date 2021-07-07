//
//  SelectedCountriesViewController.swift
//  ThirdTeamWork
//
//  Created by user200328 on 7/7/21.
//

import UIKit

class SelectedCountriesViewController: BaseViewController {

    // MARK: - Variables
    private var selectedCountriesDataSource: SelectedCountriesDataSource!
    var countriesList = ["Georgia", "Switzerland", "Italy"]
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerNib(class: CountryCell.self)

        configureDataSource()
    }
    
    private func configureDataSource() {
        selectedCountriesDataSource = SelectedCountriesDataSource(with: tableView, countries: countriesList, coordinator: coordinator!)
    }

}
