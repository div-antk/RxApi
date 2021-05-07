//
//  TableViewCell.swift
//  RxApi
//
//  Created by Takuya Ando on 2021/05/06.
//

import UIKit
import Instantiate
import InstantiateStandard

class TableViewCell: UITableViewCell, Reusable {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
