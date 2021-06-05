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
import Kingfisher

class ViewController: UIViewController, StoryboardInstantiatable {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var reloadButton: UIButton!
    
    var cards: CardListResponse?
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let provider = MoyaProvider<MtgAPI>()
        
        provider.request(.cards) { (result) in
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
        
        reloadButton.layer.cornerRadius = 4
        reloadButton.rx.tap.subscribe { [weak self] _ in
            self?.cardImage()
        }.disposed(by: disposeBag)
    }
    
    func cardImage() {
        if let cardImage = cards?.cards.randomElement()?.imageUrl {
            print(cardImage)
            cardImageView.kf.setImage(with: URL(string: cardImage))
        }
    }
}
