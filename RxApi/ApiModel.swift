//
//  ApiModel.swift
//  RxApi
//
//  Created by Takuya Ando on 2021/05/09.
//

import Foundation
import RxSwift

struct SearchResponce: Decodable {
    let query: Query
    
    struct Query: Decodable {
        let search: [ApiModel]
    }
}

struct ApiModel {
    let id: String
    let title: String
    let url: URL
}

extension ApiModel: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        
        // WikipediaAPIに準拠
        case id = "padeid"
        case title
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = String(try container.decode(Int.self, forKey: .id))
        self.title = try container.decode(String.self, forKey: .title)
        self.url = URL(string: "https://ja.wikipedia.org/w/input.php?curid=\(id)")!
    }
}

// protocol Equatableに準拠して比較できるようにする
extension ApiModel: Equatable {
    
    static func == (lhs: ApiModel, rhs: ApiModel) -> Bool {
        return lhs.id == rhs.id
    }
}
