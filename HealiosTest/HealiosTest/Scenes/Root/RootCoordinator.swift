//
//  RootCoordinator.swift
//  HealiosTest
//
//  Created by Eugenio on 10/10/2020.
//  Copyright © 2020 Eugenio Barquín. All rights reserved.
//

import UIKit

final class RootCoordinator: Coordinator {
    private unowned let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() {
        let viewController = setupViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func setupViewController() -> UIViewController {
        let viewController = RootViewController.initFromStoryboard()
        let commentRepository = CommentRepositoryDefault()
        let userRepository = UserRepositoryDefault()
        let postRepository = PostRepositoryDefault()
        let eventManager = EventManager.shared
        let viewModel = RootViewModel(commentRepository: commentRepository, userRepository: userRepository, postRepository: postRepository, eventManager: eventManager)
        viewController.viewModel = viewModel
    
        return viewController
    }
}
