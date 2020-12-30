//
//  ContentView.swift
//  sedunApp
//
//  Created by Carlos Escobar on 28/12/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{ //NEcesario para que NAvigationLink Funcone correctamente
            TabView{ // tabs abajo
                sendFileView()
                    .tabItem { //Define nombre e icono de tab
                        Text("Enviar")
                        Image(systemName: "square.and.arrow.up")
                    }.navigationBarHidden(true) //ocultar nombre de la tab arriba
                filesView()
                    .tabItem{ //Define nombre e icono de tab
                        Text("Archivos")
                        Image(systemName: "filemenu.and.selection")
                    }.navigationBarHidden(true)
            }.navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider { //Necesario para Canvas
    static var previews: some View {
        ContentView()
    }
}
