//
//  cellAct.swift
//  PROductivo
//
//  Created by Usuario Principal on 06/08/20.
//  Copyright © 2020 Loklo. All rights reserved.
//

import UIKit

class cellAct: UITableViewCell {
    var Cnum = Int()
    var Tnum = Int()
    var Lnum = -1
    @IBOutlet weak var MyImage: UIImageView!
    @IBOutlet weak var MyLabel: UILabel!
    @IBOutlet weak var myDias: UILabel!


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
