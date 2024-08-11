//
//  SearchView.swift
//  MVTracker
//
//  Created by NERO on 8/8/24.
//

import UIKit
import SnapKit
import Then

final class SearchView: UIView {
    let searchController = UISearchController(searchResultsController: nil).then {
        $0.searchBar.placeholder = " 💿 노래 제목 or 아티스트 검색하기"
        $0.searchBar.searchBarStyle = .prominent
        $0.searchBar.autocorrectionType = .no
        $0.searchBar.autocapitalizationType = .none
        $0.automaticallyShowsCancelButton = true
        $0.hidesNavigationBarDuringPresentation = true
    }
    
    let tableView = UITableView().then {
        $0.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        $0.backgroundColor = .clear
        $0.separatorStyle = .singleLine
        $0.separatorColor = .systemPink.withAlphaComponent(0.4)
        $0.showsVerticalScrollIndicator = true
        $0.rowHeight = 200
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchView {
    private func configureView() {
        self.backgroundColor = .white
        self.addSubview(tableView)
        tableView.snp.makeConstraints { $0.edges.equalTo(self.safeAreaLayoutGuide) }
    }
}
