//
//  Mtg.swift
//  RxApi
//
//  Created by Takuya Ando on 2021/05/19.
//

import Foundation
import Moya

public enum MtgAPI {
    
    case cards
}

extension MtgAPI: TargetType {
    
    public var baseURL: URL {
        return URL(string: "https://api.magicthegathering.io/v1")!
    }
    
    public var path: String {
        switch self {
        case .cards:
            return "/cards"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .cards:
            return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
                
        switch self {
        case .cards:
            print("きてます")
            return .requestParameters(
                parameters: [
                    "name" : "dark"
                ], encoding: URLEncoding.default)
        }
    }
    
    public var headers: [String : String]? {
        ["Content-Type": "application/json"]
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
}
