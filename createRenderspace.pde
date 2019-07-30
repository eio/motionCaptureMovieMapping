// CreateRenderspace() returns an array of integers, each of which references
// the index of a non-black pixel in the provided image.
int[] CreateRenderspace(PImage img) {
  int black = -16777216;
  // int white = -1;
  int[] keystonePixels;
   image(img, 0, 0, width, height); // Render mapping image to screen
   loadPixels(); // Make the pixels[] array available
  // Store non-black pixel indices in *dynamic* ArrayList
  // because we don't know how big it will be until we build it
  ArrayList<Integer> nonBlackPixels = new ArrayList<Integer>();
  for(int i=0; i<numPixels; i++) {
    if( pixels[i] != black) {
    //if(pixels[i] == white) {
      nonBlackPixels.add(i);
    }
  }
  // This last chunk is an optimization.
  // We transfer all non-black pixel indices from the ArrayList
  // to a *static* array for better performance inside of the draw() loop
  int nbp = nonBlackPixels.size(); // First count the number of nonBlackPixels
  // Then build the array of integers where "nbp" is the length of the array
  keystonePixels = new int[nbp];
  // Transfer values from the ArrayList to the array
  for(int i=0; i<nbp; i++) {
    keystonePixels[i] = nonBlackPixels.get(i);
  }
  // Return the array of integers
  return keystonePixels;
}