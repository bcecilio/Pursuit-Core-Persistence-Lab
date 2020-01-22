//
//  FavortieImageTableViewCell.swift
//  PersistanceLab
//
//  Created by Brendon Cecilio on 1/22/20.
//  Copyright © 2020 Brendon Cecilio. All rights reserved.
//

import UIKit

class FavortieImageTableViewCell: UITableViewCell {

    @IBOutlet weak var favoriteImageView: UIImageView!
    
    func configureCell(for imageData: Images) {
        
        let imageURL = imageData.largeImageURL.description
        
        favoriteImageView.getImage(with: imageURL) { [weak self] (result) in
            switch result {
            case .failure(_):
                DispatchQueue.main.async {
                    self?.favoriteImageView.image = UIImage(systemName: "exclamationmark.fill")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.favoriteImageView.image = image
                }
            }
        }
    }
}
