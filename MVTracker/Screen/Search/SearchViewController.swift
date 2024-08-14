//
//  SearchViewController.swift
//  MVTracker
//
//  Created by NERO on 8/8/24.
//

import UIKit
import RxSwift
import RxCocoa
import AVFoundation

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
                                          cancelButtonTap: contentView.searchController.searchBar.rx.cancelButtonClicked,
        let output = viewModel.transform(input)
        
        let musicInfoList = output.musicInfoList.asDriver(onErrorJustReturn: [])
        
        musicInfoList
            .drive(contentView.tableView.rx.items(cellIdentifier: TrackTableViewCell.identifier, cellType: TrackTableViewCell.self)) {
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
        
        //MARK: - Cancel Button 클릭 -> 뮤직비디오 재생 중지 & 리소스 정리 구현 중
//        musicInfoList
//            .drive(with: self) { owner, musicInfoList in
//                if musicInfoList.isEmpty {
//                    for case let cell as SearchTableViewCell in owner.contentView.tableView.visibleCells {
//                        cell.stopVideo()
//                    }
//                }
//            }
//            .disposed(by: disposeBag)
        
//        contentView.searchController.searchBar.rx.cancelButtonClicked
//            .bind(with: self) { owner, _ in
//                for case let cell as SearchTableViewCell in owner.contentView.tableView.visibleCells {
//                    print("stopVideo 직전까지 실행됨") //MARK: 실행 안 됨
//                    cell.stopVideo()
//                }
//            }
//            .disposed(by: disposeBag)
        
        Observable.zip(
            contentView.tableView.rx.modelSelected(MusicInfo.self),
            contentView.tableView.rx.itemSelected
        ).debug("TableView Selected")
            .map { $0.0 }
            .subscribe(with: self) { owner, musicInfo in
                let detailVC = TrackDetailViewController(musicInfo)
                detailVC.hidesBottomBarWhenPushed = true
                owner.navigationController?.pushViewController(detailVC, animated: true)
            }.disposed(by: disposeBag)
    }
}
