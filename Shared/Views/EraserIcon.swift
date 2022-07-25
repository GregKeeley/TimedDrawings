//
//  EraserIcon.swift
//  GhostDrawings (iOS)
//
//  Created by Gregory Keeley on 7/25/22.
//

import SwiftUI

struct EraserIcon: View {
    
    var xOffsetMult = -0.2
    var sizeMult = 0.4
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Circle()
                    .reverseMask {
                        Group {
//                            EraserSymbol()
                            VStack {
                                Image(systemName: "rectangle.roundedtop")
                                    .resizable()
                                    .offset(x: 0, y: 15)
                                    .frame(width: geo.size.width / 3, height: geo.size.width / 3, alignment: .center)
                                Image(systemName: "rectangle.portrait.fill")
                                    .resizable()
                                    .frame(width: geo.size.width / 3, height: geo.size.width / 3, alignment: .center)
                            }
                        }
                        .offset(x: -1, y: -7)
                        .rotationEffect(.degrees(-133))
                        
                    }
                    .foregroundColor(.secondary)
            }
        }
    }
    
}

struct EraserIcon_Previews: PreviewProvider {
    static var previews: some View {
        EraserIcon()
            .previewLayout(.sizeThatFits)
    }
}
