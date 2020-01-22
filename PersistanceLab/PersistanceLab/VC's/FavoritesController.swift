//
//  FavoritesController.swift
//  PersistanceLab
//
//  Created by Brendon Cecilio on 1/16/20.
//  Copyright © 2020 Brendon Cecilio. All rights reserved.
//

import UIKit

class FavoritesController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var favoriteImages = [Images]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        loadFavoriteImages()
    }
    
    func loadFavoriteImages() {
        do {
            favoriteImages = try PersistanceHelper.loadImage()
            print("fav images loaded")
            dump(favoriteImages)
        } catch {
            print("could not load saves images")
        }
    }
}

extension FavoritesController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteImageCell", for: indexPath) as? FavortieImageTableViewCell else {
            fatalError("could not downcast favoriteImageCell")
        }
        let favImage = favoriteImages[indexPath.row]
        cell.configureCell(for: favImage)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
