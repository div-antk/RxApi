//
//  ViewModel.swift
//  RxApi
//
//  Created by Takuya Ando on 2021/05/08.
//

import Foundation
import RxSwift
import RxCocoa

final class ViewModel {
    
    private let disposeBag = DisposeBag()
    
    private let searchWordStream = PublishSubject<String>()
//    private let articlesStream = PublishSubject<Articles?>()
    
    private let startedAtStream = PublishSubject<String>()
}

extension ViewModel {
    var searchWord: AnyObserver<(String)> {
        return searchWordStream.asObserver()
    }
    var startedAt: AnyObserver<String> {
        return startedAtStream.asObserver()
    }
}

//extension ViewModel {
//
//}
