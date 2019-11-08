//
//  MoviesViewController.swift
//  VideoDB_CleanArchitecture
//
//  Created by Teqnological on 11/6/19.
//  Copyright © 2019 Luc Nguyen. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
//
import NetworkPlatform
//
import Domain

class MoviesViewController: UIViewController {
    //
    let disposeBag = DisposeBag()
    // TODO: Just only for testing..
    let viewModel  = MoviesViewModel(useCase: UseCaseProviderImplemetation().makeMovieUseCase())
    //
    @IBOutlet weak var segmentedControl : UISegmentedControl!
    @IBOutlet weak var tableView        : UITableView!
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        // 1
        setupTableView()
        // 2
        bind()
    }
    
    private func setupTableView() {
        tableView.refreshControl = UIRefreshControl()
        tableView.tableFooterView = UIView()
    }
    
    private func bind() {
        // 1. Input
        let kindOf   = segmentedControl.rx.selectedSegmentIndex.asDriver()
        let pulldown = tableView.refreshControl!.rx.controlEvent(.valueChanged)
                        .map{ self.segmentedControl.selectedSegmentIndex }
                        .asDriverOnErrorJustComplete()
        let trigger  = Driver.merge(kindOf, pulldown)
        let input    = MoviesViewModel.Input(trigger : trigger)
        
        // 2. Output
        let output = viewModel.transform(input: input)
        
        // 3. Add flows
        output.movieItems
                .drive(tableView.rx.items(cellIdentifier: MovieItemViewCell.reuseID)) { _, model, cell in
                    (cell as! MovieItemViewCell).bind(viewModel: model)
                }.disposed(by: disposeBag)
        output.fetching
                .drive(tableView.refreshControl!.rx.isRefreshing)
                .disposed(by: disposeBag)
        output.error
                .drive(onNext: self.loadingError).disposed(by: disposeBag)
    }
    
    private func loadingError(error: Error) {
        let alert = UIAlertController(title: "😭", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}


