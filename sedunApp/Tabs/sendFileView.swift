//
//  sendFileView.swift
//  sedunApp
//
//  Created by Carlos Escobar on 28/12/20.
//

import SwiftUI
import FirebaseStorage

struct sendFileView: View {
    @State var isSHowPhotoLibrary = false //State para abrir la photo library
    @State private var image = UIImage() // variable tipo UIIMage donde se guardara la foto seleccionada
    @State var path: NSURL = NSURL() //variable donde se guarda la direccion local de la imagen seleccionada
    @State var readyImage = false // boolean que nos informa si ya se selecciono una imagen
    @State var alertSubida = false //boolean para la alerta generada al subirse una imagen
    @State var sheetShowTextoPersonalizado = false //Boolean para la apertura del sheet donde se puede poner nombre personalizado
    @State var textoPersonalizado = "" // TExto personalizado
    let storage = Storage.storage() // Inicializador de Storage en firebase
    
    var body: some View {
        VStack{
            Text("Seleccione la imagen que quiere enviar")
                .bold()
            Image(uiImage: self.image) //Mostrara la imagen una vez seleccionada
                .resizable()
                .frame(minWidth: 0, maxWidth: .infinity)
                .edgesIgnoringSafeArea(.all)
                
            Button(action: {
                self.isSHowPhotoLibrary = true //mostrar sheet de photo library
            }){
                HStack{
                    Image(systemName: "photo")
                    Text("Seleccionar")
                        .bold()
                    Text("\(self.path)")
                    
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(20)
                .padding(.horizontal)
            }.sheet(isPresented: $isSHowPhotoLibrary){
                ImagePicker(sourceType: .photoLibrary, selectedImage: $image, path: $path, success: $readyImage) //se llama a la clase ImagePicker
            }
            Spacer()
            Button(action:{
                if(self.readyImage){
                    let time = Date() // se crea un objeto Fecha
                        let timeFormatter = DateFormatter() // se crea un objeto para dearle formato a la fecha
                        timeFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // Se especifica el formato
                        let stringDate = timeFormatter.string(from: time) // se le da formato a la fecha ya creada
                    let storageRef = storage.reference().child("\(stringDate)") // secrea una referencia de storage con el nombre del archivo a guardar
                    print("-------------------------------------------------------------")
                    print("\(path)")
                   
                    storageRef.putData(image.jpegData(compressionQuality: 1)!, metadata: nil){ // se envia la imagen en jpeg a storage en firebase
                        (_, err) in
                        if let err = err {
                            print("an error has occurred - \(err.localizedDescription)") //catch error
                        }else{
                            print("Subida ---")
                            self.alertSubida = true // se muestra la alerta exitosa
                        }
                    }
                }
            }){
                HStack{
                    Image(systemName: "square.and.arrow.up")
                    Text("Enviar").bold()
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(20)
            .padding(.horizontal)
            .alert(isPresented: $alertSubida){
                Alert(title: Text("Exito"), message: Text("Imagen Subida con exito"), dismissButton: .default(Text("Listo!")))
            }
            Spacer()
            Button(action: {
                print("Enviar con nombre personalizado")
                self.sheetShowTextoPersonalizado = true
            }){
                HStack{
                    Image(systemName: "square.and.arrow.up")
                    Text("Enviar con nombre").bold()
                }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(20)
                .padding(.horizontal)
            }.sheet(isPresented: $sheetShowTextoPersonalizado, content: {
                VStack{
                    Button(action: {
                        self.isSHowPhotoLibrary = true
                    }){
                        HStack{
                            Image(systemName: "photo")
                            Text("Seleccionar")
                                .bold()
                            Text("\(self.path)")
                            
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                        .padding(.horizontal)
                    }
                    
                    if(readyImage){
                        
                        Text("Ingrese Texto Personalizado").bold()
                        TextField("Ingrese Texto Personalizado", text: $textoPersonalizado)
                            .frame(width: 150, height: 50, alignment: .center)
                        Button(action:{
                            if(self.textoPersonalizado != ""){
                                
                                let storageRef = storage.reference().child("\(self.textoPersonalizado)")
                                print("-------------------------------------------------------------")
                                print("\(path)")
                               
                                storageRef.putData(image.jpegData(compressionQuality: 1)!, metadata: nil){
                                    (_, err) in
                                    if let err = err {
                                        print("an error has occurred - \(err.localizedDescription)")
                                    }else{
                                        print("Subida ---")
                                        self.alertSubida = true
                                        self.sheetShowTextoPersonalizado = false
                                    }
                                }
                            }
                        }){
                            HStack{
                                Image(systemName: "square.and.arrow.up")
                                Text("Enviar")
                            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                            .padding(.horizontal)
                        }
                    }
                    
                }
            })
            Spacer()
        }
    }
}

struct sendFileView_Previews: PreviewProvider {
    static var previews: some View {
        sendFileView()
    }
}
