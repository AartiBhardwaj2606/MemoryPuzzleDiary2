//
//  EntryListView.swift
//  MemoryPuzzleDiary2
//
//  Created by GEU on 17/02/26.
//

import SwiftUI
import SwiftData
import UIKit


struct EntryListView: View {

    @Environment(\.modelContext)
    private var context

    // ⭐️ SwiftData AUTO UI REFRESH
    @Query(
        sort: \DiaryEntry.date,
        order: .reverse
    )
    private var allEntries: [DiaryEntry]

    @State private var showAddEntry = false

    // ⭐️ ONLY LAST 1 YEAR FILTER
    var entries: [DiaryEntry] {

        let oneYearAgo =
        Calendar.current.date(
            byAdding: .year,
            value: -1,
            to: Date())!

        return allEntries.filter {
            $0.date >= oneYearAgo
        }
    }

    var body: some View {

        NavigationStack {

            let grouped =
            entries.groupedByMonth()

            List {

                if entries.isEmpty {

                    Text("No memories yet 🥺")
                }

                ForEach(
                    grouped.keys.sorted(
                        by: >),
                    id: \.self) { key in

                    Section(
                        header:
                            Text(key)) {

                        ForEach(
                            grouped[key]!) {
                            entry in

                            NavigationLink {

                                PuzzleView(
                                    entry: entry)

                            } label: {

                                HStack {

                                    if let image =
                                        ImageStorageManager
                                        .loadImage(
                                            from:
                                                entry.imagePath) {

                                        Image(
                                            uiImage: image)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(
                                                width: 60,
                                                height: 60)
                                            .clipped()
                                            .cornerRadius(8)
                                    }

                                    Text(
                                        entry.date,
                                        style: .date)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle(
                "Memory Diary")

            // ⭐️ ADD BUTTON
            .toolbar {

                ToolbarItem(
                    placement:
                        .navigationBarTrailing) {

                    Button {

                        showAddEntry = true

                    } label: {

                        Image(
                          systemName:
                          "plus.circle.fill")
                            .font(.title2)
                    }
                }
            }

            // ⭐️ ADD ENTRY SHEET
            .sheet(
                isPresented:
                    $showAddEntry) {

                AddEntryView(
                    vm:
                        DiaryViewModel(
                            context:
                                context))
            }
        }
    }
}
