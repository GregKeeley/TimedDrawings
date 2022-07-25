//
//  GhostDrawingViewModel.swift
//  GhostDrawings (iOS)
//
//  Created by Gregory Keeley on 7/20/22.
//

import SwiftUI

/// The view model to store and track properties needed to create, erase and clear drawings. 
class DrawingViewModel: ObservableObject {
    /// Environment object that allows us to check the users color scheme for their device, and make UI changes based on dark or light mode.
    @Environment(\.colorScheme) var colorScheme
    // Current drawing for each color.
    @Published public var currentRedDrawing: Drawing = Drawing(color: .red, lineWidth: 4.0)
    @Published public var currentBlueDrawing: Drawing = Drawing(color: .blue, lineWidth: 4.0)
    @Published public var currentGreenDrawing: Drawing = Drawing(color: .green, lineWidth: 4.0)
    @Published public var currentEraserDrawing: Drawing = Drawing(color: .clear, lineWidth: 20.0)
    /// Stores every drawing, regardless of color.
    @Published public var allDrawings: [Drawing] = [Drawing]()
    /// Stores the current color selected by the user.
    @Published public var currentColor: Color = Color.blue
    /// Stores the line width of the line for the drawing.
    @Published public var currentLineWidth: CGFloat = 3.0
    /// Determines if the time delay is on. Set to `true` when you want a time delay on the drawings; `false` for no time delay.
    @Published public var delayIsActive: Bool = false
    /// Determines if the user has ended the drag gesture. When the time delay is enabled, this is needed to know when to start the timers at the end of the drag gesture.
    var touchEventEnded = false
    
    // MARK: - Public Functions
    /// Checks the current color; Time delay is enabled; Touch events ended, to start adding the points to the respective color drawing.
    /// Once the points have been added to the drawing, add the drawing to the main collection. The eraser has no time delay.
    /// - Parameter point: The new point to the drawing.
    public func addPointToDrawing(point: CGPoint) {
        switch currentColor {
            case .red:
                let timer = Timer.scheduledTimer(withTimeInterval: delayIsActive ? 1.0 : 0.0, repeats: false) { _ in
                    if self.touchEventEnded {
                        self.currentRedDrawing.points.append(point)
                        self.allDrawings.append(self.currentRedDrawing)
                    }
                }
                RunLoop.current.add(timer, forMode: .common)
            case .blue:
                let timer = Timer.scheduledTimer(withTimeInterval: delayIsActive ? 3.0 : 0.0, repeats: false) { _ in
                    if self.touchEventEnded {
                        self.currentBlueDrawing.points.append(point)
                        self.allDrawings.append(self.currentBlueDrawing)
                    }
                }
                RunLoop.current.add(timer, forMode: .common)
            case .green:
                let timer = Timer.scheduledTimer(withTimeInterval: delayIsActive ? 5.0 : 0.0, repeats: false) { _ in
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
    /// Checks the current color to add the respective drawing to the main collection.
    public func addDrawing() {
        switch currentColor {
            case .red:
                let timer = Timer.scheduledTimer(withTimeInterval: delayIsActive ? 5.0 : 0.0, repeats: false) { _ in
                    self.allDrawings.append(self.currentRedDrawing)
                }
                RunLoop.current.add(timer, forMode: .common)
            case .blue:
                let timer = Timer.scheduledTimer(withTimeInterval: delayIsActive ? 5.0 : 0.0, repeats: false) { _ in
                    self.allDrawings.append(self.currentBlueDrawing)
                }
                RunLoop.current.add(timer, forMode: .common)
            case .green:
                let timer = Timer.scheduledTimer(withTimeInterval: delayIsActive ? 5.0 : 0.0, repeats: false) { _ in
                    self.allDrawings.append(self.currentGreenDrawing)
                }
                RunLoop.current.add(timer, forMode: .common)
            default:
                self.allDrawings.append(self.currentEraserDrawing)
        }
    }
    /// Reinitializes a single drawing dependent on the current color. This is used at the of the drag gesture to make the next drawing ready to add to.
    public func resetCurrentDrawing() {
        switch currentColor {
            case .red:
                currentRedDrawing = Drawing(color: .red, lineWidth: 4.0)
            case .blue:
                currentBlueDrawing = Drawing(color: .blue, lineWidth: 4.0)
            case .green:
                currentGreenDrawing = Drawing(color: .green, lineWidth: 4.0)
            default:
                currentEraserDrawing = Drawing(color: .clear, lineWidth: 20.0)
        }
    }
    /// Clears all drawings, as well as individual drawings for each color, to create a blank canvas.
    public func clearAllDrawings() {
        allDrawings = [Drawing]()
        currentEraserDrawing = Drawing(color: .clear, lineWidth: 20.0)
        currentRedDrawing = Drawing(color: .red, lineWidth: 4.0)
        currentBlueDrawing = Drawing(color: .blue, lineWidth: 4.0)
        currentGreenDrawing = Drawing(color: .green, lineWidth: 4.0)
    }
    
}
