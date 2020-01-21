//
//  ImageAPI.swift
//  PersistanceLab
//
//  Created by Brendon Cecilio on 1/20/20.
//  Copyright © 2020 Brendon Cecilio. All rights reserved.
//

import Foundation
import NetworkHelper

struct ImageAPIClient {
    static func getImages(completion: @escaping (Result<[Images], AppError>) -> ()) {
    
        let endpointURL = "https://pixabay.com/api/?key=14937007-dcbfa908ac4092d4eac3223ed&q=yellow+flowers&image_type=photo"
        
        guard let url = URL(string: endpointURL) else {
            completion(.failure(.badURL(endpointURL)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let result = try JSONDecoder().decode([Images].self, from: data)
                    let imageData = result
                    completion(.success(imageData))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
