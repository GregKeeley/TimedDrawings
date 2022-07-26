//
//  DrawingViewModel.swift
//  GhostDrawings (iOS)
//
//  Created by Gregory Keeley on 7/20/22.
//

import SwiftUI

/// The view model to store and track properties needed to create, erase and clear drawings. 
class DrawingViewModel: ObservableObject {
    // Current drawing for each color.
    @Published public var currentRedDrawing: Drawing = Drawing(color: .red, lineWidth: 4.0)
    @Published public var currentBlueDrawing: Drawing = Drawing(color: .blue, lineWidth: 4.0)
    @Published public var currentGreenDrawing: Drawing = Drawing(color: .green, lineWidth: 4.0)
    @Published public var currentEraserDrawing: Drawing = Drawing(color: .clear, lineWidth: 20.0)
    /// Stores every drawing, regardless of color.
    @Published public var allDrawings: [Drawing] = [Drawing]()
    /// Stores the current color selected by the user.
    @Published public var currentColor: Color = Color.red
    /// Stores the line width of the line for the drawing.
    @Published public var currentLineWidth: CGFloat = 3.0
    /// Determines if the time delay is on. Set to `true` when you want a time delay on the drawings; `false` for no time delay.
    @Published public var delayIsActive: Bool = true
    /// Determines if the user has ended the drag gesture. When the time delay is enabled, this is needed to know when to start the timers at the end of the drag gesture.
    var touchEventEnded = false
    /// Tracks how many times in a row the clear/eraser button has been tapped. Tapping it 6 times or more in a row will enable the toggle for the delay timer.
    @Published var clearButtonTapsInARow: Int = 0
    /// Determines if the information view is shown. Set to `true` when you want to display the info view.
    @Published var showInfoView = false
    // MARK: - Public Functions
    /// Checks the current color and that the drag gesture has ended and immediately adds the point to the drawing.
    /// Once the points have been added to the drawing, the drawing is added to the main collection.
    /// - Parameter point: The new point to the drawing.
    public func addPointToDrawing(point: CGPoint) {
        switch currentColor {
            case .red:
                self.currentRedDrawing.points.append(point)
                self.allDrawings.append(self.currentRedDrawing)
            case .blue:
                self.currentBlueDrawing.points.append(point)
                self.allDrawings.append(self.currentBlueDrawing)
            case .green:
                self.currentGreenDrawing.points.append(point)
                self.allDrawings.append(self.currentGreenDrawing)
            default:
                currentEraserDrawing.points.append(point)
                self.allDrawings.append(self.currentEraserDrawing)
        }
    }
    /// Checks the current color and that the drag gesture has ended and adds a time delay for each color.  The eraser has no time delay.
    /// Once the points have been added to the drawing, the drawing is added to the main collection.
    /// - Parameter point: The new point to the drawing.
    public func addPointToDrawingWithDelay(point: CGPoint) {
        switch currentColor {
            case .red:
                let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { _ in
                    if self.touchEventEnded {
                        self.currentRedDrawing.points.append(point)
                        self.allDrawings.append(self.currentRedDrawing)
                    }
                }
                RunLoop.current.add(timer, forMode: .common)
            case .blue:
                let timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { _ in
                    if self.touchEventEnded {
                        self.currentBlueDrawing.points.append(point)
                        self.allDrawings.append(self.currentBlueDrawing)
                    }
                }
                RunLoop.current.add(timer, forMode: .common)
            case .green:
                let timer = Timer.scheduledTimer(withTimeInterval:5.0, repeats: false) { _ in
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
