//
//  AddEntryView.swift
//  MemoryPuzzleDiary2
//
//  Created by GEU on 17/02/26.
//

import SwiftUI
import PhotosUI

struct AddEntryView: View {

    @Environment(\.dismiss)
    var dismiss

    var vm: DiaryViewModel

    @State private var selectedItem:
        PhotosPickerItem?

    @State private var selectedImage:
        UIImage?

    @State private var message = ""

    var body: some View {

        NavigationStack {

            VStack(spacing: 20) {

                PhotosPicker(
                    selection: $selectedItem,
                    matching: .images) {

                    if let img = selectedImage {

                        Image(uiImage: img)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)

                    } else {

                        Text("Select Image")
                    }
                }

                TextField("Enter memory message",
                          text: $message)
                    .textFieldStyle(.roundedBorder)

                Button("Save Memory") {

                    if let img = selectedImage {

                        vm.saveEntry(
                            image: img,
                            message: message)

                        dismiss()
                    }
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
            .navigationTitle("New Memory")
        }
        .onChange(of: selectedItem) {

            Task {

                if let data =
                    try? await
                    selectedItem?
                    .loadTransferable(
                        type: Data.self),
                   let uiImage =
                    UIImage(data: data) {

                    selectedImage = uiImage
                }
            }
        }
    }
}
