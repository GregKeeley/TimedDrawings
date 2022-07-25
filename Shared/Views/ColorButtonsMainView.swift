//
//  ContentView.swift
//  Shared
//
//  Created by Gregory Keeley on 7/20/22.
//

import SwiftUI

struct ColorButtonsMainView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var ghostDrawingVM = GhostDrawingViewModel()
    
    var body: some View {
        ZStack {
            colorScheme == .dark ? Color.black.ignoresSafeArea() : Color.white.ignoresSafeArea()
            DrawingBoardView(ghostDrawingVM: ghostDrawingVM)
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
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                    .padding(.vertical)
                    Spacer()
                    ColorSelector(viewModel: ghostDrawingVM)
                        .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.width * 0.2, alignment: .center)
                        .padding(.bottom)
                }
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ColorButtonsMainView()
            .preferredColorScheme(.light)
    }
}
