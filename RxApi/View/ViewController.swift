//
//  ViewController.swift
//  RxApi
//
//  Created by Takuya Ando on 2021/04/30.
//

import UIKit
import RxSwift
import RxCocoa
import Moya
import Instantiate
import InstantiateStandard

class ViewController: UIViewController, StoryboardInstantiatable {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
        
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let provider = MoyaProvider<MtgAPI>()

        provider.request(.cards) { (result) in

            switch result {
            case .success(let response):
//                    let data = response.data
                let cards = try? JSONDecoder().decode([Cards].self, from: response.data)

                print(response.data)
//                for card in cards! {
//                    print(card)
//                }



            case .failure(let error):
                print(error)
            }

        }

//        let provider = MoyaProvider<ProblemAPI>()
//             provider.request(.problem) { (result) in
//                 switch result {
//                 case .success(let response):
//                     let data = response.data
//                     let problems = try? JSONDecoder().decode([Problem].self, from: data)
//
//                     for problem in problems! {
//                         print(problem.id, problem.contestId, problem.title)
//                     }
//                 case .failure(let error):
//                     print(error)
//                 }
//             }
    }
}


