//
//  ProblemAPI.swift
//  RxApi
//
//  Created by Takuya Ando on 2021/05/26.
//

import Foundation
import Moya

enum ProblemAPI {
    case problem
}

extension ProblemAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://kenkoooo.com")!
    }
    
    var path: String {
        switch self {
        case .problem:
            return "/atcoder/resources/problems.json"
        }
    }
    
    var method: Moya.Method {
        return Moya.Method.get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }
}
