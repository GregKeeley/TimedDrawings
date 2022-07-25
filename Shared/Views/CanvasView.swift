//
//  CanvasView.swift
//  GhostDrawings (iOS)
//
//  Created by Gregory Keeley on 7/20/22.
//

import SwiftUI

struct CanvasView: View {
    /// View model to track various properties of the drawing.
    @ObservedObject var ghostDrawingVM: DrawingViewModel
    
    var body: some View {
        VStack {
            Canvas { context, _ in
                for drawing in ghostDrawingVM.allDrawings {
                    var path = Path()
                    path.addLines(drawing.points)
                    if drawing.color == .clear {
                        context.blendMode = .clear
                        context.stroke(path, with: .color(.clear), lineWidth: drawing.lineWidth)
                    } else {
                        context.blendMode = .normal
                        context.stroke(path, with: .color(drawing.color), lineWidth: drawing.lineWidth)
                    }
                }
            }
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged({ value in
                        if ghostDrawingVM.delayIsActive {
                            ghostDrawingVM.touchEventEnded = false
                        } else {
                            ghostDrawingVM.touchEventEnded = true
                        }
                        // Get the CGPoint from the drag gesture location.
                        let newPoint = value.location
                        // Check if the timer is enabled; Delay path from being created, based on the current color.
                        ghostDrawingVM.addPointToDrawing(point: newPoint)
                    })
                    .onEnded({ value in
                        // Drag gesture ended; Add current drawing to collection; Reinitialize the next drawing.
                        ghostDrawingVM.touchEventEnded = true
                        ghostDrawingVM.addDrawing()
                        ghostDrawingVM.resetCurrentDrawing()
                    })
            )
        }
    }
    
}
