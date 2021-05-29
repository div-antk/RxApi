//
//  CardCollectionViewCell.swift
//  RxApi
//
//  Created by Takuya Ando on 2021/05/29.
//

import UIKit
import Instantiate
import InstantiateStandard

class CardCollectionViewCell: UICollectionViewCell, Reusable {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var ptLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
