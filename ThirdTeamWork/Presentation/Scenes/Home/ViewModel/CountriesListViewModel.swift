//
//  CountriesListViewModel.swift
//  ThirdTeamWork
//
//  Created by Beqa Tabunidze on 07.07.21.
//

import UIKit

protocol CountriesListViewModelProtocol: AnyObject {
    
    func getCountriesList(completion: @escaping (([CountryViewModel]) -> Void))
    
    init(with countriesManager: CountriesManagerProtocol)
}

class CountriesListViewModel: CountriesListViewModelProtocol {
    
    private var countriesManager: CountriesManagerProtocol!
    
    var didFinishedLoading: (() -> Void)?
    
    required init(with countriesManager: CountriesManagerProtocol)  {
        self.countriesManager = countriesManager
    }
    
    func getCountriesList(completion: @escaping (([CountryViewModel]) -> Void)) {
        countriesManager.fetchCountries { countries in
            DispatchQueue.main.async {
                
                let countriesViewModels =  countries.map { CountryViewModel(country: $0) }
                
                completion(countriesViewModels)
                
            }
        }
    }

}

