//
//  CanvasStack.swift
//  GhostDrawings (iOS)
//
//  Created by Gregory Keeley on 7/24/22.
//

import SwiftUI

struct CanvasStack: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject var ghostDrawingVM = GhostDrawingViewModel()
    /// Array of all drawings to iterate through.
    @State var drawings: [Drawing]
    @State var currentDrawing = Drawing()
    var body: some View {
        ZStack {
            Canvas { context, _ in
                for drawing in drawings {
                    var path = Path()
                    path.addLines(drawing.points)
                    // TODO: Replace lineWidth with ghostDrawingVM.currentLineWidth
                    context.stroke(path, with: .color(drawing.color), lineWidth: currentDrawing.lineWidth)
                }
            }
        }
    }
}

struct CanvasStack_Previews: PreviewProvider {
    static var previews: some View {
        CanvasStack(drawings: [Drawing(color: Color.red)])
    }
}
