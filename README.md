# GhostDrawings

![GhostDrawingAppIcon-small](https://user-images.githubusercontent.com/55718158/181075930-3a4299a3-0103-4133-bd6e-05d09ab8c7b7.png)
---

This iOS application allows you to draw on screen with 1 of 3 colors, or an eraser to remove parts of the drawing. 
What makes it a "Ghost Drawing" exactly? Well, it may appear as though the app doesn't work for the first 1 to 5 seconds after you have made your first drawing.
That's where the ghostly nature of this app comes in, as each colors drawing is delayed by a few seconds before they appear on screen. 

After selecting a color, and you begin to draw you'll notice the delay. The red color is delayed by one second, the blue color is 
delayed by 3 seconds, and the green color is delayed by 5 seconds. Keep in mind, the timer doesn't begin until after you've completed your drawing. Feel free to erase
anytime with the eraser tool, which has no delay. 

## Features
* Draw with 3 Colors: Red, Blue, or Green.
* Erase part of the drawing.
* Delay appearance of the drawing. 
* Shake to clear.
## Secret Features
* Tap the eraser button 6 times to enable a toggle for the time delay. 

## Challenges
  One of the main challenges for this application was the time delay. Getting a drawing to appear on screen with a drag gesture was relatively. 
Delaying that drawing from rendering was also relatively easy. However, during development, I wanted a way to see how my code was reacting to changes,
without a delay. The issue I faced was this: Run the app, find a buggy behavior, go back into code, make changes and run the app again. But waiting 1-5 seconds
for each drawing to appear on screen meant wasted time and sometime false positives when nothing would appear!

  To start tackling this problem I created a toggle and assigned that to a variable on the view model to toggle the timer on and off. Great, now I have a way to quickly
test my code for the drawings, without a delay. But if I wanted to continue developing in this way, I had to account for both immediate rendering of drawings as well as 
delayed rendering of those drawings. That's when the issues started to compound. 

  Turning this debug feature I created into a legitimate feature presented a challenge because of how the drawings are created. Many checks were needed to ensure 
the timer worked as intended, while also allowing for immediate drawing when the delay was disabled. The solution started with a separation of responsibilities. 
I began by moving some of the logic from the view, to the view model. This cleaned up the view which was great. Addtionally, this also meant variables like 
```currentColor``` were available to these methods without the use of property observers beyond reason. 

The major bug that existed around all of this, was extra segments being added to drawings, and rendered on screen. It didn't look good, and it didn't feel good. 
That eventually led to a really simple soution with the drag gesture sending it's own updates on the view model, rather than the gesture outright. The following code shows
a litte bit of what this solution looks like on the Drag gesture.
```swift 
            .gesture(
                DragGesture(minimumDistance: 0, coordinateSpace: .local)
                    .onChanged({ value in
                        if ghostDrawingVM.delayIsActive {
                            // Delay is active; Don't start adding to the drawing until the gesture has ended.
                            ghostDrawingVM.beginAddingToDrawing = false
                        } else {
                            // Delay is inactive; Drawing can start right away.
                            ghostDrawingVM.beginAddingToDrawing = true
                        }
                        // Get the CGPoint from the drag gesture location.
                        let newPoint = value.location
                        // Check if the timer is enabled; Delay path from being created, based on the current color.
                        if ghostDrawingVM.delayIsActive {
                            // Delay is active; Use the delayed drawing method.
                            ghostDrawingVM.addPointToDrawingWithDelay(point: newPoint)
                        } else {
                            // Delay is inactive; add to the drawing immediately.
                            ghostDrawingVM.addPointToDrawing(point: newPoint)
                        }
                    })
                    .onEnded({ value in
                        // Drag gesture ended; Add current drawing to collection; Reinitialize the next drawing.
                        ghostDrawingVM.beginAddingToDrawing = true
                        ghostDrawingVM.addDrawing()
                        ghostDrawingVM.resetCurrentDrawing()
                    })
            )
```

## Known Bugs
- When the time delay is enabled, the timer starts counting down right away, and will immediately add the drawing once the drag gesture has ended. 
- You can interrupt a delayed drawing by changing the current color. The original drawing that didn't get rendered, will be lost.

