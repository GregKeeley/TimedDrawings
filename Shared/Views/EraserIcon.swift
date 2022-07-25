//
//  EraserIcon.swift
//  GhostDrawings (iOS)
//
//  Created by Gregory Keeley on 7/25/22.
//

import SwiftUI

struct EraserIcon: View {
    var foreGroundColor: Color = .gray
    var xOffsetMult = -0.2
    var sizeMult = 0.4
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Circle()
                    .reverseMask {
                        Group {
                            Image(systemName: "rectangle.roundedtop")
                                .resizable()
                                .offset(x: geo.size.width * xOffsetMult, y: 5.5)
                                .frame(width: geo.size.height * sizeMult, height: geo.size.height * sizeMult, alignment: .center)
                                .foregroundColor(Color.pink)
                            Image(systemName: "rectangle.portrait.fill")
                                .resizable()
                                .offset(x: geo.size.width * xOffsetMult, y: geo.size.height * 0.37)
                                .frame(width: geo.size.height * sizeMult, height: geo.size.height * sizeMult, alignment: .center)
                        }
                        .offset(x: 13, y: -17)
                        .rotationEffect(.degrees(-133))
                    }
                    .foregroundColor(foreGroundColor)
                    .symbolRenderingMode(.multicolor)
            }
        }
    }
}

struct EraserIcon_Previews: PreviewProvider {
    static var previews: some View {
        EraserIcon()
            .frame(width: 40, height: 40, alignment: .center)
    }
}
