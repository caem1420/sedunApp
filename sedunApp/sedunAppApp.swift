//
//  sedunAppApp.swift
//  sedunApp
//
//  Created by Carlos Escobar on 28/12/20.
//

import SwiftUI
import Firebase

@main
struct sedunAppApp: App {
    init() {
        print("Ok Full Init()")
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
