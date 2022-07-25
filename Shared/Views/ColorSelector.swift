//
//  ColorSelector.swift
//  GhostDrawings (iOS)
//
//  Created by Gregory Keeley on 7/23/22.
//

import SwiftUI

struct ColorSelector: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject var viewModel = GhostDrawingViewModel()
    
    var body: some View {
        GeometryReader { geo in
            HStack {
                ColorSelectionButton(color: Color.red, lineWidth: 4.0, currentColor: $viewModel.currentColor, currentLineWidth: $viewModel.currentLineWidth)
                ColorSelectionButton(color: Color.blue, lineWidth: 4.0, currentColor: $viewModel.currentColor, currentLineWidth: $viewModel.currentLineWidth)
                ColorSelectionButton(color: Color.green, lineWidth: 4.0, currentColor: $viewModel.currentColor, currentLineWidth: $viewModel.currentLineWidth)
                ColorSelectionButton(color: .clear, lineWidth: 20.0, currentColor: $viewModel.currentColor, currentLineWidth: $viewModel.currentLineWidth)
            }
            .position(x: geo.size.width * 0.53, y: geo.size.width * 0.154)
            .overlay(
                RoundedRectangle(cornerRadius: 40.0)
                    .stroke(.gray, lineWidth: 2.0)
            )
        }
    }
}

struct ColorSelector_Previews: PreviewProvider {
    static var previews: some View {
        ColorSelector()
            .previewLayout(.sizeThatFits)
    }
}
