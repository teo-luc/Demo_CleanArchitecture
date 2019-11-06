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

class MoviesViewController: UIViewController {
    //
    let disposeBag = DisposeBag()
    // TODO: Just only for testing..
    let viewModel = MoviesViewModel(useCase: UseCaseProviderImplemetation().makeMovieUseCase())
    //
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
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
        let kindOf = segmentedControl.rx.selectedSegmentIndex.asDriver()
        let pulldown = tableView.refreshControl!.rx.controlEvent(.valueChanged).map { true }
            .asDriver(onErrorJustReturn: true)
        let input = MoviesViewModel.Input(kindOf: kindOf, pulldown: pulldown)
        // 2. Output
        let output = viewModel.transform(input: input)
        output.movieItems
            .drive(tableView.rx.items(cellIdentifier: MovieItemViewCell.reuseID)) { index, model, cell in
                (cell as! MovieItemViewCell).bind(viewModel: model)
            }.disposed(by: disposeBag)
    }
}


