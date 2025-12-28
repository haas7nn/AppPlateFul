//
//  MyPickupsTableViewCell.swift
//  AppPlateFul
//
//  Created by Rashed Alsowaidi on 28/12/2025.
//

import UIKit

class MyPickupsTableViewCell: UITableViewCell {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var desclbl: UILabel!
    @IBOutlet weak var ViewDetailsBtn: UIButton!
    @IBOutlet weak var statusBtn: UIButton!
    
 
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
