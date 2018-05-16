//
//  CategoriasTableViewCell.swift
//  Trivial
//
//  Created by José Ángel on 6/4/18.
//  Copyright © 2018 Macosx. All rights reserved.
//

import UIKit

class GestionTableViewCell: UITableViewCell {
    
    // MARK: Properties
 

    @IBOutlet weak var foto: UIImageView!
    @IBOutlet weak var nombre: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
