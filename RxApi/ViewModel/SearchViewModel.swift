//
//  SearchViewModel.swift
//  RxApi
//
//  Created by Takuya Ando on 2021/05/08.
//

import Foundation
import RxSwift
import RxCocoa

class SearchViewModel {
    
    var searchText: Observable<String> {
        return searchTextSubject
    }
    
    private let searchTextSubject = PublishSubject<String>()

    // VCから受け取る
    func set(text: String) {
        print("(´・ω・｀)", text)
        searchTextSubject.onNext(text)
    }
}
