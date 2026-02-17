//
//  MemoryPuzzleDiary2App.swift
//  MemoryPuzzleDiary2
//
//  Created by GEU on 17/02/26.
//

import SwiftUI
import SwiftData

@main
struct MemoryPuzzleDiary2App: App {
    var body: some Scene {
        WindowGroup {

                    NavigationStack {

                        EntryListView()
                    }
                }
                .modelContainer(for: DiaryEntry.self)
            }
}
