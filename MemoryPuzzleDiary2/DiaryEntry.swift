//
//  DiaryEntry.swift
//  MemoryPuzzleDiary2
//
//  Created by GEU on 17/02/26.
//

import SwiftData
import Foundation

@Model
class DiaryEntry {

    var id: UUID
    var message: String
    var date: Date
    var imagePath: String

    init(message: String,
         date: Date,
         imagePath: String) {

        self.id = UUID()
        self.message = message
        self.date = date
        self.imagePath = imagePath
    }
}
