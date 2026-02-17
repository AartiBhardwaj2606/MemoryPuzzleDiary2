//
//  PuzzleViewModel.swift
//  MemoryPuzzleDiary2
//
//  Created by GEU on 17/02/26.
//

import Foundation
import SwiftUI
import UIKit

@Observable
class PuzzleViewModel {

    var pieces: [PuzzlePiece] = []
    var solved = false
    
    var originalImage: UIImage
    //Added new

    //new
    
    init(image: UIImage,
         grid: Int = 3) {

        self.originalImage =
        image.fixedOrientation()

        generatePuzzle(
            image: self.originalImage,
            grid: grid)
    }

    
    //old
//    init(image: UIImage,
//         grid: Int = 3) {
//
//        generatePuzzle(image: image,
//                       grid: grid)
//    }

    func generatePuzzle(image: UIImage,
                        grid: Int) {

        // ⭐️ FIX ORIENTATION FIRST
        let fixedImage =
        image.fixedOrientation()

        let cgImage =
        fixedImage.cgImage!

        let width =
        CGFloat(cgImage.width)

        let height =
        CGFloat(cgImage.height)

        let pieceWidth =
        width / CGFloat(grid)

        let pieceHeight =
        height / CGFloat(grid)

        var temp: [PuzzlePiece] = []

        for row in 0..<grid {
            for col in 0..<grid {

                let rect = CGRect(
                    x: CGFloat(col) * pieceWidth,
                    y: CGFloat(row) * pieceHeight,
                    width: pieceWidth,
                    height: pieceHeight)

                if let cropped =
                    cgImage.cropping(to: rect) {

                    let piece =
                    PuzzlePiece(
                        correctIndex:
                            row * grid + col,
                        currentIndex:
                            row * grid + col,
                        image:
                            UIImage(
                                cgImage:
                                    cropped)
                    )

                    temp.append(piece)
                }
            }
        }

        pieces =
        temp.shuffled()
    }

    
    func checkSolved() {

        solved =
        pieces.enumerated().allSatisfy {

            $0.offset ==
            $0.element.correctIndex
        }
    }
}
