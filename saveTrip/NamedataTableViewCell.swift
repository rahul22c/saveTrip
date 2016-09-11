//
//  TripdataTableViewCell.swift
//  saveTrip
//
//  Created by Rahul Chandrawanshi on 8/21/16.
//  Copyright © 2016 Rahul Chandrawanshi. All rights reserved.
//

import UIKit

class NamedataTableViewCell: UITableViewCell {
    
    //MARK: Properties

    
    @IBOutlet weak var Tripimage: UIImageView!
    
    
    @IBOutlet weak var Name: UILabel!
    
    
    @IBOutlet weak var Tripname: UILabel!
    
    
    @IBOutlet weak var Place: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
