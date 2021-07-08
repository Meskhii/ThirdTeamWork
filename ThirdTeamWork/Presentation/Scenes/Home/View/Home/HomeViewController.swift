//
//  HomeViewController.swift
//  ThirdTeamWork
//
//  Created by Beqa Tabunidze on 07.07.21.
//

import UIKit
import MapKit

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: CountriesListViewModelProtocol!
    private var dataSource: CountriesDataSource!
    private var countriesManager: CountriesManagerProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        configureViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        dataSource.refresh()
    }

    private func setupLayout() {

        tableView.registerNib(class: HomeTableViewCell.self)
    }
    
    private func configureViewModel() {
        countriesManager = CountriesManager()
        viewModel = CountriesListViewModel(with: countriesManager)
        dataSource = CountriesDataSource(with: tableView, viewModel: viewModel as! CountriesListViewModel, coordinator: coordinator!)
    }
    
}
