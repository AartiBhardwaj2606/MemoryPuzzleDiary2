//
//  GroupingHelper.swift
//  MemoryPuzzleDiary2
//
//  Created by GEU on 17/02/26.
//

import Foundation
extension Array where Element == DiaryEntry {

    func groupedByMonth()
    -> [String : [DiaryEntry]] {

        Dictionary(grouping: self) {

            let formatter = DateFormatter()
            formatter.dateFormat = "MMMM yyyy"
            return formatter.string(from: $0.date)
        }
    }
}

