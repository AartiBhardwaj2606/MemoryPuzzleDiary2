//
//  ImageStorageManager.swift
//  MemoryPuzzleDiary2
//
//  Created by GEU on 17/02/26.
//

import UIKit
import Foundation

struct ImageStorageManager {

    static func saveImage(_ image: UIImage) -> String {

        let filename = UUID().uuidString + ".jpg"
        let url = getDocumentsDirectory().appendingPathComponent(filename)

        if let data = image.jpegData(compressionQuality: 0.9) {
            try? data.write(to: url)
        }

        return filename
    }

    static func loadImage(from path: String) -> UIImage? {

        let url = getDocumentsDirectory().appendingPathComponent(path)
        return UIImage(contentsOfFile: url.path)
    }

    static func getDocumentsDirectory() -> URL {

        FileManager.default.urls(for: .documentDirectory,
                                 in: .userDomainMask)[0]
    }
}
