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
    
    // MARK: OTHER
    private let provider = MoyaProvider<MtgAPI>()
    private let disposeBag = DisposeBag()
  
    init() {
        // PublishRelayとして初期値を持たない出力用内部Subjectを用意
        let _cardList = PublishRelay<[Card]>()
        self.cardList = _cardList.asObservable()
        
        let _searchText = PublishRelay<String>()
        self.searchText = AnyObserver<String>() { event in
            // textをguard letで定義
            guard let text = event.element else { return }
            // acceptでPublishRelayに.nextイベントを送る
            _searchText.accept(text)
        }
        
        _searchText
            .debounce(RxTimeInterval.seconds(1), scheduler: MainScheduler.init())
            .flatMap { searchText in
                CardRepository.getCards(cardName: searchText)
            }
            .subscribe(onNext: { response in
                _cardList.accept(response)
            })
            .disposed(by: disposeBag)
        
    }
}
