int width;
int height;

color bg = color(0, 0, 0);
color fg = color(200, 200, 200, 150);

int nbounce = 20;
int[] x = new int[nbounce];
int[] y = new int[nbounce];
int[] vx = new int[nbounce];
int[] vy = new int[nbounce];

int radius = 50;

void setup() {
  int i;
  float[] vector; 

  // Build the canvas
  width = displayWidth;  
  height = displayHeight - 250;
  size(width, height);
  
  for(i = 0; i < nbounce; i++){
    x[i] = (int) random(0, width);
    y[i] = (int) random(0, height);
    vx[i] = (int) random(3, 5);
    vy[i] = (int) random(3, 5);
  }
  
  frameRate(60);
  
}

void draw(){
  int i;
  
  // Paint the background
  fill(bg);
  stroke(bg);
  rect(0, 0, width, height);
  stroke(fg);
  fill(fg);

  for(i = 0; i < nbounce; i++){
  
    if(x[i] < 0 + radius / 2 || x[i] > width - radius / 2){
      vx[i] = -vx[i];
    }
    if(y[i] < 0 + radius / 2 || y[i] > height - radius / 2){
      vy[i] = -vy[i];
    }
  
    ellipse(x[i], y[i], radius, radius);
    x[i] += vx[i];
    y[i] += vy[i];
  }
  
}
  
