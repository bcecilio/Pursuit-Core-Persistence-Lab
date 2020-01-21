//
//  ImageCell.swift
//  PersistanceLab
//
//  Created by Brendon Cecilio on 1/20/20.
//  Copyright © 2020 Brendon Cecilio. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    func configureCell(for image: Images) {
        imageView.image = UIImage(contentsOfFile: image.largeImageURL)
    }
    
}
