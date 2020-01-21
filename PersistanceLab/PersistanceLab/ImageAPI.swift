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
    static func getImages(for searchQuery: String, completion: @escaping (Result<[Images], AppError>) -> ()) {
        
        let searchQuery = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "yellow flowers"
    
        let endpointURL = "https://pixabay.com/api/?key=14937007-dcbfa908ac4092d4eac3223ed&q=yellow+flowers&image_type=\(searchQuery)"
        
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
                    let result = try JSONDecoder().decode(Welcome.self, from: data)
                    completion(.success(result.hits))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
