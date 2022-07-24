//
//  DrawingBoardView.swift
//  GhostDrawings (iOS)
//
//  Created by Gregory Keeley on 7/20/22.
//

import SwiftUI

struct DrawingBoardView: View {
    /// The current drawing.
    @State var currentDrawing: Drawing
    /// Array of all drawings to iterate through.
    @State var drawings: [Drawing]
    /// View model to track various properties of the drawing.
    @StateObject var ghostDrawingVM: GhostDrawingViewModel
    
    var body: some View {
        VStack {
            Canvas { context, _ in
                for drawing in drawings {
                    var path = Path()
                    path.addLines(drawing.points)
                    // TODO: Replace lineWidth with ghostDrawingVM.currentLineWidth
                    context.stroke(path, with: .color(drawing.color), lineWidth: currentDrawing.lineWidth)
                }
            }
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged({ value in
                        // Get the CGPoint from the drag gesture location.
                        let newPoint = value.location
                        // Check if the timer is enabled; Delay path from being created, based on the current color.
                        if ghostDrawingVM.timerIsActive {
                            switch ghostDrawingVM.currentColor {
                                case .red:
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                        currentDrawing.color = ghostDrawingVM.currentColor
                                        currentDrawing.points.append(newPoint)
                                        self.drawings.append(currentDrawing)
                                    }
                                case .blue:
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                                        currentDrawing.color = ghostDrawingVM.currentColor
                                        currentDrawing.points.append(newPoint)
                                        self.drawings.append(currentDrawing)
                                    }
                                case .green:
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                                        currentDrawing.color = ghostDrawingVM.currentColor
                                        currentDrawing.points.append(newPoint)
                                        self.drawings.append(currentDrawing)
                                    }
                                default:
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                                        currentDrawing.color = ghostDrawingVM.currentColor
                                        currentDrawing.points.append(newPoint)
                                        self.drawings.append(currentDrawing)
                                    }
                            }
                        } else {
                            // Timer disabled; create path immediately.
                            currentDrawing.color = ghostDrawingVM.currentColor
                            currentDrawing.points.append(newPoint)
                            self.drawings.append(currentDrawing)
                        }
                    })
                    .onEnded({ value in
                        // Drag gesture ended; Add current drawing to collection; Reinitialize the next drawing.
                        self.drawings.append(currentDrawing)
                        self.currentDrawing = Drawing(points: [], color: ghostDrawingVM.currentColor, lineWidth: 3.0)
                    })
            )
        }
    }
    
}



struct DrawingBoardView_Previews: PreviewProvider {
    static let drawing = Drawing(points: [CGPoint](), color: Color.red, lineWidth: 3.0)
    static let vm = GhostDrawingViewModel()
    static var previews: some View {
        DrawingBoardView(currentDrawing: drawing, drawings: [Drawing](), ghostDrawingVM: vm)
    }
}
