int width;
int height;

color bg = color(0, 0, 0);
color fg = color(200, 200, 200, 100);

/*************************************************************************
 The main setup functions - runs once
 *************************************************************************/
void setup() {
  // Initiate the canvas
  width = displayWidth;  
  height = displayHeight;
  size(width, height);

  // Paint the background
  fill(bg);
  stroke(bg);
  rect(0, 0, width, height);

  fill(fg);
  stroke(fg);
  
  /*
  int i;
  for(i = 0; i < 25; i++){
    ellipse(i * i , i * i , i * 4, i * 4);
  }
  */
}
