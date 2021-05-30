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
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchTextField: UITextField!
    
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
                    print(cards)
                } catch(let error) {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
        
        collectionView.delegate
        collectionView.dataSource
        
        collectionView.register(UINib(nibName: CardCollectionViewCell.reusableIdentifier, bundle: nil), forCellWithReuseIdentifier: CardCollectionViewCell.reusableIdentifier)
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return (cards?.cards.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cards?.cards.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionViewCell.reusableIdentifier, for: indexPath) as! CardCollectionViewCell
        
        return cell
    }
    
    
}
