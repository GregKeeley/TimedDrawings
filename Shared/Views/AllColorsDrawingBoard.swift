//
//  AllColorsDrawingBoard.swift
//  GhostDrawings (iOS)
//
//  Created by Gregory Keeley on 7/21/22.
//

import SwiftUI

struct AllColorsDrawingBoard: View {
    @ObservedObject var ghostDrawingVM = GhostDrawingViewModel()

    var body: some View {
        ZStack {
//            DrawingBoardView(ghostDrawingVM: ghostDrawingVM, color: Color.red)
//            DrawingBoardView(ghostDrawingVM: ghostDrawingVM, color: Color.blue)
        }
    }
}

struct AllColorsDrawingBoard_Previews: PreviewProvider {
    static var previews: some View {
        AllColorsDrawingBoard()
    }
}
