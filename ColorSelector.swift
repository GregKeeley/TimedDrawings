//
//  ColorSelector.swift
//  GhostDrawings (iOS)
//
//  Created by Gregory Keeley on 7/23/22.
//

import SwiftUI

struct ColorSelector: View {
    
    @StateObject var viewModel = GhostDrawingViewModel()
    
    var body: some View {
        HStack {
            ColorSelectionButton(color: Color.red, currentColor: $viewModel.currentColor)
                .padding(.leading)
            ColorSelectionButton(color: Color.blue, currentColor: $viewModel.currentColor)
                .padding(.leading)
            ColorSelectionButton(color: Color.green, currentColor: $viewModel.currentColor)
                .padding([.leading, .trailing])
            ColorSelectionButton(color: Color.clear, currentColor: $viewModel.currentColor)
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
