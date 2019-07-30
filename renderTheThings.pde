void renderTheThings() {

  image(MOVIE, 0, 0, width, height); // Scale / render movie frame to screen
  loadPixels(); // refresh pixels[] array
  moviePixels = pixels.clone(); // clone movie pixels for later 
  background(0); // clear / make the screen black
  
  image(MOTION, 0, 0, width, height);
  loadPixels();
  motionPixels = pixels.clone();
  //println("motionPixels:");
  //println(motionPixels);
  background(0);
  
  if(offscreenCanvas.pixels != null) {
    int movementSum = 0; // Amount of movement in the frame
    for (int p = 0; p < renderSpace.length; p++) {
      int i = renderSpace[p];
      color currColor = motionPixels[i];
      color prevColor = previousFrame[i];
      // Extract the red, green, and blue components from current pixel
      int currR = (currColor >> 16) & 0xFF; // Like red(), but faster
      int currG = (currColor >> 8) & 0xFF; // Like green(), but faster
      int currB = currColor & 0xFF; // Like blue(), but faster
      // Extract red, green, and blue components from previous pixel
      int prevR = (prevColor >> 16) & 0xFF;
      int prevG = (prevColor >> 8) & 0xFF;
      int prevB = prevColor & 0xFF;
      
      // Compute the difference of the red, green, and blue values
      int diffR = abs(currR - prevR);
      int diffG = abs(currG - prevG);
      int diffB = abs(currB - prevB);
      
      // Add these differences to the running tally
      movementSum += diffR + diffG + diffB;
      // Render the difference image to the screen
      // The following 2 lines do the same thing, but the second is faster
      // offscreenCanvas.pixels[i] = color(diffR, diffG, diffB);
      offscreenCanvas.pixels[i] = 0x00000000 | (diffR << 16) | (diffG << 8) | diffB;
      // Save the current color into the 'previous' buffer
      previousFrame[i] = currColor;
    }
    // To prevent flicker from frames that are all black (no movement),
    // only update the screen if the image has changed.
    if (movementSum > 0) {
      // Now, for each pixel in the canvas...
      for (int p = 0; p < renderSpace.length; p++) {
        int i = renderSpace[p];
          color currColor = offscreenCanvas.pixels[i];
          int cR = (currColor >> 16) & 0xFF;
          int cG = (currColor >> 8) & 0xFF;
          int cB = currColor & 0xFF;
          int sum = cR + cG + cB;
          // ... if the pixel has relevant color content (i.e. if there's movement)
          if(sum > movementThreshold) {
            // replace it with pixels from the "movie":
            offscreenCanvas.pixels[i] = moviePixels[i];
            // // paint with white noise
            // offscreen.pixels[i] = color(random(255));
          }
      }
      offscreenCanvas.updatePixels();
    }
  } else {
    println("offscreenCanvas.pixels is null: trying again...");
  }
}
