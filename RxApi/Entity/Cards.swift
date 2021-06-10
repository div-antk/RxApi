//
//  Cards.swift
//  RxApi
//
//  Created by Takuya Ando on 2021/06/07.
//

import Foundation
import Moya

struct CardListResponse: Codable {
    let cards: [Card]
}

struct Card: Codable {
    let imageUrl: String?
}
