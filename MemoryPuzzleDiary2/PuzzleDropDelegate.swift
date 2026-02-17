//
//  PuzzleDropDelegate.swift
//  MemoryPuzzleDiary2
//
//  Created by GEU on 17/02/26.
//

import SwiftUI
import UniformTypeIdentifiers

struct PuzzleDropDelegate: DropDelegate {

    let item: PuzzlePiece
    var vm: PuzzleViewModel

    func performDrop(info: DropInfo) -> Bool {

        guard let provider =
              info.itemProviders(
                for: [.text]).first else {
            return false
        }

        provider.loadItem(
            forTypeIdentifier:
            UTType.text.identifier,
            options: nil) { data,_ in

            DispatchQueue.main.async {

                if let idData = data as? Data,
                   let idString =
                   String(data: idData,
                          encoding: .utf8),
                   let dragged =
                   vm.pieces.firstIndex(
                    where:
                    { "\($0.id)" ==
                        idString }),

                   let target =
                   vm.pieces.firstIndex(
                    of: item) {

                    vm.pieces.swapAt(
                        dragged,
                        target)

                    vm.checkSolved()
                }
            }
        }

        return true
    }
}

