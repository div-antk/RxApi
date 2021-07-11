//
//  CardCollectionViewCell.swift
//  RxApi
//
//  Created by Takuya Ando on 2021/07/11.
//

import UIKit
import Instantiate
import InstantiateStandard

class CardCollectionViewCell: UICollectionViewCell, Reusable {

    @IBOutlet weak var cardImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
