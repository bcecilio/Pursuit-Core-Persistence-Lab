//
//  ImageCell.swift
//  PersistanceLab
//
//  Created by Brendon Cecilio on 1/20/20.
//  Copyright © 2020 Brendon Cecilio. All rights reserved.
//

import UIKit
import ImageKit

class ImageCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    func configureCell(for image: Images) {
        imageView.getImage(with: image.largeImageURL) { [weak self] (result) in
            switch result {
            case .failure(_):
                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(systemName: "exclamationmark-triangle")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.imageView.image = image
                }
            }
        }
    }
    
}
