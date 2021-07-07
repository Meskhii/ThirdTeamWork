//
//  HomeTableViewCell.swift
//  ThirdTeamWork
//
//  Created by Beqa Tabunidze on 07.07.21.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var CountryNameLabel: UILabel!
    @IBOutlet weak var capitalNameLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with item: CountryViewModel) {
        
        CountryNameLabel.text = item.name
        capitalNameLabel.text = item.capital
    }
    
}
