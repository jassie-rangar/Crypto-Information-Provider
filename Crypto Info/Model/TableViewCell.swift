//
//  TableViewCell.swift
//  Crypto Info
//
//  Created by Jaskirat Singh on 04/04/18.
//  Copyright © 2018 jassie. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell
{

    //MARK: IBOutlets
    @IBOutlet weak var currencyName: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var symbol: UILabel!
    @IBOutlet weak var priceUp: UIImageView!
    @IBOutlet weak var priceDown: UIImageView!
    @IBOutlet weak var amountChanged: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

