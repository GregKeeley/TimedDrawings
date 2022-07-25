//
//  ColorSelectionButton.swift
//  GhostDrawings (iOS)
//
//  Created by Gregory Keeley on 7/20/22.
//

import SwiftUI

struct ColorSelectionButton: View {
    /// Sets the color the view; Use this to set the current color.
    @State public var color: Color
    /// Used to set the current color on the view model.
    @Binding public var currentColor: Color
    /// Opacity value for when a buttons color is currently selected as input.
    let selectedOpacity = 0.95
    /// The default opacity for a buttons color; Used when that color has not been selected.
    let defaultOpacity = 0.4
    
    var body: some View {
        GeometryReader { geo in
            Button {
                currentColor = color
            } label: {
                ZStack {
                    if color != .clear {
                        // Regular color button.
                        // Outer circle
                        Circle()
                            .stroke(color, lineWidth: 3.0)
                            .frame(width: (geo.size.width * 0.8), height: (geo.size.width * 0.8), alignment: .center)
                            .opacity(currentColor == color ? selectedOpacity : defaultOpacity)
                        // Inner Circle.
                        Circle()
                            .foregroundColor(color)
                            .frame(width: (geo.size.width * 0.7), height: (geo.size.width * 0.7), alignment: .center)
                            .opacity(currentColor == color ? selectedOpacity : defaultOpacity)
                    } else {
                        // Eraser icon button.
                        Circle()
                            .stroke(.gray, lineWidth: 3.0)
                            .frame(width: (geo.size.width * 0.8), height: (geo.size.width * 0.8), alignment: .center)
                            .opacity(currentColor == color ? selectedOpacity : defaultOpacity)
                        EraserIcon()
                            .foregroundColor(.gray)
                            .frame(width: (geo.size.width * 0.7), height: (geo.size.width * 0.7), alignment: .center)
                            .opacity(currentColor == color ? selectedOpacity : defaultOpacity)
                    }
                }
            }
        }
    }
    
}


// MARK: - Previews
struct ColorSelectionButton_Previews: PreviewProvider {
    static var previews: some View {
        ColorSelectionButton(color: Color.red, currentColor: .constant(.red))
            .previewLayout(.sizeThatFits)
    }
}
