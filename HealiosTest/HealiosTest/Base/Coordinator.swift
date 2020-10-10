//
//  Coordinator.swift
//  HealiosTest
//
//  Created by Eugenio on 10/10/2020.
//  Copyright © 2020 Eugenio Barquín. All rights reserved.
//

import Foundation


class Coordinator: NSObject {
    private(set) weak var parent: Coordinator?
    private(set) var children: [Coordinator] = []
    
    ///Tells the coordinator to strart its work, i.e. present a view controller
    func start() {
    }
    
    func customizeAppearance() {
        
    }
    
    /// Marks the coordinator as finished. and coordinator will remove itself from its parent.
    
    final func done() {
        parent?.remove(child: self)
    }
    
    /// Add a child coordinator
    final func add(child: Coordinator) {
        children.append(child)
        child.parent = self
    }
    
    private func remove(child: Coordinator) {
        let index = children.firstIndex {
            $0 === child
        }
        
        if let index = index {
            print("removing coordinator \(child)")
            children.remove(at:index)
        }
    }
}
