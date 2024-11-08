# UNDERWATER-MOVING-OBJECT-DETECTION-USING-GOPRO-CAMERA

# Algorithm of MATLAB code used

Read the MP4 video using VideoReader function and store 
the frame rate and the number of frames in variables. Initialize an empty cell array to store the detected objects for 
each frame of the video. 
Set the parameters for moving object detection, such as the 
threshold factor, minimum and maximum areas of the objects. 
Loop through each frame of the video and perform the 
following operations on each frame: 

a. Read the current frame. 

b. Convert the frame to grayscale using rgb2gray function. 

c. Apply a median filter to remove noise using medfilt2 
function. 

d. Apply a threshold to binarize the image using imbinarize 
function. Here, the difference between the current frame and 
the previous frame is taken to detect the moving objects. 

e. Detect objects in the binary image using regionprops 
function, which returns the bounding boxes, areas, and 
centroids of the objects. 

f. Filter out small and large objects using the area 
information. 

g. Store the detected objects in the cell array for the current 
frame. 

h. Set the current frame as the previous frame for the next 
iteration. 

Loop through each frame of the video again and perform the 
following operations on each frame:
a. Read the current frame. 

b. Retrieve the detected objects for the current frame from the 
cell array.

c. Draw the bounding boxes and centroids around the detected 
objects using insertShape and insertMarker functions. 

d. Display the frame with the detected objects. 
