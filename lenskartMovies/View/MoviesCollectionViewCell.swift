//
//  MoviesCollectionViewCell.swift
//  lenskartMovies
//
//  Created by Santhosh Konduru on 29/05/21.
//

import UIKit

class MoviesCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: MoviesCollectionViewCell.self)

    @IBOutlet weak var thumbNail: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
