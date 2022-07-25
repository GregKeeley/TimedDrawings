//
//  Modifiers.swift
//  GhostDrawings
//
//  Created by Gregory Keeley on 7/25/22.
//

import SwiftUI

/// A view modifier that allows us to monitor for shake events throughout the app.
struct DeviceShakeViewModifier: ViewModifier {
    /// The code to be executed after a shake of the device is registered.
    let action: () -> Void
    // Once the shake notification is received, this will trigger the action.
    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.deviceDidShakeNotification)) { _ in
                action()
            }
    }
}
