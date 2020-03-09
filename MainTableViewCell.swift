//
//  MainTableViewCell.swift
//  20190705
//
//  Created by りさこ on 2019/08/21.
//  Copyright © 2019 りさこ. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var genreL: UILabel!
    @IBOutlet weak var programL: UILabel!
    @IBOutlet weak var placeL: UILabel!
    @IBOutlet weak var dateL: UILabel!
    @IBOutlet weak var priceL: UILabel!
    @IBOutlet weak var ticketsL: UILabel!
    @IBOutlet weak var typeL: UILabel!
    @IBOutlet weak var seatL: UILabel!
    @IBOutlet weak var statusL: UILabel!
    @IBOutlet weak var partnerL: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
