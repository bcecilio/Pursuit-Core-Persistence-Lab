//
//  ImageData.swift
//  PersistanceLab
//
//  Created by Brendon Cecilio on 1/20/20.
//  Copyright © 2020 Brendon Cecilio. All rights reserved.
//

import Foundation

struct Welcome: Codable {
    let totalHits: Int
    let hits: [Images]
    let total: Int
}

struct Images: Codable {
    let largeImageURL: String
    let webformatHeight, webformatWidth, likes, imageWidth: Int
    let favorites, imageSize, previewWidth: Int
    let userImageURL, previewURL: String
}
