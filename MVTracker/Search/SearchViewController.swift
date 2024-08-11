//
//  SearchViewController.swift
//  MVTracker
//
//  Created by NERO on 8/8/24.
//

import UIKit
import RxSwift
import RxCocoa

final class SearchViewController: UIViewController {
    private let viewModel = SearchViewModel()
    private let disposeBag = DisposeBag()
    
    private let contentView = SearchView()
    override func loadView() {
        self.view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "뮤직비디오 검색"
        navigationItem.backButtonTitle = ""
        navigationItem.searchController = contentView.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        bind()
    }
}

extension SearchViewController {
    func bind() {
        let input = SearchViewModel.Input(searchText: contentView.searchController.searchBar.rx.text,
                                          searchButtonTap: contentView.searchController.searchBar.rx.searchButtonClicked,
                                          cancleButtonTap: contentView.searchController.searchBar.rx.cancelButtonClicked)
        let output = viewModel.transform(input)
        
        output.musicInfoList
            .bind(to: contentView.tableView.rx.items(cellIdentifier: SearchTableViewCell.identifier, cellType: SearchTableViewCell.self)) {
                (row, element, cell) in
                cell.setupData(element)
                
                var temporaryBool = false //임시
                cell.likeButton.rx.tap
                    .bind(with: self) { owner, _ in
                        temporaryBool.toggle() //임시
                        cell.setupLikeButton(temporaryBool) //임시
                    }
                    .disposed(by: cell.disposeBag)
                
            }.disposed(by: disposeBag)
        
        
    }
}
//}
