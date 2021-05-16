//
//  SearchViewModel.swift
//  RxApi
//
//  Created by Takuya Ando on 2021/05/08.
//

import Foundation
import RxSwift
import RxCocoa

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

class SearchViewModel {
    
    private let disposeBag = DisposeBag()
    
    private let wikipediaAPI: ApiRepository
    private let scheduler: SchedulerType
    
    init(wikipediaAPI: ApiRepository,
         scheduler: SchedulerType = ConcurrentMainScheduler.instance) {
        self.wikipediaAPI = wikipediaAPI
        self.scheduler = scheduler
    }
}


extension SearchViewModel: ViewModelType {
    
    struct Input {
        let searchWord: Observable<String>
    }
    
    struct Output {
        let wikipage: Observable<[ApiModel]>
        let searchDescription: Observable<String>
        let error: Observable<Error>
    }
    
    func transform(input: Input) -> Output {
        
        let filterdText = input.searchWord
            .debounce(.milliseconds(300), scheduler: scheduler)
            .share(replay: 1)
        
        let sequence = filterdText
            .flatMapLatest { [unowned self] text -> Observable<Event<[ApiModel]>> in
                return self.wikipediaAPI
                .search(from: text)
                .materialize()
            }
            .share(replay: 1)
        
        let wikipediaPages = sequence.elements()
        
        let _searchDescription = PublishRelay<String>()
        
        wikipediaPages.
        
    }
    
    
}
    //    private let disposeBag = DisposeBag()
    //
    //    private let searchWordStream = PublishSubject<String>()
    //    private let articlesStream = PublishSubject<Articles?>()
    //
    //    private let startedAtStream = PublishSubject<String>()
    //    private let formattedDateStream = PublishSubject<String>()
    //
    //    init() {
    //        searchWordStream.flatMapLatest { word -> Observable<Article?> in
    //            print("serchWord:\(word)")
    //            let model = ApiModel()
    //            return model.searchArticles(word: word).catchErrorJustReturn(nil)
    //        }
    //        .subscribe(articlesStream)
    //        .disposed(by: disposeBag)
    //    }


//// MARK: Observer
//extension SearchViewModel {
//    var searchWord: AnyObserver<(String)> {
//        return searchWordStream.asObserver()
//    }
//    var startedAt: AnyObserver<String> {
//        return startedAtStream.asObserver()
//    }
//}
//
//// MARK: Observable
//extension SearchViewModel {
//    var articles: Observable<Articles?> {
//        return articlesStream.asObserver()
//    }
//    var formattedDate: Observable<String> {
//        return formattedDateStream.asObserver()
//    }
//}
