//
//  InfoView.swift
//  GhostDrawings (iOS)
//
//  Created by Gregory Keeley on 7/26/22.
//

import SwiftUI

struct InfoView: View {
    /// Environment object for tracking the users dark/light mode.
    @Environment(\.colorScheme) var colorScheme
    /// Used to determine when this view should be displayed.
    @Binding var showInfoView: Bool
    /// Top paragraph for the view. Stored here to make the view a little easier to create/edit.
    var instructionsText = """
This app allows you to draw directly on screen with 1 of 3 colors, or you can choose to erase parts of your drawing.

What's hold up though? Each color is delayed by a preset amount of time, until it renders on screen!
"""
    
    var helpHintsText = """
- Red: 1 Second
- Blue: 3 Seconds
- Green: 5 Seconds

Want to clear everything? Shake your phone and you'll get a chance to remove everything from the screen.

Helpful hint: Want to draw, but don't want to wait around all day? Try tapping the "eraser" button 6 times, and you'll see a toggle appear in the top left corner of the screen. Disable this toggle to turn off the time delay!.
"""
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                if showInfoView {
                    colorScheme == .dark ? Color.black.ignoresSafeArea() : Color.white.ignoresSafeArea()
                    VStack {
                        HStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.secondary)
                                .frame(width: geo.size.width * 0.25, height: 5, alignment: .center)
                                .padding(.top)
                        }
                        HStack {
                            Text("How to use this app")
                                .underline(true, color: .secondary)
                                .padding([.leading, .bottom, .trailing])
                                .font(.largeTitle)
                                .font(Font.custom("futura", size: 16).bold())
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                        }
                        HStack {
                            Text(instructionsText)
                                .padding()
                                .font(.subheadline)
                                .font(Font.custom("futura", size: 16))
                            Spacer()
                        }
                        // Color time delay explanation.
                        HStack {
                            Group {
                                Text("Red")
                                    .font(Font.custom("futura", size: 16).bold())
                                    .foregroundColor(.red) +
                                Text(" = 1 Second")
                            }
                            .font(Font.custom("futura", size: 16))
                            .padding()
                            Spacer()
                        }
                        HStack {
                            Group {
                                Text("Blue")
                                    .font(Font.custom("futura", size: 16).bold())
                                    .foregroundColor(.blue) +
                                Text(" = 3 Seconds")
                            }
                            .font(Font.custom("futura", size: 16))
                            .padding()
                            Spacer()
                        }
                        HStack {
                            Group {
                                Text("Green")
                                    .font(Font.custom("futura", size: 16).bold())
                                    .foregroundColor(.green) +
                                Text(" = 5 Seconds")
                            }
                            .font(Font.custom("futura", size: 16))
                            .padding()
                            Spacer()
                        }
                        // Helpful hints.
                        VStack {
                            Text("Helpful Hints")
                                .underline(true, color: .secondary)
                                .font(.title2)
                                .font(Font.custom("futura", size: 24))
                            HStack {
                                Group {
                                    Text("How do I").underline(true, color: .secondary) +
                                    Text(" clear ").foregroundColor(.red).underline(true, color: .secondary) +
                                    Text("everything?").underline(true, color: .secondary)
                                }
                                .font(Font.custom("futura", size: 16))
                                .padding([.leading, .trailing, .top])
                                Spacer()
                            }
                            Group {
                                HStack {
                                    Text("- Shake your phone to").font(.subheadline) +
                                    Text(" clear ")
                                        .foregroundColor(.red) +
                                    Text("the screen").font(.subheadline)
                                    Spacer()
                                }
                                .padding([.leading, .trailing])
                            }
                            .font(Font.custom("futura", size: 16))
                            Group {
                                HStack {
                                    Text("How do I disable the time delay?")
                                        .underline(true, color: .secondary)
                                    Spacer()
                                }
                                .padding([.leading, .trailing, .top])
                            }
                            .font(Font.custom("futura", size: 16))
                            HStack {
                                Text("- Tap on the eraser button 6 times to enable a toggle for the time delay. Once it appears, tap the toggle to turn off the time delay.")
                                    .font(.subheadline)
                                    .font(Font.custom("futura", size: 16))
                                    .padding([.leading, .trailing, .bottom])
                            }
                        }
                        Spacer()
                    }
                } else {
                    EmptyView()
                }
            }
        }
    }
}


// MARK: - Previews
struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(showInfoView: .constant(true))
    }
}
