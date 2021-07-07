//
//  HomeTableViewCell.swift
//  ThirdTeamWork
//
//  Created by Beqa Tabunidze on 07.07.21.
//

import UIKit
import MapKit

protocol ClickDelegate {
    func clicked(_ row: Int)
}

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var CountryNameLabel: UILabel!
    @IBOutlet weak var capitalNameLabel: UILabel!

    var storyboard = UIStoryboard(name: "MapViewController", bundle: nil)
    let navigationController = UINavigationController()

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
    
    
    @IBAction func onTapMap(_ sender: UIButton) {
        
        
        let vc = storyboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        self.navigationController.pushViewController(vc, animated: true)
        print("tapped")
        
        
    }
    
    
}
