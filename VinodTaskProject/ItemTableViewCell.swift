//
//  ItemTableViewCell.swift
//  VinodTaskProjectTests
//
//  Created by Vinod K on 07/04/20.
//  Copyright © 2020 Vinod K. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var timeDate: UILabel!
    @IBOutlet weak var ItemTittle: UILabel!
    @IBOutlet weak var ItemimageView: UIImageView!
    
    
    var itemObject : Item? {
           didSet {               
               guard let item = itemObject else {
                   return
               }
              ItemTittle.text = item.Title
               timeDate.text = item.DateTime
               DispatchQueue.global(qos: .background).async {
                   // Background Thread
                   let image =  UIImage(url: URL(string: item.imageUrl))
                   DispatchQueue.main.async {
                       // Run UI Updates or call completion block
                    self.ItemimageView.image = image
                   }
               }
           }
       }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
