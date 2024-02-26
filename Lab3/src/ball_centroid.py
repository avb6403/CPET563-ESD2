import cv2
import numpy as np

# Define a function to process the image and find the centroid of the ball
def find_ball_centroid(image):
    # Convert to grayscale
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    
    # Apply a Gaussian blur to the image to reduce noise and improve edge detection
    blurred = cv2.GaussianBlur(gray, (11, 11), 0)
    
    # Perform edge detection
    edged = cv2.Canny(blurred, 30, 150)
    
    # Find contours in the edged image
    contours, _ = cv2.findContours(edged.copy(), cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
    
    # Assume no ball found initially
    ball_centroid = None
    max_radius = -1
    
    # Loop over the contours
    for c in contours:
        # Approximate the contour
        peri = cv2.arcLength(c, True)
        approx = cv2.approxPolyDP(c, 0.02 * peri, True)
        
        # The ball will be approximated by a significant number of points due to its round shape
        if len(approx) > 5:
            # Compute the bounding circle of the contour
            (x, y), radius = cv2.minEnclosingCircle(c)
            
            # Choose the largest enclosing circle as the ball
            if radius > max_radius:
                ball_centroid = (int(x), int(y))
                max_radius = int(radius)
                
    return ball_centroid, max_radius

# Load the images
image_files = [
    '/mnt/data/left5.jpg', '/mnt/data/left6.jpg', '/mnt/data/left7.jpg',
    '/mnt/data/left8.jpg', '/mnt/data/left9.jpg', '/mnt/data/right5.jpg',
    '/mnt/data/right6.jpg', '/mnt/data/right7.jpg', '/mnt/data/right8.jpg',
    '/mnt/data/right9.jpg'
]

# Dictionary to hold the results
results = {}

# Process each image
for image_file in image_files:
    # Read the image
    image = cv2.imread(image_file)
    
    # Find the ball's centroid
    centroid, radius = find_ball_centroid(image)
    
    # Store the results
    results[image_file] = {'centroid': centroid, 'radius': radius}

results

