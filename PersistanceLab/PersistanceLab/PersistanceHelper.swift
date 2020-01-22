//
//  PersistanceHelper.swift
//  PersistanceLab
//
//  Created by Brendon Cecilio on 1/21/20.
//  Copyright © 2020 Brendon Cecilio. All rights reserved.
//

import Foundation

enum DataPersistanceError: Error {
    case savingError(Error)
    case fileDoesNotExist(String)
    case noData
    case decodingError(Error)
    case deletingError(Error)
}

class PersistanceHelper {
    
    private static var events = [Images]()
    
    private static let filename = "schedule.plist"
    
    static func save() throws {
        
        let url = FileManager.pathToDocumentsDirectory(with: filename)
        do {
            let data = try PropertyListEncoder().encode(events)
            try data.write(to: url, options: .atomic)
        } catch {
            throw DataPersistanceError.savingError(error)
        }
    }
    
    static public func saveImage(image: Images) throws {
        events.append(image)
        do {
            try save()
        } catch {
            throw DataPersistanceError.savingError(error)
        }
    }

    static func loadImage() throws -> [Images] {
        let url = FileManager.pathToDocumentsDirectory(with: filename)
        if FileManager.default.fileExists(atPath: url.path) {
            if let data = FileManager.default.contents(atPath: url.path) {
                do {
                    events = try PropertyListDecoder().decode([Images].self, from: data)
                } catch {
                    throw DataPersistanceError.decodingError(error)
                }
            } else {
                throw DataPersistanceError.noData
            }
        } else {
            throw DataPersistanceError.fileDoesNotExist(filename)
        }
        return events
    }
    

    static func deleteImage(image Index: Int) throws {
        events.remove(at: Index)
        do {
            try save()
        } catch {
            throw DataPersistanceError.deletingError(error)
        }
    }
    
}
