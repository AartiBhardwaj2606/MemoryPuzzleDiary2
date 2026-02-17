//
//  DiaryViewModel.swift
//  MemoryPuzzleDiary2
//
//  Created by GEU on 17/02/26.
//

import SwiftData
import SwiftUI
import Foundation
import UIKit

@Observable
class DiaryViewModel {

    var context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    // ONLY LAST 1 YEAR ENTRIES
//    func fetchEntries() -> [DiaryEntry] {
//
//        let oneYearAgo =
//        Calendar.current.date(byAdding: .year,
//                              value: -1,
//                              to: Date())!
//
//        let descriptor = FetchDescriptor<DiaryEntry>(
//            predicate: #Predicate {
//                $0.date >= oneYearAgo
//            },
//            sortBy: [SortDescriptor(\.date, order: .reverse)]
//        )
//
//        return (try? context.fetch(descriptor)) ?? []
//    }

    // ONLY ONE ENTRY PER DAY
    func saveEntry(image: UIImage,
                   message: String) {

        let calendar = Calendar.current

        let startOfToday =
        calendar.startOfDay(for: Date())

        let startOfTomorrow =
        calendar.date(byAdding: .day,
                      value: 1,
                      to: startOfToday)!

        // FETCH ENTRY BETWEEN TODAY 00:00 → TOMORROW 00:00
        let descriptor =
        FetchDescriptor<DiaryEntry>(
            predicate: #Predicate {

                $0.date >= startOfToday &&
                $0.date < startOfTomorrow
            }
        )

        // DELETE IF EXISTS
        if let old =
            try? context.fetch(descriptor).first {

            context.delete(old)
        }

        let path =
        ImageStorageManager.saveImage(image)

        let newEntry =
        DiaryEntry(message: message,
                   date: Date(),
                   imagePath: path)

        context.insert(newEntry)

        try? context.save()
    }

}
