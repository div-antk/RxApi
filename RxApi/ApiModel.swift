//
//  ApiModel.swift
//  RxApi
//
//  Created by Takuya Ando on 2021/05/09.
//

import Foundation
import RxSwift

// TODO:あとでMoyaに書き直す
import Alamofire

final class ApiModel {
    
    func searchArticles(word: String) -> Observable<Articles?> {
        return Observable.create { observer in
            let url = "https://connpass.com/api/v1/event/?keyword=\(word)"
            AF.request(url,
                       method: .get,
                       parameters: nil)
                .responseJSON(completionHandler: { response in
                    switch response.result {
                    
                    case.success(_):
                        print("API成功\n")
                        if let data = response.data {
                            let decoder = JSONDecoder()
                            decoder.keyDecodingStrategy = .convertFromSnakeCase
                            if let result = try? decoder.decode(Articles.self, from: data) {
                                print(result)
                                observer.onNext(result)
                            }
                        }
                        observer.onCompleted()
                    
                    case.failure(let error):
                        print("API失敗\n")
                        print(error)
                        observer.onError(error)
                    }
                })
            return Disposables.create()
        }
    }
}

struct Articles: Codable {
    let articles: [Article]?
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        articles = try values.decodeIfPresent([Article].self, forKey: .articles)
    }
}

struct Article: Codable {
    let title: String?
    let startedAt: String?
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        startedAt = try values.decodeIfPresent(String.self, forKey: .startedAt)
    }
}
