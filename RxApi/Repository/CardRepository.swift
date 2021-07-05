//
//  CardRepository.swift
//  RxApi
//
//  Created by Takuya Ando on 2021/06/14.
//

import Foundation
import RxSwift
import RxCocoa
import Moya

final class CardRepository {
    private static let provider = MoyaProvider<MtgAPI>()
    private static let disposeBag = DisposeBag()
}

extension CardRepository {
    
    static func getCards(cardName: String) -> Observable<[Card]> {
        provider.rx.request(.card(cardName))
            // mapでレスポンスの配列にdecoderを適応
            .map { response in
                let decoder = JSONDecoder()
                return try decoder.decode([Card].self, from: response.data)
            }
            .asObservable()
    }
}

//
//public protocol CardRepository {
//    func getCards(from cardName: String) -> Observable<[Card]>
//}

//public class DefaultCardRepository: CardRepository {
//
//    var cardName: String?
//    var cards = [Card]()
//
//    public func getCards(from cardName: String) -> Observable<[Card]> {
//
//
//        provider.request(.card(cardName)) { (result) in
//            switch result {
//
//            case .success(let response):
//                let data = response.data
//
//                do {
//                    let cards = try JSONDecoder().decode(CardListResponse.self, from: data)
//                    self.cards = cards.cards
////                    self.cardImage()
//                } catch(let error) {
//                    print(error)
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
//}
