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
//        webview.scrollView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = selectedTrackTitle
//        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - WebView 스크롤 최상단일 때만 NavigationBar 띄우기 구현 중
//extension TrackDetailViewController: UIScrollViewDelegate {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print("scrollViewDidScroll: \(scrollView.contentOffset.y)")
//        let shouldHidden = scrollView.contentOffset.y > 0 //MARK: 로딩되면서 중간에 스크롤이 튀는 현상
//        print("shouldHidden: \(shouldHidden)")
//        if navigationController?.isNavigationBarHidden != shouldHidden {
//            navigationController?.setNavigationBarHidden(shouldHidden, animated: true)
//        }
//    }
//}

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
