//
//  GhostDrawingViewModel.swift
//  GhostDrawings (iOS)
//
//  Created by Gregory Keeley on 7/20/22.
//

import SwiftUI

class GhostDrawingViewModel: ObservableObject {
    @Environment(\.colorScheme) var colorScheme
    // Current drawing for each color.
    @Published public var currentRedDrawing: Drawing = Drawing(color: .red, lineWidth: 4.0)
    @Published public var currentBlueDrawing: Drawing = Drawing(color: .blue, lineWidth: 4.0)
    @Published public var currentGreenDrawing: Drawing = Drawing(color: .green, lineWidth: 4.0)
    @Published public var currentEraserDrawing: Drawing = Drawing(color: .clear, lineWidth: 20.0)
    // Collection of drawings for each color.
    @Published public var redDrawings: [Drawing] = [Drawing]()
    @Published public var blueDrawings: [Drawing] = [Drawing]()
    @Published public var greenDrawings: [Drawing] = [Drawing]()
    @Published public var eraserDrawings: [Drawing] = [Drawing]()
    
    
    @Published public var allDrawings: [Drawing] = [Drawing]()
    @Published public var currentColor: Color = Color.blue
    
    @Published public var currentLineWidth: CGFloat = 3.0
    // TODO: Re-enable the timer  by default.
    @Published public var timerIsActive: Bool = false
    /// Adds the points to the Drawing and Path. Path is mutated in place.
    public func addPathToDrawing(drawing: Drawing, path: inout Path) {
        let points = drawing.points
        if points.count > 1 {
            for i in 0..<points.count-1 {
                let current = points[i]
                let next = points[i+1]
                path.move(to: current)
                path.addLine(to: next)
            }
        }
    }
    



    var touchEventEnded = false
    public func addPointToDrawing(point: CGPoint) {
        switch currentColor {
            case .red:
                let timer = Timer.scheduledTimer(withTimeInterval: timerIsActive ? 1.0 : 0.0, repeats: false) { _ in
                    if self.touchEventEnded {
                        self.currentRedDrawing.points.append(point)
                        self.allDrawings.append(self.currentRedDrawing)
                    }
                }
                RunLoop.current.add(timer, forMode: .common)
            case .blue:
                let timer = Timer.scheduledTimer(withTimeInterval: timerIsActive ? 3.0 : 0.0, repeats: false) { _ in
                    if self.touchEventEnded {
                        self.currentBlueDrawing.points.append(point)
                        self.allDrawings.append(self.currentBlueDrawing)
                    }
                }
                RunLoop.current.add(timer, forMode: .common)
            case .green:
                let timer = Timer.scheduledTimer(withTimeInterval: timerIsActive ? 5.0 : 0.0, repeats: false) { _ in
                    if self.touchEventEnded {
                        self.currentGreenDrawing.points.append(point)
                        self.allDrawings.append(self.currentGreenDrawing)
                    }
                }
                RunLoop.current.add(timer, forMode: .common)
            default:
                currentEraserDrawing.points.append(point)
                self.allDrawings.append(self.currentEraserDrawing)
        }
    }
    
    public func addDrawing() {
        switch currentColor {
            case .red:
                let timer = Timer.scheduledTimer(withTimeInterval: timerIsActive ? 5.0 : 0.0, repeats: false) { _ in
                    self.allDrawings.append(self.currentRedDrawing)
                }
                RunLoop.current.add(timer, forMode: .common)
            case .blue:
                let timer = Timer.scheduledTimer(withTimeInterval: timerIsActive ? 5.0 : 0.0, repeats: false) { _ in
                    self.allDrawings.append(self.currentBlueDrawing)
                }
                RunLoop.current.add(timer, forMode: .common)
            case .green:
                let timer = Timer.scheduledTimer(withTimeInterval: timerIsActive ? 5.0 : 0.0, repeats: false) { _ in
                    self.allDrawings.append(self.currentGreenDrawing)
                }
                RunLoop.current.add(timer, forMode: .common)
            default:
                self.allDrawings.append(self.currentEraserDrawing)
        }
    }
    
    public func resetDrawing() {
        switch currentColor {
            case .red:
                currentRedDrawing = Drawing(points: [],
                                            color: .red,
                                            lineWidth: 4.0)
            case .blue:
                currentBlueDrawing = Drawing(points: [],
                                             color: .blue,
                                             lineWidth: 4.0)
            case .green:
                currentGreenDrawing = Drawing(points: [],
                                              color: .green,
                                              lineWidth: 4.0)
            default:
                currentEraserDrawing = Drawing(points: [],
                                               color: .clear,
                                               lineWidth: 20.0)
        }
    }
    
}

struct Drawing {
    var points = [CGPoint]()
    var color: Color
    var lineWidth: Double
}


