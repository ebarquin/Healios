//
//  DetailViewController.swift
//  HealiosTest
//
//  Created by Eugenio on 12/10/2020.
//  Copyright © 2020 Eugenio Barquín. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class DetailViewController: UIViewController, StoryboardInitiable {
    static var storyboardName: String = "DetailView"
    
    @IBOutlet weak var postBodyLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emailLabel: UILabel!
    
    var viewModel: DetailViewModel?
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        viewModel?.fetchData()
        title = viewModel?.post.title
        postBodyLabel.text = viewModel?.post.body
    }
    
    private func configureUIWith(user: User) {
        userNameLabel.text = user.name
        emailLabel.text = user.email
    }
}

extension DetailViewController {
    func bindViewModel() {
        bindUser()
        DispatchQueue.main.async {
            //Needed for circunvent issue:
            //https://github.com/ReactiveX/RxSwift/issues/2081
            //https://github.com/RxSwiftCommunity/RxDataSources/issues/331
            self.bindTableView()
        }
        
    }
    
    private func bindUser() {
        viewModel?.onGettingUser.subscribe({ event in
            switch event {
            case .next (let user):
                self.configureUIWith(user: user)
            case .error:
                print("error")
            default: break
            }
            }).disposed(by: disposeBag)
    }
    
    private func bindTableView() {
        viewModel?.comments.bind(to: tableView.rx.items(cellIdentifier: "cell")) { _, comment, cell in

            if let cellToUse = cell as? DetailCell {
                cellToUse.configureCell(with: comment)
            }
        }.disposed(by: disposeBag)
    }
}
