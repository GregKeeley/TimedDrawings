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
    @State public var lineWidth: CGFloat
    var deviceSize = UIScreen.main.bounds.size
    @Binding public var currentColor: Color
    @Binding public var currentLineWidth: CGFloat
    var body: some View {
        GeometryReader { geo in
            Button {
                currentColor = color
                currentLineWidth = lineWidth
                print(lineWidth)
            } label: {
                ZStack {
                    if color != .clear {
                        // Outer circle
                        Circle()
                            .stroke(color, lineWidth: 2.0)
                            .frame(width: (geo.size.width * 0.8), height: (geo.size.width * 0.8), alignment: .center)
                            .opacity(currentColor == color ? 0.95 : 0.3)
                        // Inner Circle.
                        Circle()
                            .foregroundColor(color)
                            .frame(width: (geo.size.width * 0.7), height: (geo.size.width * 0.7), alignment: .center)
                            .opacity(currentColor == color ? 0.95 : 0.3)
                    } else {
                        EraserIcon()
                            .foregroundColor(Color.gray)
                            .frame(width: (geo.size.width * 0.8), height: (geo.size.width * 0.8), alignment: .center)
                            .opacity(currentColor == color ? 0.95 : 0.3)
                    }
                }
            }
        }
    }
    
}

struct ColorSelectionButton_Previews: PreviewProvider {
    
    static var previews: some View {
        ColorSelectionButton(color: Color.clear, lineWidth: 3.0, currentColor: .constant(.blue), currentLineWidth: .constant(3.0))
            .previewLayout(.sizeThatFits)
    }
}
