//
//  DetailCoordinator.swift
//  HealiosTest
//
//  Created by Eugenio on 12/10/2020.
//  Copyright © 2020 Eugenio Barquín. All rights reserved.
//

import UIKit
final class DetailCoordinator: Coordinator {
    private unowned let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() {
        let viewController = setupViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func setupViewController() -> UIViewController {
        let viewController = DetailViewController.initFromStoryboard()
        let viewModel = DetailViewModel()
        viewController.viewModel = viewModel
        
        return viewController
    }
}
