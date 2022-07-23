//
//  ContentView.swift
//  Shared
//
//  Created by Gregory Keeley on 7/20/22.
//

import SwiftUI

struct ColorButtonsMainView: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject var ghostDrawingVM = GhostDrawingViewModel()
    @State var currentDrawing = Drawing()
    var body: some View {
        ZStack {
            colorScheme == .dark ? Color.black.ignoresSafeArea() : Color.white.ignoresSafeArea()
            DrawingBoardView(currentDrawing: currentDrawing, drawings: [Drawing](), ghostDrawingVM: ghostDrawingVM)
            ZStack {
                VStack {
                    HStack {
                        Toggle(isOn: $ghostDrawingVM.timerIsActive) {
                        }
                        .frame(width: UIScreen.main.bounds.width * 0.2, height: 40, alignment: .center)
                        Image(systemName: "clock")
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width * 0.06, height: UIScreen.main.bounds.width * 0.06, alignment: .center)
                            .aspectRatio(contentMode: .fit)
                            .padding(.leading, 10)
                        Spacer()
                    }
                    .padding(.vertical)
                    Spacer()
                    HStack(alignment: .center,
                           spacing: 40,
                           content: {
                        ColorSelectionButton(color: Color.red, currentColor: $ghostDrawingVM.currentColor)
                        ColorSelectionButton(color: Color.blue, currentColor: $ghostDrawingVM.currentColor)
                        ColorSelectionButton(color: Color.green, currentColor: $ghostDrawingVM.currentColor)
                    })
                    .padding()
                }
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ColorButtonsMainView()
    }
}
