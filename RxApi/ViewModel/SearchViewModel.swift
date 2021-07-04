//
//  SearchViewModel.swift
//  RxApi
//
//  Created by Takuya Ando on 2021/05/08.
//

import Foundation
import RxSwift
import RxCocoa
import Moya

// 入力インターフェースをプロトコルにより明確化
protocol SearchViewModelInputs {
    var searchText: AnyObserver<String> { get }
}

protocol SearchViewModelOutputs {
    var cardList: Observable<[Card]> { get }
    var error: Observable<Error> { get }
}

protocol SearchViewModelType {
    var inputs: SearchViewModelInputs { get }
    var outputs: SearchViewModelOutputs { get }
}

class SearchViewModel: SearchViewModelInputs, SearchViewModelOutputs {
    
    // MARK: INPUTS
    var searchText: AnyObserver<String>
    
    // MARK: OUTPUTS
    let cardList: Observable<[Card]>
    let error: Observable<Error>
    
    // MARK: OTHER
    private let provider = MoyaProvider<MtgAPI>()
    private let disposeBag = DisposeBag()
  
    init() {
        // PublishRelayとして初期値を持たない出力用内部Subjectを用意
        let _cardList = PublishRelay<[Card]>()
        self.cardList = _cardList.asObservable()
        
        let _error = PublishRelay<Error>()
        self.error = _error.asObservable()
        
        let _searchText = PublishRelay<String>()
        self.searchText = AnyObserver<String>() { event in
            // textをguard letで定義
            guard let text = event.element else { return }
            // acceptでPublishRelayに.nextイベントを送る
            _searchText.accept(text)
        }
        
//        let sequence = filterdText
//            .flatMapLatest { [weak self] text -> Observable<Event<[Card]>> in
//                return self.cardRepository
//                    .getCards(from: text)
//                    .materialize()
//            }
//            .share(replay: 1)
        
        CardRepository.getCards(from: searchDescription)
            
        
    }
}
