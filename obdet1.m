% Read the MP4 video
video = VideoReader('fishdet.mp4');

% Define the frame rate and the number of frames
frameRate = video.FrameRate;
numFrames = video.NumFrames;

% Initialize an array to store the detected objects
detectedObjects = cell(numFrames, 1);

% Set parameters for moving object detection
thresholdFactor = 0.8; % Adjust as needed
minArea = 100; % Adjust as needed
maxArea = 5000; % Adjust as needed

% Loop through each frame of the video
previousFrame = [];
for i = 1:numFrames
    % Read the current frame
    currentFrame = read(video, i);
    
    % Convert the frame to grayscale
    grayFrame = rgb2gray(currentFrame);
    
    % Apply a median filter to remove noise
    filteredFrame = medfilt2(grayFrame, [5, 5]);
    
    % Apply a threshold to binarize the image
    if isempty(previousFrame)
        binaryFrame = zeros(size(grayFrame));
    else
        differenceFrame = imabsdiff(filteredFrame, previousFrame);
        threshold = thresholdFactor * graythresh(differenceFrame);
        binaryFrame = imbinarize(differenceFrame, threshold);
    end
    
    % Detect objects in the binary image
    objects = regionprops(binaryFrame, 'BoundingBox', 'Area', 'Centroid');
    
    % Filter out small and large objects
    objects([objects.Area] < minArea) = [];
    objects([objects.Area] > maxArea) = [];
    
    % Store the detected objects in the array
    detectedObjects{i} = objects;
    
    % Set the current frame as the previous frame for the next iteration
    previousFrame = filteredFrame;
end

% Display the detected objects for each frame
for i = 1:numFrames
    % Read the current frame
    frame = read(video, i);
    
    % Draw the bounding boxes and centroids around the detected objects
    objects = detectedObjects{i};
    for j = 1:length(objects)
        box = objects(j).BoundingBox;
        centroid = objects(j).Centroid;
        frame = insertShape(frame, 'Rectangle', box, 'LineWidth', 2, 'Color', 'red');
        frame = insertMarker(frame, centroid, 'x', 'Color', 'red');
    end
    
    % Display the frame
    imshow(frame);
    drawnow;
end
v=VideoWriter("fishdet.mp4");