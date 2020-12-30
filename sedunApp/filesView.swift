//
//  filesView.swift
//  sedunApp
//
//  Created by Carlos Escobar on 28/12/20.
//

import SwiftUI
import FirebaseStorage

struct Files:  Hashable, Identifiable{
    var id = UUID()
    var name: String
}


struct filesView: View {
    
    let storage = Storage.storage()
    @State var arrayDatos: [Files] = [Files]()
    var body: some View {
        List(){
            ForEach(arrayDatos, id:\.id){itemss in
                NavigationLink(destination: getFileView(name: itemss.name)){
                    HStack{
                        Text("\(itemss.name)")
                    }
                }
            }
        }.onAppear{
            arrayDatos = [Files]()
            let storageReference = storage.reference()
            storageReference.listAll{ (result, error) in
              if let error = error {
                print("Error \(error)")
              }
              for item in result.items {
                print("\(item.name)")
                arrayDatos.append(Files(name: item.name))
              }

            }
        }

    }
}

struct filesView_Previews: PreviewProvider {
    static var previews: some View {
        filesView()
    }
}
