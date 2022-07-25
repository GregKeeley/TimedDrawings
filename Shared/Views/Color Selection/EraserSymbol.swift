//
//  EraserSymbol.swift
//  GhostDrawings (iOS)
//
//  Created by Gregory Keeley on 7/25/22.
//

import SwiftUI

struct EraserSymbol: View {
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Circle()
                    .reverseMask {
                        Group {
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


// MARK: - Previews
struct EraserIcon_Previews: PreviewProvider {
    static var previews: some View {
        EraserSymbol()
            .previewLayout(.sizeThatFits)
    }
}
