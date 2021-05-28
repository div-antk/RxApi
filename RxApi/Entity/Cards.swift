//
//  Cards.swift
//  RxApi
//
//  Created by Takuya Ando on 2021/05/09.
//

import Foundation
import RxSwift
import Moya

struct CardListResponse: Codable {
    let cards: [Cards]
}

struct Cards: Codable {
    let name: String
}
