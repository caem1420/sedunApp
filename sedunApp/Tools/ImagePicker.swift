//
//  ImagePicker.swift
//  sedunApp
//
//  Created by Carlos Escobar on 28/12/20.
//

import UIKit
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable{
    
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    @Binding var selectedImage: UIImage
    @Binding var path: NSURL
    @Binding var success: Bool
    @Environment(\.presentationMode) private var presentationMode
    
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController{
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {

    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
        
        var parent: ImagePicker
        
        init(_ parent: ImagePicker){
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            
            print("\(info[UIImagePickerController.InfoKey.imageURL] as! NSURL)")
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = image
                parent.path = info[UIImagePickerController.InfoKey.imageURL] as! NSURL
                parent.success = true
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
