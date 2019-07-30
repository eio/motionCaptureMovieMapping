# Video Demonstration:

https://youtu.be/srrufgOpGMg

# About

This is a project for the [Processing IDE](https://processing.org).

The code captures *motion* from looping Video Input A (using a frame differencing algorithm) and renders it with *movie* pixels from looping Video Input B (against a black background).

This rendering only displays in the white pixels of the provided mapping image, which can be used for projection mapping (see Calibration Mode notes below) or simply to alter the overall render space.

# Note on Data

No files are provided by default in the `data/` directory.

In order to run this sketch, you must provide:
- `data/image.jpg`
- `data/motion.mov`
- `data/movie.mov`

## Controls

#### GENERAL CONTROLS:
 * - Command + Shift + 'r' key: run in Presentation Mode
 * - 'c' key: toggle Calibration Mode to finetune projection mapping / keystone on physical object
       - NOTE: this can be used to manually flip the rendering's vertical/horizontal orientation
 * - 'm' key: toggle display of Projection Mapping file: "image.jpg"
 	   - NOTE: only visible while in Calibration Mode
 * - 's' key: save the current Calibration to a file for future use
 * - 'l' key: load the saved Calibration file
 	   - NOTE: rendering is upside-down by default; using the 'l' key is your friend

#### TUNING CONTROLS:
        - NOTE: movementThreshold defaults to 20 when program starts
 * - UP arrow key: increase current movementThreshold value by 2
 * - DOWN arrow key: decrease current movementThreshold value by 2
        - NOTE: movementThresholds less than 0 will result in only "movie" pixels displaying,
        - (meaning that the "motion" video feed will be completely overwritten / invisible)
 * - LEFT arrow key: set movementThreshold to 10
 * - RIGHT arrow key: set movementThreshold to 100
       - NOTE: higher movementThresholds make "distant" objects disappear
