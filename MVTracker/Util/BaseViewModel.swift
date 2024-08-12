//
//  BaseViewModel.swift
//  MVTracker
//
//  Created by NERO on 8/12/24.
//

import Foundation
import RxSwift

protocol BaseViewModel {
    var disposeBag: DisposeBag { get }
    
    associatedtype Input
    associatedtype Output
    
    func transform(_ input: Input) -> Output
}
