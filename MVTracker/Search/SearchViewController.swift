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
    }
}
//}
