void keyPressed() {
  switch(key) {
  case 'c':
    // enter/leave calibration mode, where surfaces can be warped 
    // and moved
    calibrating = !calibrating;
    ks.toggleCalibration();
    break;
    
  case 'm':
    // show/hide mapping image
    showMappingImage = !showMappingImage;
    break;

  case 'l':
    // loads the saved layout
    ks.load();
    break;

  case 's':
    // saves the layout
    ks.save();
    break;
    
  case CODED:
    if (keyCode == UP) {
      movementThreshold += 2;
    } else if (keyCode == DOWN) {
      if(movementThreshold >= -1) {
        // if movementThreshold is <= -1,
        // only "movie" pixels will be seen
        // (i.e. the Kinect feed will be completely
        // overwritten / invisible)
        movementThreshold -= 2;
      }
    } else if (keyCode == LEFT) {
      // jump to (what is probably)
      // the lowest desireable movementThreshold
      movementThreshold = 10;
    } else if (keyCode == RIGHT) {
      // jump to (what is probably)
      // the lowest desireable movementThreshold
      movementThreshold = 100;
    }
    println("movementThreshold:", movementThreshold);
    break;
  }
}

void movieEvent(Movie m) {
  m.read();  // Read the new frame from the movie
}
