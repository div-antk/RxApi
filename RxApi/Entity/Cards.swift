//
//  Cards.swift
//  RxApi
//
//  Created by Takuya Ando on 2021/06/07.
//

import Foundation
import Moya

public struct CardListResponse: Codable {
    let cards: [Card]
}

public struct Card: Codable {
    let imageUrl: String?
    let type: String?
}
