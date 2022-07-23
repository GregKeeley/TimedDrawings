//
//  DrawingBoardView.swift
//  GhostDrawings (iOS)
//
//  Created by Gregory Keeley on 7/20/22.
//

import SwiftUI

struct DrawingBoardView: View {
    
    //    var color: Color = Color.red
    @State var currentDrawing: Drawing
    @State var drawings: [Drawing]
    //    @Binding var currentColor: Color
    var timers: [Double] = [1.0, 3.0, 5.0]
    
    @StateObject var ghostDrawingVM: GhostDrawingViewModel
    
    var body: some View {
        VStack {
            Canvas { context, size in
                for drawing in drawings {
                    var path = Path()
                    path.addLines(drawing.points)
                    context.stroke(path, with: .color(drawing.color), lineWidth: currentDrawing.lineWidth)
                }
            }
            .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                .onChanged({ value in
                    let newPoint = value.location
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
                                break
                        }
                    } else {
                        currentDrawing.color = ghostDrawingVM.currentColor
                        currentDrawing.points.append(newPoint)
                        self.drawings.append(currentDrawing)
                    }
                })
                    .onEnded({ value in
                        self.drawings.append(currentDrawing)
                        self.currentDrawing = Drawing(points: [], color: ghostDrawingVM.currentColor, lineWidth: 3.0)
                    })
            )
        }
    }
}


//struct DrawingBoardView_Previews: PreviewProvider {
//    static var previews: some View {
//        DrawingBoardView()
//    }
//}
