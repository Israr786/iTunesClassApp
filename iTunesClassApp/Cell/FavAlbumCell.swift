//
//  FavAlbumCell.swift
//  iTunesClassApp
//
//  Created by Israrul on 4/8/20.
//  Copyright © 2020 Israrul Haque. All rights reserved.
//

import UIKit

class FavAlbumCell: UITableViewCell {

 //   var album: Artist?
        static let reuseIdentifier = "FavAlbumCell"
        
   //     weak var delegate: CellDelegate?
        @IBOutlet weak var artworkView: UIImageView!
        @IBOutlet weak var albumTitleLabel: UILabel!
        @IBOutlet weak var genreLabel: UILabel!
        @IBOutlet weak var releaseDateLabel: UILabel!
        @IBOutlet weak var starButton: UIButton!
       
       override func awakeFromNib() {
           super.awakeFromNib()
           // Initialization code
       }

       override func setSelected(_ selected: Bool, animated: Bool) {
           super.setSelected(selected, animated: animated)

           // Configure the view for the selected state
       }
}
