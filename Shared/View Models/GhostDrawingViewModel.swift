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
    @Published public var currentRedDrawing: Drawing = Drawing()
    @Published public var currentBlueDrawing: Drawing = Drawing()
    @Published public var currentGreenDrawing: Drawing = Drawing()
    @Published public var currentEraserDrawing: Drawing = Drawing()
//    @Published public var currentDrawing: Drawing = Drawing()
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
    
}

struct Drawing {
    var points = [CGPoint]()
    var color: Color = .red
    var lineWidth: Double = 3.0
}

    
