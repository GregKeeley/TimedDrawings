//
//  TestView.swift
//  GhostDrawings (iOS)
//
//  Created by Gregory Keeley on 7/20/22.
//

import SwiftUI

struct TestView: View {
    @ObservedObject var ghostDrawingVM = GhostDrawingViewModel()
    var body: some View {
        ZStack {
//            DrawingBoardView(ghostDrawingVM: <#T##GhostDrawingViewModel#>, color: <#T##Color#>)
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
