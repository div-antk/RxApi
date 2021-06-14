//
//  CardRepository.swift
//  RxApi
//
//  Created by Takuya Ando on 2021/06/14.
//

import Foundation
import Moya

class CardRepository {
    
    let provider = MoyaProvider<MtgAPI>()
    var cardName: String?
    var cards = [Card]()
    
    func getCards(cardName: String) {
        
        provider.request(.card(cardName)) { (result) in
            switch result {
            
            case .success(let response):
                let data = response.data
                
                do {
                    let cards = try JSONDecoder().decode(CardListResponse.self, from: data)
                    self.cards = cards
                    self.cardImage()
                } catch(let error) {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}


