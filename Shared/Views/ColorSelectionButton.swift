//
//  ColorSelectionButton.swift
//  GhostDrawings (iOS)
//
//  Created by Gregory Keeley on 7/20/22.
//

import SwiftUI

struct ColorSelectionButton: View {
    
    @State public var color: Color
    @State public var deviceSize: CGSize = UIScreen.main.bounds.size
    @Binding public var currentColor: Color
    
    var body: some View {
        Button {
            currentColor = color
        } label: {
            ZStack {
                Circle()
                    .stroke(color, lineWidth: 4.0)
                    .frame(width: (deviceSize.width * 0.2), height: (deviceSize.width  * 0.2), alignment: .center)
                Circle()
                    .foregroundColor(color)
                    .frame(width: (deviceSize.width * 0.165), height: (deviceSize.width  * 0.165), alignment: .center)
                Circle()
                    .foregroundColor(Color.clear)
                    .frame(width: (deviceSize.width * 0.2), height: (deviceSize.width  * 0.2), alignment: .center)
            }
        }
    }
    
}

struct ColorSelectionButton_Previews: PreviewProvider {
    
    static var previews: some View {
        ColorSelectionButton(color: Color.red, currentColor: .constant(Color.blue))
            .previewLayout(.sizeThatFits)
    }
}
