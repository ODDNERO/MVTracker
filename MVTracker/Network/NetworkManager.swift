//
//  NetworkManager.swift
//  MVTracker
//
//  Created by NERO on 8/10/24.
//

import Foundation
import RxSwift

enum APIError: Error {
    case invalidURL
    case unknownResponse
    case statusError
}

struct NetworkManager {
    static func requestSearchItunes(keyword: String) -> Observable<Music> {
        let url = "https://itunes.apple.com/search?term=\(keyword)&entity=musicVideo"
        
        let resultObservable = Observable<Music>.create { observer in
            guard let url = URL(string: url) else {
                observer.onError(APIError.invalidURL)
                return Disposables.create()
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error { observer.onError(APIError.unknownResponse) }
                
                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    observer.onError(APIError.statusError)
                    return
                }
                
                if let data,
                    let musicData = try? JSONDecoder().decode(Music.self, from: data) {
                    print(musicData)
                    observer.onNext(musicData)
                    observer.onCompleted()
                } else {
                    print("응답 O, 디코딩 실패")
                    observer.onError(APIError.unknownResponse)
                }
            }.resume()
            return Disposables.create()
        }
        return resultObservable
    }
}
