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
        HStack {
            ColorSelectionButton(color: Color.red, lineWidth: 3.0, currentColor: $viewModel.currentColor, currentLineWidth: $viewModel.currentLineWidth)
                .padding(.leading)
            ColorSelectionButton(color: Color.blue, lineWidth: 3.0, currentColor: $viewModel.currentColor, currentLineWidth: $viewModel.currentLineWidth)
                .padding(.leading)
            ColorSelectionButton(color: Color.green, lineWidth: 3.0, currentColor: $viewModel.currentColor, currentLineWidth: $viewModel.currentLineWidth)
                .padding([.leading, .trailing])
            colorScheme == .dark ? ColorSelectionButton(color: Color.black, lineWidth: 10.0, currentColor: $viewModel.currentColor, currentLineWidth: $viewModel.currentLineWidth)
                .padding(.trailing) : ColorSelectionButton(color: Color.white, lineWidth: 10.0, currentColor: $viewModel.currentColor, currentLineWidth: $viewModel.currentLineWidth)
                .padding(.trailing)
        }
        
    }
}

struct ColorSelector_Previews: PreviewProvider {
    static var previews: some View {
        ColorSelector()
            .previewLayout(.sizeThatFits)
    }
}
