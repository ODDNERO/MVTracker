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
    static func requestSearchItunes(keyword: String) -> Single<Music> {
        let url = "https://itunes.apple.com/search?term=\(keyword)&entity=musicVideo"
        
        let resultSingle = Single<Music>.create { observer in
            guard let url = URL(string: url) else {
                observer(.failure(APIError.invalidURL))
                return Disposables.create()
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error { observer(.failure(APIError.unknownResponse)) }
                
                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    observer(.failure(APIError.statusError))
                }
                
                guard let data else { observer(.failure(APIError.unknownResponse)) }
                
                do {
                    let musicData = try JSONDecoder().decode(Music.self, from: data)
                    observer(.success(musicData))
                } catch {
                    print("응답 O, 디코딩 실패")
                    print(error)
                    observer(.failure(APIError.unknownResponse))
                }
            }.resume()
            return Disposables.create()
            
        }.catch { error in Single.never() }
        
        return resultSingle
    }
}
