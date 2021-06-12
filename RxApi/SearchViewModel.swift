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
        return searchText
    }
    
    private let searchText = PublishSubject<String>()

}
