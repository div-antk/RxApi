//
//  SearchViewModel.swift
//  RxApi
//
//  Created by Takuya Ando on 2021/05/08.
//

import Foundation
import RxSwift
import RxCocoa

// 入力インターフェースをプロトコルにより明確化
protocol SearchViewModelInputs {
    func searchTextChanged(_ searchText: String)
}

protocol SearchViewModelOutputs {
    var searchDescription: Observable<String> { get }
    var cardList: Observable<[Card]> { get }
    var error: Observable<Error> { get }
}

class SearchViewModel: SearchViewModelOutputs {
    private let disposeBag = DisposeBag()
    // テストコードを明確にするため、通信やスケジューラなどの依存するオブジェクトを外部から注入できるようにする（DI）
    private let cardRepository: CardRepository
    private let scheduler: SchedulerType
    
    // MARK: OUTPUT
    // 後述する outputs プロパティ経由でアクセスする
    let searchDescription: Observable<String>
    let cardList: Observable<[Card]>
    let error: Observable<Error>
    
    private let searchTextChangeProperty = BehaviorRelay<String>(value: "")
    
    init(cardRepository: CardRepository,
         scheduler: SchedulerType = ConcurrentMainScheduler.instance) {
        self.cardRepository = cardRepository
        self.scheduler = scheduler
        
        // PublishRelayとして初期値を持たない出力用内部Subjectを用意
        let _cardList = PublishRelay<[Card]>()
        self.cardList = _cardList.asObservable()
        
        let _error = PublishRelay<Error>()
        self.error = _error.asObservable()
        
        let filterdText = searchTextChangeProperty
            .debounce(.milliseconds(300), scheduler: scheduler)
            .filter { $0.count >= 1 }
            .share(replay: 1)
        
        let _searchResultText = PublishRelay<String>()
        searchDescription = _searchResultText.asObservable()
        
        let sequence = filterdText
            .flatMapLatest { [unowned self] text -> Observable<Event<[Card]>> in
                return self.cardRepository
                    .getCards(from: text)
                    .materialize()
            }
            .share(replay: 1)
    }
}

//class SearchViewModel {
//
//    var searchText: Observable<String> {
//        return searchTextSubject
//    }
//
//    private let searchTextSubject = PublishSubject<String>()
//
//    // VCから受け取る
//    func set(text: String) {
//        print("(´・ω・｀)", text)
//        searchTextSubject.onNext(text)
//    }
//}
