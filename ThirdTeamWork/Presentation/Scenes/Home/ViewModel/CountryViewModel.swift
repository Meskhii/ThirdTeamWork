//
//  CountryViewModel.swift
//  ThirdTeamWork
//
//  Created by Beqa Tabunidze on 07.07.21.
//

import Foundation

struct CountryViewModel {
    
    private var country: Country
    
    init(country: Country) {
        self.country = country
    }
    
    var name: String {
        country.name ?? ""
    }
    
    var capital: String {
        country.capital ?? ""
    }
    
    var coordinatrs: String {
        
        "Lat: \((country.latlng ?? [])[0]) Lng: \((country.latlng ?? [])[1])"
    }
}
