int width;
int height;

color bg = color(0, 0, 0);
color fg = color(200, 200, 200, 150);

int x;
int y;
int vx;
int vy;

int radius = 50;

void setup() {
  int i;
  float[] vector; 

  // Build the canvas
  width = displayWidth;  
  height = displayHeight - 50;
  size(width, height);
  
  x = (int) random(0, width);
  y = (int) random(0, height);
  vx = (int) random(3, 5);
  vy = (int) random(3, 5);
  
  frameRate(60);
  
}

void draw(){
  // Paint the background
  fill(bg);
  stroke(bg);
  rect(0, 0, width, height);
  stroke(fg);
  fill(fg);

  if(x < 0 + radius / 2 || x > width - radius / 2){
    vx = -vx;
  }
  if(y < 0 + radius / 2 || y > height - radius / 2){
    vy = -vy;
  }

  ellipse(x, y, radius, radius);
  x += vx;
  y += vy;
  
}
  
