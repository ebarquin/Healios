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
    private let post: Post
    
    init(navigationController: UINavigationController, post: Post) {
        self.navigationController = navigationController
        self.post = post
    }
    
    override func start() {
        let viewController = setupViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func setupViewController() -> UIViewController {
        let viewController = DetailViewController.initFromStoryboard()
        let coreDataManager = CoreDataManagerDefault.shared
        let eventManager = EventManager()
        let viewModel = DetailViewModel(post: post, coreDataManager: coreDataManager, eventManager: eventManager)
        viewController.viewModel = viewModel
        
        return viewController
    }
}
