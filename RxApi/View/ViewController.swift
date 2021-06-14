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
    var cardName: String?
    
    private let disposeBag = DisposeBag()
    private let viewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let provider = MoyaProvider<MtgAPI>()
        
        provider.request(.card(cardName ?? "")) { (result) in
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
        
        
        searchTextField.rx.text.orEmpty.asObservable().subscribe { [weak self] in
                guard let text = $0.element else { return }
                self?.viewModel.set(text: text)
            }
            .disposed(by: disposeBag)
        
        // VMから受け取ってカード名に代入
        viewModel.searchText.asObservable().subscribe { [weak self] in
                self?.cardName = $0.element
            }.disposed(by: disposeBag)
    }
    
    func cardImage() {
        if let cardImage = cards?.cards.randomElement()?.imageUrl {
            cardImageView.kf.setImage(with: URL(string: cardImage))
        }
    }
}
