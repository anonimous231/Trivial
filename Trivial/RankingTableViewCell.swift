//
//  rankingTableViewCell.swift
//  Trivial
//
//  Created by José Ángel on 14/4/18.
//  Copyright © 2018 Macosx. All rights reserved.
//

import UIKit

class RankingTableViewCell: UITableViewCell {
    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var puntuacion: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
