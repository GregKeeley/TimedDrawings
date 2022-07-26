//
//  ColorSelector.swift
//  GhostDrawings (iOS)
//
//  Created by Gregory Keeley on 7/23/22.
//

import SwiftUI

struct ColorSelector: View {
    /// View model used primarily for changing the selected color
    @StateObject var viewModel = DrawingViewModel()
    
    var body: some View {
        GeometryReader { geo in
            HStack {
                ColorSelectionButton(color: .red, currentColor: $viewModel.currentColor, clearButtonTapsInARow: $viewModel.clearButtonTapsInARow)
                ColorSelectionButton(color: .blue, currentColor: $viewModel.currentColor, clearButtonTapsInARow: $viewModel.clearButtonTapsInARow)
                ColorSelectionButton(color: .green, currentColor: $viewModel.currentColor, clearButtonTapsInARow: $viewModel.clearButtonTapsInARow)
                ColorSelectionButton(color: .clear, currentColor: $viewModel.currentColor, clearButtonTapsInARow: $viewModel.clearButtonTapsInARow)
            }
            .position(x: geo.size.width * 0.525, y: geo.size.width * 0.157)
            .overlay(
                RoundedRectangle(cornerRadius: 40.0)
                    .stroke(.secondary, lineWidth: 2.0)
                    .opacity(0.4)
            )
        }
    }
    
}


// MARK: - Previews
struct ColorSelector_Previews: PreviewProvider {
    static var previews: some View {
        ColorSelector()
    }
}
