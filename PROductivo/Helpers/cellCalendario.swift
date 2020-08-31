//
//  cellCalendario.swift
//  PROductivo
//
//  Created by hijos on 8/31/20.
//  Copyright © 2020 Loklo. All rights reserved.
//

import UIKit

class cellCalendario: UITableViewCell {
    var Cnum = Int()
    var Tnum = Int()
    var Lnum = -1
    
    @IBOutlet weak var MyLabel: UILabel!
    @IBOutlet weak var myDias: UILabel!
    @IBOutlet weak var MyImage: UIImageView!
    override func awakeFromNib() {
         super.awakeFromNib()
         // Initialization code
     }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
