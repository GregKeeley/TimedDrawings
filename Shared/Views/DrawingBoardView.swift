//
//  DrawingBoardView.swift
//  GhostDrawings (iOS)
//
//  Created by Gregory Keeley on 7/20/22.
//

import SwiftUI

struct DrawingBoardView: View {
    
    /// View model to track various properties of the drawing.
    @StateObject var ghostDrawingVM: GhostDrawingViewModel
    
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
                        // Get the CGPoint from the drag gesture location.
                        let newPoint = value.location
                        // Check if the timer is enabled; Delay path from being created, based on the current color.
                        switch ghostDrawingVM.currentColor {
                            case .red:
                                DispatchQueue.main.asyncAfter(deadline: .now() + (ghostDrawingVM.timerIsActive ? 1.0 : 0.0)) {
                                    ghostDrawingVM.currentRedDrawing.points.append(newPoint)
                                    ghostDrawingVM.allDrawings.append(ghostDrawingVM.currentDrawing)
                                }
                            case .blue:
                                DispatchQueue.main.asyncAfter(deadline: .now() + (ghostDrawingVM.timerIsActive ? 3.0 : 0.0)) {
                                    ghostDrawingVM.currentBlueDrawing.points.append(newPoint)
                                    ghostDrawingVM.allDrawings.append(ghostDrawingVM.currentDrawing)
                                }
                            case .green:
                                DispatchQueue.main.asyncAfter(deadline: .now() + (ghostDrawingVM.timerIsActive ? 5.0 : 0.0)) {
                                    ghostDrawingVM.currentGreenDrawing.points.append(newPoint)
                                    ghostDrawingVM.allDrawings.append(ghostDrawingVM.currentGreenDrawing)
                                }
                            default:
                                // Eraser, no delay.
                                ghostDrawingVM.currentEraserDrawing.points.append(newPoint)
                                ghostDrawingVM.allDrawings.append(ghostDrawingVM.currentEraserDrawing)
                        }
                        
                    })
                    .onEnded({ value in
                        // Drag gesture ended; Add current drawing to collection; Reinitialize the next drawing.
                        switch ghostDrawingVM.currentColor {
                            case .red:
                                ghostDrawingVM.allDrawings.append(ghostDrawingVM.currentRedDrawing)
                                ghostDrawingVM.currentRedDrawing = Drawing(points: [], color: Color.red, lineWidth: 3.0)
                            case .blue:
                                ghostDrawingVM.allDrawings.append(ghostDrawingVM.currentBlueDrawing)
                                ghostDrawingVM.currentBlueDrawing = Drawing(points: [], color: Color.blue, lineWidth: 3.0)
                            case .green:
                                ghostDrawingVM.allDrawings.append(ghostDrawingVM.currentGreenDrawing)
                                ghostDrawingVM.currentGreenDrawing = Drawing(points: [], color: Color.green, lineWidth: 3.0)
                            default:
                                // Eraser.
                                ghostDrawingVM.allDrawings.append(ghostDrawingVM.currentEraserDrawing)
                                ghostDrawingVM.currentEraserDrawing = Drawing(points: [], color: Color.clear, lineWidth: 20.0)
                        }
                    })
            )
        }
    }
    
}



//struct DrawingBoardView_Previews: PreviewProvider {
//    static let drawing = Drawing(points: [CGPoint](), color: Color.red, lineWidth: 3.0)
//    static let vm = GhostDrawingViewModel()
//    static var previews: some View {
//        DrawingBoardView(currentDrawing: drawing, drawings: [Drawing](), ghostDrawingVM: vm)
//    }
//}
