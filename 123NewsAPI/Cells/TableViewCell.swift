//
//  TableViewCell.swift
//  123NewsAPI
//
//  Created by Admin on 09.05.2021.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var descriptionLable: UILabel!
    @IBOutlet weak var sourseLable: UILabel!
    @IBOutlet weak var authorLable: UILabel!
    @IBOutlet weak var imgView: CustomImageView!
    @IBOutlet weak var dateOfPublish: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
