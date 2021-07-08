//
//  CountryViewModel.swift
//  ThirdTeamWork
//
//  Created by Beqa Tabunidze on 07.07.21.
//

import Foundation
import MapKit

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
    
    var latitude: Double {
        
        Double("\((country.latlng ?? [])[0])") ?? 0.0
        
    }
    
    var longitude: Double {
        
        Double("\((country.latlng ?? [])[1])") ?? 0.0
        
    }
}
