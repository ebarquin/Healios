//
//  AppCoordinator.swift
//  HealiosTest
//
//  Created by Eugenio on 10/10/2020.
//  Copyright © 2020 Eugenio Barquín. All rights reserved.
//

import UIKit

final class AppCoordinator: Coordinator {
    private let window: UIWindow
    private let navigationController = UINavigationController()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() {
        customizeAppearance()
        window.rootViewController = navigationController
        let coordinator = RootCoordinator(navigationController: navigationController)
        coordinator.start()
        add(child: coordinator)
        
        window.makeKeyAndVisible()
    }
}
