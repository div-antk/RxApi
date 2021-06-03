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
                    self.collectionView.reloadData()
                } catch(let error) {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: CardCollectionViewCell.reusableIdentifier, bundle: nil), forCellWithReuseIdentifier: CardCollectionViewCell.reusableIdentifier)
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return (cards?.cards.count)!
//        print(cards?.cards)
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return (cards?.cards.count)!
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionViewCell.reusableIdentifier, for: indexPath) as! CardCollectionViewCell
        
        print(cards?.cards[indexPath.row].imageUrl)
        
        if let name = cards?.cards[indexPath.row].name {
            cell.nameLabel.text = name
        }
        
        if let manaCost = cards?.cards[indexPath.row].manaCost {
            cell.costLabel.text = manaCost
        }
        
        if let text = cards?.cards[indexPath.row].text {
            cell.textLabel.text = text
        }
        
        if let text = cards?.cards[indexPath.row].text {
            cell.textLabel.text = text
        }
        
        cell.ptLabel.text = "\(cards?.cards[indexPath.row].power) / \(cards?.cards[indexPath.row].toughness)"
        
        return cell
    }
    
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    // カスタムセルのサイズ
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: view.frame.width - 32, height: 600)
    }

    // 各カスタムセル外枠の余白
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//
//        return UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16)
//    }
}
