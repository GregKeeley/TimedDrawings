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
                for drawing in ghostDrawingVM.redDrawings {
                    var path = Path()
                    path.addLines(drawing.points)
                    // TODO: Replace lineWidth with ghostDrawingVM.currentLineWidth
                    context.stroke(path, with: .color(Color.red), lineWidth: drawing.lineWidth)
                }
                for drawing in ghostDrawingVM.blueDrawings {
                    var path = Path()
                    path.addLines(drawing.points)
                    // TODO: Replace lineWidth with ghostDrawingVM.currentLineWidth
                    context.stroke(path, with: .color(Color.blue), lineWidth: drawing.lineWidth)
                }
                for drawing in ghostDrawingVM.greenDrawings {
                    var path = Path()
                    path.addLines(drawing.points)
                    // TODO: Replace lineWidth with ghostDrawingVM.currentLineWidth
                    context.stroke(path, with: .color(Color.green), lineWidth: drawing.lineWidth)
                }
                for drawing in ghostDrawingVM.eraserDrawings {
                    var path = Path()
                    path.addLines(drawing.points)
                    // TODO: Replace lineWidth with ghostDrawingVM.currentLineWidth
                    context.stroke(path, with: .color((ghostDrawingVM.colorScheme == .dark ? .white : .black)), lineWidth: 20.0)
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
                                    ghostDrawingVM.redDrawings.append(ghostDrawingVM.currentRedDrawing)
                                }
                            case .blue:
                                DispatchQueue.main.asyncAfter(deadline: .now() + (ghostDrawingVM.timerIsActive ? 3.0 : 0.0)) {
                                    ghostDrawingVM.currentBlueDrawing.points.append(newPoint)
                                    ghostDrawingVM.blueDrawings.append(ghostDrawingVM.currentBlueDrawing)
                                }
                            case .green:
                                DispatchQueue.main.asyncAfter(deadline: .now() + (ghostDrawingVM.timerIsActive ? 5.0 : 0.0)) {
                                    ghostDrawingVM.currentGreenDrawing.points.append(newPoint)
                                    ghostDrawingVM.greenDrawings.append(ghostDrawingVM.currentGreenDrawing)
                                }
                            default:
                                // Eraser, no delay.
                                ghostDrawingVM.currentEraserDrawing.points.append(newPoint)
                                ghostDrawingVM.eraserDrawings.append(ghostDrawingVM.currentEraserDrawing)
                        }
                    })
                    .onEnded({ value in
                        // Drag gesture ended; Add current drawing to collection; Reinitialize the next drawing.
                        switch ghostDrawingVM.currentColor {
                            case .red:
                                ghostDrawingVM.redDrawings.append(ghostDrawingVM.currentRedDrawing)
                                //                                self.drawings.append(currentDrawing)
                                ghostDrawingVM.currentRedDrawing = Drawing(points: [], color: Color.red, lineWidth: 3.0)
                            case .blue:
                                ghostDrawingVM.blueDrawings.append(ghostDrawingVM.currentBlueDrawing)
                                //                                self.drawings.append(currentDrawing)
                                ghostDrawingVM.currentBlueDrawing = Drawing(points: [], color: Color.blue, lineWidth: 3.0)
                            case .green:
                                ghostDrawingVM.greenDrawings.append(ghostDrawingVM.currentGreenDrawing)
                                //                                self.drawings.append(currentDrawing)
                                ghostDrawingVM.currentGreenDrawing = Drawing(points: [], color: Color.green, lineWidth: 3.0)
                            default:
                                // Eraser.
                                ghostDrawingVM.eraserDrawings.append(ghostDrawingVM.currentEraserDrawing)
                                //                                self.drawings.append(currentDrawing)
                                ghostDrawingVM.currentEraserDrawing = Drawing(points: [], color: ghostDrawingVM.colorScheme == .dark ? .white : .black, lineWidth: 20.0)
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
