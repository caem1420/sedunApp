//
//  getFileView.swift
//  sedunApp
//
//  Created by Carlos Escobar on 28/12/20.
//

import SwiftUI
import FirebaseStorage

struct getFileView: View {
    let storage = Storage.storage()
    @State var name: String
    @State var image: UIImage = UIImage()
    @State var alertSaveImage = false
    var body: some View {
        Text(name)
            .bold()
            .onAppear{
            let storageReference = storage.reference()
            let islandRef = storageReference.child("\(name)")

            // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
            islandRef.getData(maxSize: 15 * 1024 * 1024) { data, error in
              if let error = error {
                // Uh-oh, an error occurred!
                print("Error \(error)")
              } else {
                // Data for "images/island.jpg" is returned
                self.image = UIImage(data: data!)!
                
              }
            }
        }
        Image(uiImage: image)
            .resizable()
                .frame(width: 220, height: 480)
            //.edgesIgnoringSafeArea(.all)
        Button(action: {
            let imageSaver = ImageSaver()
            imageSaver.writeToPhotoAlbum(image: image)
            self.alertSaveImage = true
        }){
            HStack{
                Text("Guardar Imagen")
                Image(systemName: "square.and.arrow.down")
            }
                
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
        .background(Color.blue)
        .foregroundColor(.white)
        .cornerRadius(20)
        .padding(.horizontal)
        .alert(isPresented: $alertSaveImage){
            Alert(title: Text("Exito"), message: Text("Imagen Guardada en la galeria con exito"), dismissButton: .default(Text("Listo!")))
        }
    }
}

class ImageSaver: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }

    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Save finished!")
    }
}

struct getFileView_Previews: PreviewProvider {
    static var previews: some View {
        getFileView(name: "2020-12-28 22:01:49")
    }
}
