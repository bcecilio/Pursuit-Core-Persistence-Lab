//
//  ViewController.swift
//  PersistanceLab
//
//  Created by Brendon Cecilio on 1/16/20.
//  Copyright © 2020 Brendon Cecilio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var images = [Images]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? DetailController, let indexPath = collectionView.indexPathsForSelectedItems?.first else {
            print("could not segue")
            return
        }
        detailVC.imageDetail = images[indexPath.row]
    }

    func loadData() {
        ImageAPIClient.getImages { (result) in
            switch result {
            case .failure(_):
                print("no data found")
            case .success(let image):
                self.images = image
            }
        }
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as? ImageCell else {
            fatalError("could not downcast imageCell")
        }
        let imageCell = images[indexPath.row]
        cell.configureCell(for: imageCell)
        return cell
    }
    
    
}

