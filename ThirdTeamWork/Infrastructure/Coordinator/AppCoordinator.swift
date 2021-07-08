//
//  AppCoordinator.swift
//  ThirdTeamWork
//
//  Created by user200328 on 7/7/21.
//

import UIKit

final class AppCoordinator: CoordinatorProtocol {
    
    // MARK: - Variables
    private var window: UIWindow?
    private var navigationController: UINavigationController?
    
    // MARK: - Initialisation
    init(_ window: UIWindow?, navigationController: UINavigationController?) {
        self.window = window
        self.navigationController = navigationController
        
    }
    
    func start() {
        //let vc = MainViewController.instantiateFromStoryboard()
        let vc = HomeViewController.instantiateFromStoryboard()
        vc.coordinator = self
        navigationController?.navigationBar.isHidden = true
        navigationController?.pushViewController(vc, animated: true)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func popViewController() {
        
        navigationController?.popViewController(animated: true)
    }
    
    func navigateTo() {
        
        let vc = MapViewController.instantiateFromStoryboard()
        vc.coordinator = self
        navigationController?.navigationBar.isHidden = true
        navigationController?.pushViewController(vc, animated: true)

    }
    
}
