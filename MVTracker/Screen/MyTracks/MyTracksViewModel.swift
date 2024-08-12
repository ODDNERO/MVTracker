//
//  MyTracksViewModel.swift
//  MVTracker
//
//  Created by NERO on 8/12/24.
//

import Foundation
import RxSwift
import RxCocoa
import RealmSwift

final class MyTracksViewModel: BaseViewModel {
    private let repository = TrackRepository()
    let disposeBag = DisposeBag()
    
    struct Input {
        let trackData: MusicInfo
        let likeButtonTap: ControlEvent<Void>
    }
    struct Output {
        let myTrackList: PublishSubject<[Track]>
        let isLike: BehaviorSubject<Bool>
    }
}

extension MyTracksViewModel {
    func transform(_ input: Input) -> Output {
        let myTrackList = PublishSubject<[Track]>()
        let isLike = BehaviorSubject(value: true)
        
        myTrackList.onNext(repository.fetchMyTracks())
        
        input.likeButtonTap
            .map { input.trackData }
            .bind(with: self) { owner, trackData in
                owner.repository.deleteTrack(trackData.trackId)
                myTrackList.onNext(owner.repository.fetchMyTracks())
                isLike.onNext(false)
            }.disposed(by: disposeBag)

        return Output(myTrackList: myTrackList, isLike: isLike)
    }
}
