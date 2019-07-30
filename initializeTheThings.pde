void initializeTheThings() {
  ks = new Keystone(this);
  surface = ks.createCornerPinSurface(width, height, 20);
  // // create a buffer to store the scene we want to render
  // // on the projection mapped surface
  offscreenCanvas = createGraphics(width, height, P2D);
  // // ^ this can be 2D or 3D renderer, but we use 2D
  // // because it seems to be more performant
  
  // // the mapping image' aspect ratio
  // // must be the same as the display window
  mappingImg = loadImage("image.jpg");
  // // Load the movie to replace "pixels in motion" with
  MOVIE = new Movie(this, "movie.mov");
  // // Load the movie to generate the "pixels in motion"
  // // which will be replaced with pixels from the `movie` video
  MOTION = new Movie(this, "motion.mov");
  
  offscreenCanvas.loadPixels();
  
  //if (offscreenCanvas.pixels == null) {
  //  println("Something ate our offscreenCanvas.");
  //}
  
  // // total number of pixels in the scene
  numPixels = width * height;
  // // Create an array to store the previously captured frame
  previousFrame = new int[numPixels];
  
  // // Limit our renderspace to non-black pixels
  // // in the original mappingImg:
  renderSpace = CreateRenderspace(mappingImg);

  // ...or uncomment the following
  // to just render everywhere:
  //renderSpace = new int[numPixels];
  //for(int i=0; i<numPixels; i++) {
  //  renderSpace[i] = i;
  //}
  
  // start looping the movies
  println("Looping movie.mov");
  MOVIE.loop();
  // init the "motion" vid right away
  println("Looping motion.mov");
  MOTION.loop();
}
