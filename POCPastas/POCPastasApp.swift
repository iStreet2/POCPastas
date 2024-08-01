//
//  POCPastasApp.swift
//  POCPastas
//
//  Created by Gabriel Vicentin Negro on 30/07/24.
//

import SwiftUI

@main
struct POCPastasApp: App {
    
    @StateObject var vm = ViewModel()
    
    //CoreData
    @StateObject var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView(context: dataController.container.viewContext)
                .environmentObject(vm)
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
