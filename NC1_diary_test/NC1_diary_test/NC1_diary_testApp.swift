//
//  NC1_diary_testApp.swift
//  NC1_diary_test
//
//  Created by 정혜정 on 4/10/24.
//

import SwiftUI

@main

struct NC1_diary_testApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
//            CalenderView()
            
            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
