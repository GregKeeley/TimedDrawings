//
//  ViewExtension.swift
//  GhostDrawings
//
//  Created by Gregory Keeley on 7/25/22.
//

import SwiftUI

extension View {
    /// Allows for a reverse mask to created and added to a view.
    @inlinable public func reverseMask<Mask: View>(
        alignment: Alignment = .center,
        @ViewBuilder _ mask: () -> Mask
    ) -> some View {
        self.mask {
            Rectangle()
                .overlay(alignment: alignment) {
                    mask()
                        .blendMode(.destinationOut)
                }
        }
    }
}
