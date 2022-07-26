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
    var instructionsText = """
This app allows you to draw directly on screen with  1 of 3 colors, or you can choose to erase parts of your drawing.

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
        ZStack {
            colorScheme == .dark ? Color.black.ignoresSafeArea() : Color.white.ignoresSafeArea()
            VStack {
                HStack {
                    Text("How to use this app")
                        .underline()
                        .padding()
                        .font(.largeTitle)
                        .font(Font.custom("futura", size: 16).bold())
                        .foregroundColor(colorScheme == .dark ? .white : .black)
//                    Spacer()
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
                        .underline()
                        .font(.title2)
                        .font(Font.custom("futura", size: 24))
                    HStack {
                        Group {
                            Text("How do I").underline() +
                            Text(" clear ").foregroundColor(.red).underline(true, color: .black) +
                            Text("everything?").underline()
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
                                .underline()
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
            }
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
