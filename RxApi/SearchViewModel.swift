//
//  SearchViewModel.swift
//  RxApi
//
//  Created by Takuya Ando on 2021/05/08.
//

import Foundation
import RxSwift
import RxCocoa

final class SearchViewModel {
    
    private let disposeBag = DisposeBag()
    
    private let searchWordStream = PublishSubject<String>()
    private let articlesStream = PublishSubject<Articles?>()
    
    private let startedAtStream = PublishSubject<String>()
    private let formattedDateStream = PublishSubject<String>()
    
    init() {
        searchWordStream.flatMapLatest { word -> Observable<Article?> in
            print("serchWord:\(word)")
            let model = ApiModel()
            return model.searchArticles(word: word).catchErrorJustReturn(nil)
        }
        .subscribe(articlesStream)
        .disposed(by: disposeBag)
    }
}

// MARK: Observer
extension SearchViewModel {
    var searchWord: AnyObserver<(String)> {
        return searchWordStream.asObserver()
    }
    var startedAt: AnyObserver<String> {
        return startedAtStream.asObserver()
    }
}

// MARK: Observable
extension SearchViewModel {
    var articles: Observable<Articles?> {
        return articlesStream.asObserver()
    }
    var formattedDate: Observable<String> {
        return formattedDateStream.asObserver()
    }
}
