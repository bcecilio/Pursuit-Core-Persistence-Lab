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
    @IBOutlet weak var searchBar: UISearchBar!
    
    var searchQuery = ""
    
    var images = [Images]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.getDocumentsDirectory())
        searchBar.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
        loadData(searchQuery: "yellow flowers")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? DetailController, let indexPath = collectionView.indexPathsForSelectedItems?.first else {
            print("could not segue")
            return
        }
        detailVC.imageDetail = images[indexPath.row]
    }

    func loadData(searchQuery: String) {
        ImageAPIClient.getImages(for: searchQuery) { (result) in
            switch result {
            case .failure(_):
                print("no data found")
            case .success(let image):
                self.images = image
                dump(image)
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let interItemSpacing: CGFloat = 10 // space between items
        let maxWidth = UIScreen.main.bounds.size.width // device's width
        let numberOfitems: CGFloat = 3 // items
        let totalSpacing: CGFloat = numberOfitems * interItemSpacing
        let itemWidth: CGFloat = (maxWidth - totalSpacing) / numberOfitems
        
        return CGSize(width: itemWidth, height: itemWidth)
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let searchText = searchBar.text else {
            print("no text")
            return
        }
        loadData(searchQuery: searchText)
    }
}

