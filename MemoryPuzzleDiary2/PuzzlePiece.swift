//
//  PuzzlePiece.swift
//  MemoryPuzzleDiary2
//
//  Created by GEU on 17/02/26.
//

import Foundation
import UIKit

struct PuzzlePiece: Identifiable,
                    Equatable {

    let id = UUID()
    let correctIndex: Int
    var currentIndex: Int
    let image: UIImage
}
