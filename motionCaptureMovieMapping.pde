/**
 * AUTHOR: wobkat
 * DESCRIPTION:
 * - loads image to limit rendering area
 * - enables calibration of rendering area for keystoning on physical objects
 * - tracks motion from movie file input via a simple frame differencing algorithm
 * - replaces frame-differenced pixels with pixels from a 2nd looping movie file
 
 * GENERAL CONTROLS:
[[[ NOTE: rendering is upside-down by default; using the 'l' key is your friend ]]]
 * - Command + Shift + 'r' key: run in Presentation Mode
 * - 'c' key: toggle Calibration Mode to finetune projection mapping / keystone on physical object
       - NOTE: this can be used to manually flip the rendering's vertical/horizontal orientation
 * - 'm' key: (while in Calibration Mode) toggle display of Projection Mapping file: "image.jpg"
 * - 's' key: save the current Calibration to a file for future use
 * - 'l' key: load the saved Calibration file

 * TUNING CONTROLS:
[[[ NOTE: movementThreshold defaults to 20 when program starts ]]]
 * - UP arrow key: increase current movementThreshold value by 2
 * - DOWN arrow key: decrease current movementThreshold value by 2
        - NOTE: movementThresholds less than 0 will result in only "movie" pixels displaying,
                (meaning that the Kinect feed will be completely overwritten / invisible)
 * - LEFT arrow key: set movementThreshold to 10
       - NOTE: movementThresholds between 0 and ~20 may display outlines of stationary objects if they are close enough to Kinect
 * - RIGHT arrow key: set movementThreshold to 100
       - NOTE: higher movementThresholds greatly reduce the Kinect sensor's range (i.e. "distant" objects will disappear)
*/

//import org.openkinect.freenect.*;
//import org.openkinect.freenect2.*;
//import org.openkinect.processing.*;
import deadpixel.keystone.*;
import processing.video.*;
boolean calibrating = false;
boolean showMappingImage = false;
int movementThreshold = 20;
Keystone ks;
CornerPinSurface surface;
PGraphics offscreenCanvas;
PImage mappingImg;
int[] renderSpace;
Movie MOTION;
int[] motionPixels;
//Kinect2 kinect2;
//int[] kinectPixels;
Movie MOVIE;
int[] moviePixels;
int numPixels;
int[] previousFrame;

void setup() {
  // // fullscreen
  size(1440, 900, P3D);
  
   // set a smaller display window
   // for testing or if performance
   // becomes an issue (same aspect ratio!)
   //size(800, 600, P3D);
  
  initializeTheThings();
}

void draw() {

  if(calibrating) {
    // IN CALIBRATION MODE
    // turn on the mouse
    cursor();
    
    if(showMappingImage) {
      // in Calibration Mode, we can make
      // the whole renderspace white 
      // to help with projection mapping
      background(0);
      for (int p = 0; p < renderSpace.length; p++) {
        int i = renderSpace[p];
        if (offscreenCanvas.pixels != null) {
           offscreenCanvas.pixels[i] = color(255);
        }
      }        
      offscreenCanvas.updatePixels();
    } else {
      // keep rendering while in calibration mode
      renderTheThings();
    }
  } else {
    // NOT IN CALIBRATION MODE
    // turn off the mouse
    noCursor();
    // render all the things into `offscreenCanvas`
    renderTheThings();
  }
  
  // render the scene, transformed using the corner pin surface
  surface.render(offscreenCanvas);
}
