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
    
    var cards: CardList?
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let provider = MoyaProvider<MtgAPI>()
        
        provider.request(.cards) { (result) in
            
            switch result {
            case .success(let response):
                let data = response.data
                //                let cards = try? JSONDecoder().decode([Cards].self, from: data)
                
                do {
                    let cards = try JSONDecoder().decode(CardList.self, from: data)
                    print("(´・ω・｀)", cards)
                   
                    self.cards = cards
                } catch(let error) {
                    
                    print(error)
                }
                
                
                
                
            case .failure(let error):
                print(error)
            }
        }
        print(cards?.cardList)
        
    }
}


