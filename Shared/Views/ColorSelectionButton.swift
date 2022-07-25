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
            Button {
                currentColor = color
                currentLineWidth = lineWidth
                print(lineWidth)
            } label: {
                ZStack {
                    if color != .clear {
                        Circle()
                            .stroke(color, lineWidth: 2.0)
                            .frame(width: (deviceSize.width * 0.2), height: (deviceSize.width * 0.2), alignment: .center)
                        Circle()
                            .foregroundColor(color)
                            .frame(width: (deviceSize.width * 0.165), height: (deviceSize.width  * 0.165), alignment: .center)
                    } else {
                        Image(systemName: "trash.circle")
                            .resizable()
                            .foregroundColor(Color.gray)
                            .frame(width: (deviceSize.width * 0.2), height: (deviceSize.width  * 0.2), alignment: .center)
                    }
                }
                
            }
    }
    
}

struct ColorSelectionButton_Previews: PreviewProvider {
    
    static var previews: some View {
        ColorSelectionButton(color: Color.red, lineWidth: 3.0, currentColor: .constant(Color.blue), currentLineWidth: .constant(3.0))
            .previewLayout(.sizeThatFits)
    }
}
