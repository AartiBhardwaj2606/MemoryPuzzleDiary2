//
//  UIImage+FixOrientation.swift
//  MemoryPuzzleDiary2
//
//  Created by GEU on 17/02/26.
//

import UIKit

extension UIImage {

    func fixedOrientation() -> UIImage {

        if imageOrientation == .up {
            return self
        }

        UIGraphicsBeginImageContextWithOptions(
            size,
            false,
            scale)

        draw(in: CGRect(
            origin: .zero,
            size: size))

        let normalized =
        UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()

        return normalized ?? self
    }
}

