//
//  CoordinatorProtocol.swift
//  ThirdTeamWork
//
//  Created by user200328 on 7/7/21.
//

import UIKit

protocol CoordinatorProtocol: AnyObject {
        
    init(_ window: UIWindow?, navigationController: UINavigationController?)
    
    func start()
    func navigateToSelectedCountries()
    func navigateToSelectedCountryOnMap()
    func popViewController()
    func navigateToSignUpPage()
}
