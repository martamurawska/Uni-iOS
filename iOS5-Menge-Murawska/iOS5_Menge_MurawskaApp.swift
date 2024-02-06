//
//  iOS5_Menge_MurawskaApp.swift
//  iOS5-Menge-Murawska
//
//  Created by Marta Murawska on 02.01.24.
//

import SwiftUI

@main
struct iOS5_Menge_MurawskaApp: App {
    @Environment(\.scenePhase) private var scenePhase
    var viewModel = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            MasterView(viewModel: viewModel)
                .environmentObject(viewModel)
                .onChange(of: scenePhase) { phase in
                    if phase == .inactive {
                        viewModel.saveModel()
                    }
                }
        }
    }
}
