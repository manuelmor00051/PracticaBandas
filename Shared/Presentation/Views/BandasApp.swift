//
//  BandasApp.swift
//  Shared
//
//  Created by Manuel Moreno Cámara on 18/2/22.
//

import SwiftUI

 @main
struct BandasApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
