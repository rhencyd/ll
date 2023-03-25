//
//  ImagesModelFileManager.swift
//  FoodOrderingApp
//
//  Created by Rhency Delgado on 3/18/23.
//

import Foundation
import SwiftUI

class ImagesModelFileManager {
    
    static let instance = ImagesModelFileManager()
    let folderName = "downloaded_images"
    
    private init () {
        createFolderIfNeeded()
    }
    
    private func createFolderIfNeeded() {
        guard let url = getFolderPath() else { return }
        
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
                print(" Created folder!")
            } catch let error {
                print("Error creating folder. \(error)")
            }
        }
    }
    
    private func getFolderPath() -> URL? {
        return FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask).first?
            .appendingPathComponent(folderName)
    }
    
    // .../downloaded_images/
    // .../downloaded_images/image_name.jpg
    
    private func getImagePath(key: String) -> URL? {
        guard let folder = getFolderPath() else {
            return nil
        }
        return folder.appendingPathComponent(key + ".jpg")
    }
    
    func add(key: String, value: UIImage) {
        guard
            let data = value.jpegData(compressionQuality: 1.0),
            let url = getImagePath(key: key) else { return }
        
        do {
            try data.write(to: url)
        } catch let error {
            print("Error saving to file manager. \(error)")
        }
    }
    
    func get(key: String) -> UIImage? {
        guard
            let url = getImagePath(key: key),
            FileManager.default.fileExists(atPath: url.path) else {
            return nil
        }
        return UIImage(contentsOfFile: url.path)
    }
}
