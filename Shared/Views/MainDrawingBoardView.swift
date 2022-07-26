//
//  MainDrawingBoardView.swift
//  Shared
//
//  Created by Gregory Keeley on 7/20/22.
//

import SwiftUI

struct MainDrawingBoardView: View {
    /// Environment object for tracking the users dark/light mode.
    @Environment(\.colorScheme) var colorScheme
    /// The view model needed for drawings.
    @ObservedObject var viewModel = DrawingViewModel()
    /// Determines whether or not to show the alert, to clear all drawings on shake of the device.
    @State var showAlert = false
     
    var body: some View {
        ZStack {
            // Change background color based on the users preference for dark/light mode on their phone.
            colorScheme == .dark ? Color.black.ignoresSafeArea() : Color.white.ignoresSafeArea()
            // Canvas drawing board.
            ZStack {
                VStack {
                    HStack {
                        // Toggle for the time delay.
                        Toggle("", isOn: $viewModel.delayIsActive)
                            .frame(width: UIScreen.main.bounds.width * 0.2,
                                   height: 40,
                                   alignment: .center)
                            .hidden(!(viewModel.clearButtonTapsInARow >= 6))
                        Image(systemName: "clock")
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width * 0.06,
                                   height: UIScreen.main.bounds.width * 0.06,
                                   alignment: .center)
                            .aspectRatio(contentMode: .fit)
                            .padding(.leading, 10)
                            .foregroundColor(.secondary)
                            .hidden(!(viewModel.clearButtonTapsInARow >= 6))
                        Spacer()
                    }
                    CanvasView(ghostDrawingVM: viewModel)
                        .padding()
                    Spacer()
                    // Color selection tool at the bottom of the view.
                    ColorSelector(viewModel: viewModel)
                        .frame(width: UIScreen.main.bounds.width * 0.8,
                               height: UIScreen.main.bounds.width * 0.2,
                               alignment: .center)
                        .padding(.bottom)
                }
            }
        }
        .onShake {
            showAlert = true
        }
        .alert(isPresented: $showAlert) { () -> Alert in
            let primaryButton = Alert.Button.default(Text("Clear")) {
                viewModel.clearAllDrawings()
            }
            return Alert(title: Text("Clear Drawing?"),
                         message: Text("Are you sure you would like to clear the entire drawing?"),
                         primaryButton: primaryButton,
                         secondaryButton: .cancel())
        }
    }
    
}


// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainDrawingBoardView()
            .preferredColorScheme(.dark)
    }
}
