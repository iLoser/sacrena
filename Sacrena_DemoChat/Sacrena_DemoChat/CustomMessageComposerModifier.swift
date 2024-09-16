//
//  CustomMessageComposerModifier.swift
//  Sacrena_DemoChat
//
//  Created by Chermadurai Anandakumar on 15/09/24.
//

import Foundation
import SwiftUI
import UIKit


struct BackgroundViewModifier: ViewModifier {

    public func body(content: Content) -> some View {
        content
            .background(Color(hex: "#272727"))
    }
}

struct CustomSendMessageButton: View {
    let enabled: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap, label: {
            Image(systemName: "arrow.up")
                .foregroundColor(enabled ? .white : .gray)
                .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                .background(enabled ? Color.blue : Color.gray.opacity(0.3))
                .clipShape(Circle())
        })
        .disabled(!enabled)
    }
}

struct CustomMessageComposerModifier: View {
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage? = nil
    @Binding var text: String

    var body: some View {
        HStack(alignment: .bottom) {
            Button(action: {
                showImagePicker = true
            }) {
                Image(systemName: "camera")
                    .foregroundColor(.white)
                    .frame(width: 40, height: 40)
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(sourceType: .camera) { image in
                    selectedImage = image
                    // Handle the captured image (e.g., send it in chat)
                }
            }

            TextField("", text: $text, prompt: Text("  Message")
                .foregroundColor(.gray)
                .fontWeight(.thin)
            )
            .keyboardType(.default)
            .frame(height: 50)
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray))
        }
    }
}




struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    var onImagePicked: (UIImage) -> Void

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.onImagePicked(image)
            }
            parent.presentationMode.wrappedValue.dismiss()
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
