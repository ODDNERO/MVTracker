//
//  MyTracksViewController.swift
//  MVTracker
//
//  Created by NERO on 8/10/24.
//

import UIKit
import SnapKit

final class MyTracksViewController: UIViewController {
    let tableView = UITableView().then {
        $0.register(TrackTableViewCell.self, forCellReuseIdentifier: TrackTableViewCell.identifier)
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
        $0.showsVerticalScrollIndicator = true
        $0.rowHeight = 260
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
}

extension MyTracksViewController {
    private func configureView() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.snp.makeConstraints { $0.edges.equalTo(view.safeAreaLayoutGuide) }
    }
}
