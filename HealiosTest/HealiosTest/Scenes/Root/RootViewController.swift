//
//  RootViewController.swift
//  HealiosTest
//
//  Created by Eugenio on 10/10/2020.
//  Copyright © 2020 Eugenio Barquín. All rights reserved.
//

import UIKit
import RxSwift

class RootViewController: UIViewController, StoryboardInitiable {
    static var storyboardName: String = "RootView"
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var viewModel: RootViewModel?
    let disposeBag = DisposeBag()
    let navigateToDetail: ((Post)-> Void) = {_ in}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        viewModel?.fetchData()
    }
}

extension RootViewController {
    func bindViewModel() {
        bindIsLoading()
        bindTableView()
        bindItemSelected()
    }
    
    private func bindIsLoading() {
        viewModel?.onShowLoadingHud
        .map { [weak self] in self?.isLoadingVisible($0) }
        .subscribe()
        .disposed(by: disposeBag)
    }
    
    private func bindTableView() {
        viewModel?.coreDataPosts.bind(to: tableView.rx.items(cellIdentifier: "cell")) { _, post, cell in
            if let cellToUse = cell as? RootCell {
                cellToUse.configureCell(with: post)
            }
        }.disposed(by: disposeBag)
    }
    
    private func isLoadingVisible(_ visible: Bool) {
        if visible {
            spinner.isHidden = false
            spinner.startAnimating()
        } else {
            spinner.isHidden = true
            spinner.stopAnimating()
        }
    }
    
    private func bindItemSelected() {
        tableView.rx.itemSelected.subscribe { indexPath in
            if let indexPath = indexPath.element,
                let cell = self.tableView.cellForRow(at: indexPath) as? RootCell {
                self.tableView.deselectRow(at: indexPath, animated: true)
                guard let post = cell.post else { return }
                self.navigateToDetail(post)
                print("navigation")
            }
        }.disposed(by: disposeBag)
    }
}
