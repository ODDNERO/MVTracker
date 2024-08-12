//
//  SearchViewModel.swift
//  MVTracker
//
//  Created by NERO on 8/8/24.
//

import Foundation
import RxSwift
import RxCocoa

final class SearchViewModel: BaseViewModel {
    let disposeBag = DisposeBag()
    
    struct Input {
        let searchText: ControlProperty<String?>
        let searchButtonTap: ControlEvent<Void>
        let cancleButtonTap: ControlEvent<Void>
    }
    struct Output {
        let musicInfoList: PublishSubject<[MusicInfo]>
        let isLike: PublishSubject<Bool>
    }
}

extension SearchViewModel {
    func transform(_ input: Input) -> Output {
        let musicInfoList = PublishSubject<[MusicInfo]>()
        let isLike = PublishSubject<Bool>()
        isLike.onNext(false) //임시
        
        input.searchButtonTap
            .withLatestFrom(input.searchText.orEmpty).debug("searchButtonTap -> searchText:")
            .distinctUntilChanged()
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .flatMap { searchText in
                print(searchText)
                return NetworkManager.requestSearchItunes(keyword: searchText) //Observable<Music>
            }
            .subscribe(with: self) { owner, music in
                print("Next: \(music.results)") //[MusicInfo]
                musicInfoList.onNext(music.results)
            } onError: { owner, error in
                print("Error: \(error)")
            } onCompleted: { owner in
                print("Completed")
            } onDisposed: { owner in
                print("Disposed")
            }.disposed(by: disposeBag)
        
        input.cancleButtonTap
            .map { [] }
            .bind(to: musicInfoList)
            .disposed(by: disposeBag)
        
        return Output(musicInfoList: musicInfoList,
                      isLike: isLike)
    }
}
