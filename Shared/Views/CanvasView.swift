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
        ZStack {
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
                DragGesture(minimumDistance: 0, coordinateSpace: .local)
                    .onChanged({ value in
                        if ghostDrawingVM.delayIsActive {
                            // Delay is active; Don't start adding to the drawing until the gesture has ended.
                            ghostDrawingVM.beginAddingToDrawing = false
                        } else {
                            // Delay is inactive; Drawing can start right away.
                            ghostDrawingVM.beginAddingToDrawing = true
                        }
                        // Get the CGPoint from the drag gesture location.
                        let newPoint = value.location
                        // Check if the timer is enabled; Delay path from being created, based on the current color.
                        if ghostDrawingVM.delayIsActive {
                            // Delay is active; Use the delayed drawing method.
                            ghostDrawingVM.addPointToDrawingWithDelay(point: newPoint)
                        } else {
                            // Delay is inactive; add to the drawing immediately.
                            ghostDrawingVM.addPointToDrawing(point: newPoint)
                        }
                    })
                    .onEnded({ value in
                        // Drag gesture ended; Add current drawing to collection; Reinitialize the next drawing.
                        ghostDrawingVM.beginAddingToDrawing = true
                        ghostDrawingVM.addDrawing()
                        ghostDrawingVM.resetCurrentDrawing()
                    })
            )
        }
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.gray, lineWidth: 3.0)
                .opacity(0.4))
    }
    
}
