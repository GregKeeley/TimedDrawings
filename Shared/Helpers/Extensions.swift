//
//  ViewExtension.swift
//  GhostDrawings
//
//  Created by Gregory Keeley on 7/25/22.
//

import SwiftUI

// MARK: - View Extensions
extension View {
    /// Allows for a "reverse mask" to be created and added to a view.
    @inlinable public func reverseMask<Mask: View>(
        alignment: Alignment = .center,
        @ViewBuilder _ mask: () -> Mask) -> some View {
            self.mask {
                Rectangle()
                    .overlay(alignment: alignment) {
                        mask()
                            .blendMode(.destinationOut)
                    }
            }
        }
    /// Defines the modifier to add to a view, which will trigger when a notification is received after shaking the device.
    func onShake(perform action: @escaping () -> Void) -> some View {
        self.modifier(DeviceShakeViewModifier(action: action))
    }
    
}


// MARK: - UIDevice Extension
extension UIDevice {
    /// Notification to trigger on shake.
    static let deviceDidShakeNotification = Notification.Name(rawValue: "deviceDidShakeNotification")
}


// MARK: - UIWindow Extension
extension UIWindow {
    open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            NotificationCenter.default.post(name: UIDevice.deviceDidShakeNotification, object: nil)
        }
    }
    
}
