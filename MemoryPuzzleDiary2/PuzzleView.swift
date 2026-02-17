//
//  PuzzleView.swift
//  MemoryPuzzleDiary2
//
//  Created by GEU on 17/02/26.
//

import SwiftUI
import UniformTypeIdentifiers

struct PuzzleView: View {

    let entry: DiaryEntry

    @State private var blurAmount: CGFloat = 20
//new for blur
    @State var vm: PuzzleViewModel?
    @State var showMessage = false

    var body: some View {

        VStack {

            if let vm {

                // ⭐️ SHOW ORIGINAL IMAGE AFTER SOLVE
//                if vm.solved {
//
//                    Image(
//                        uiImage:
//                            vm.originalImage)
//                        .resizable()
//                        .scaledToFit()
//                        .clipShape(
//                            RoundedRectangle(
//                                cornerRadius: 20))
//                        .padding()
//
//                    Text(entry.message)
//                        .padding()
//                        .transition(.opacity)
//                }//old before blur
                if vm.solved {

                    Image(
                        uiImage:
                            vm.originalImage)
                        .resizable()
                        .scaledToFit()
                        .clipShape(
                            RoundedRectangle(
                                cornerRadius: 20))
                        .padding()
                        .blur(radius: blurAmount)

                        // ⭐️ BLUR ANIMATION
                        .onAppear {

                            withAnimation(
                                .easeInOut(duration: 1.5)) {

                                blurAmount = 0
                            }
                        }

                    // ⭐️ MESSAGE APPEARS AFTER IMAGE CLEAR
                    if blurAmount == 0 {

                        Text(entry.message)
                            .padding()
                            .transition(.opacity)
                    }
                }

                else {

                    // ⭐️ PUZZLE GRID
                    LazyVGrid(
                        columns:
                            Array(
                                repeating:
                                    GridItem(
                                        .flexible(),
                                        spacing: 0),
                                count: 3),
                        spacing: 0) {

                        ForEach(
                            vm.pieces) {
                            piece in

                            Image(
                                uiImage:
                                    piece.image)
                                .resizable()
                                .scaledToFill()
                                .frame(
                                    height: 100)
                                .clipped()

                                // ⭐️ ROUNDED TILE EDGES
                                .clipShape(
                                    RoundedRectangle(
                                        cornerRadius: 6))

                                .onDrag {

                                    NSItemProvider(
                                        object:
                                        "\(piece.id)"
                                        as NSString)
                                }
                                .onDrop(
                                    of: [.text],
                                    delegate:
                                        PuzzleDropDelegate(
                                            item: piece,
                                            vm: vm))
                        }
                    }
                    .padding(4)
                }
            }
        }

        // ⭐️ SMOOTH TRANSITION ANIMATION
        .animation(
            .easeInOut,
            value: vm?.solved ?? false)

        .onAppear {

            let image =
            ImageStorageManager
                .loadImage(
                    from:
                        entry.imagePath)!

            vm =
            PuzzleViewModel(
                image: image)
        }
    }
}


//struct PuzzleView: View {
//
//    let entry: DiaryEntry
//    @State var vm: PuzzleViewModel?
//    @State var showMessage = false
//
//    var body: some View {
//
//        VStack {
//
//            if let vm {
//
//                LazyVGrid(
//                    columns:
//                    Array(
//                        repeating:
//                        GridItem(.flexible()),
//                        count: 3)) {
//
//                    ForEach(vm.pieces) {
//                        piece in
//
//                        Image(uiImage:
//                              piece.image)
//                        .resizable()
//                        .frame(height: 100)
//                        .onDrag {
//                            NSItemProvider(
//                                object:
//                                "\(piece.id)"
//                                as NSString)
//                        }
//                        .onDrop(of: [.text],
//                                delegate:
//                                PuzzleDropDelegate(
//                                    item: piece,
//                                    vm: vm))
//                    }
//                }
//
//                if vm.solved {
//                    Text(entry.message)
//                        .padding()
//                }
//            }
//        }
//        .onAppear {
//
//            let image =
//            ImageStorageManager
//                .loadImage(
//                    from:
//                    entry.imagePath)!
//
//            vm =
//            PuzzleViewModel(
//                image: image)
//        }
//    }
//}
