//
//  DetailController.swift
//  PersistanceLab
//
//  Created by Brendon Cecilio on 1/16/20.
//  Copyright © 2020 Brendon Cecilio. All rights reserved.
//

import UIKit

class DetailController: UIViewController {
    
    @IBOutlet weak var detailImageView: UIImageView!
    
    var imageDetail: Images?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func favoriteButtonPressed(_ sender: UIButton) {
        guard let favoriteImage = imageDetail else {
            print("no image found/saved")
            return
        }
        do {
            try? PersistanceHelper.saveImage(image: favoriteImage)
            print("image saved")
        } catch {
            print("could not load saved image")
        }
    }
    
    
    func updateUI() {
        guard let image = imageDetail else {
            return
        }
        
        let picture = image.largeImageURL
        let imageURL = "https://pixabay.com/api/?key=14937007-dcbfa908ac4092d4eac3223ed&q=\(picture)"
        
        detailImageView.getImage(with: imageURL, writeTo: .documentsDirectory) { [weak self] (result) in
            switch result {
            case .failure(_):
                DispatchQueue.main.async {
                    self?.detailImageView.image = UIImage(systemName: "exclamationmark.fill")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.detailImageView.image = image
                }
            }
        }
    }
}
