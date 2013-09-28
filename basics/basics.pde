// Global variables for screen dimensions
int width;
int height;

// Foreground and background colors
color bg = color(0, 0, 0);
color fg = color(200, 200, 200, 100);    // This contains an alpha value

/*************************************************************************
 The main setup functions - runs once
 *************************************************************************/
void setup() {
  int i;
  float x, y, lenX, lenY;
  color c1 = color(255, 0, 0, 100);
  color c2 = color(0, 0, 255, 100);

  // Initialize the canvas
  width = displayWidth;  
  height = displayHeight;
  size(width, height);

  // Paint the background
  fill(bg);
  stroke(bg);
  rect(0, 0, width, height);

  fill(fg);
  stroke(fg);
  
  // Loop through i
  for(i = 0; i < 2500; i++){
    // generate random dimensions
    x = random(0, width);
    y = random(0, height);
    lenX = random(10, 100);
    lenY = random(10, 100);
    
    // Linear interpolation of color
    fill(lerpColor(c1, c2, random(0, 1)));
    if(i % 2 == 0){
      ellipse(x, y, lenX, lenY);
    } else {
      rect(x, y, lenX, lenY);
    }
  }
  
}
