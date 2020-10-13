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
        let coreDataStack = CoreDataStack()
        let eventManager = EventManager()
        let userCoreDataService = UserCoreDataService(context: coreDataStack.context, coreDataStack: coreDataStack)
        let commentCoreDataService = CommentCoreDataService(context: coreDataStack.context, coreDataStack: coreDataStack)
        let viewModel = DetailViewModel(post: post, coreDataManager: coreDataStack, eventManager: eventManager, userCoreDataService: userCoreDataService, commentCoreDataService: commentCoreDataService)
        viewController.viewModel = viewModel
        
        return viewController
    }
}
