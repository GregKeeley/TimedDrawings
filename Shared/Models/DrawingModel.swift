//
//  DrawingModel.swift
//  GhostDrawings (iOS)
//
//  Created by Gregory Keeley on 7/25/22.
//

import Foundation
import SwiftUI

struct Drawing {
    /// Collection of `CGPoint` used to track the path(s) for each drawing.
    var points = [CGPoint]()
    /// Main color of the stroke for the drawing.
    var color: Color
    /// The width of the stroke for the drawing.
    var lineWidth: Double
    
}
