//
//  RootViewController.swift
//  HealiosTest
//
//  Created by Eugenio on 10/10/2020.
//  Copyright © 2020 Eugenio Barquín. All rights reserved.
//

import UIKit

class RootViewController: UIViewController, StoryboardInitiable {
    static var storyboardName: String = "RootView"
    
    var viewModel: RootViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.fetchData()
        
    }
    
}
