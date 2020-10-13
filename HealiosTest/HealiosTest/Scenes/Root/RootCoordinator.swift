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
        let coreDataStack = CoreDataStack()
        let postCoreDataService = PostCoreDataService(context: coreDataStack.context, coreDataStack: coreDataStack)
        let userCoreDataService = UserCoreDataService(context: coreDataStack.context, coreDataStack: coreDataStack)
        let commentCoreDataService = CommentCoreDataService(context: coreDataStack.context, coreDataStack: coreDataStack)
        let viewModel = RootViewModel(commentRepository: commentRepository, userRepository: userRepository, postRepository: postRepository, eventManager: eventManager, coreDataManager: coreDataStack, postCoreDataService: postCoreDataService, userCoreDataService: userCoreDataService, commentCoreDataService: commentCoreDataService)
        viewController.viewModel = viewModel
        viewController.navigateToDetail = navigateToDetail
    
        return viewController
    }
    
    private func navigateToDetail(post: Post) {
        let coordinator = DetailCoordinator(navigationController: navigationController, post: post)
        add(child: coordinator)
        coordinator.start()
    }
}
