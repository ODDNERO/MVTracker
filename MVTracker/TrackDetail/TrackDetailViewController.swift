//
//  TrackDetailViewController.swift
//  MVTracker
//
//  Created by NERO on 8/10/24.
//

import UIKit
import WebKit
import SnapKit

final class TrackDetailViewController: UIViewController {
    private var selectedTrackTitle: String = ""
    private var detailURL: String = ""
    
    private let webview = WKWebView()
    lazy var url = URL(string: detailURL)
    lazy var request = URLRequest(url: url!)

    init(_ data: MusicInfo) {
        selectedTrackTitle = data.trackName
        detailURL = data.trackViewUrl
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configrueView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = selectedTrackTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TrackDetailViewController {
    private func configrueView() {
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .systemPink
        
        webview.load(request)
        view.addSubview(webview)
        webview.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
