//
//  SelectedTableViewCell.swift
//  MyTask2
//
//  Created by Luka Bukuri on 07.07.21.
//

import UIKit

class SelectedTableViewCell: UITableViewCell {

    @IBOutlet weak var countryLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with country: String)
    {
        countryLabel.text = country
    }
    
}
