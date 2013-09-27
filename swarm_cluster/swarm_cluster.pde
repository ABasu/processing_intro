int width;
int height;

color bg = color(0, 0, 0);
color fg = color(200, 200, 200);

int swarm = 1000;  // No. of circles
int speed = 5; 
int radius = 5;
int min_dist = 50; 
int max_dist = 200;

float cx[];   // centers 
float cy[];
float v[];    // speeds
float vx[];   // x axis speed
float vy[];   // y axis speed

/*************************************************************************
 The main setup functions - runs once
 *************************************************************************/
void setup() {
  int i;

  // Initialize arrays
  cx = new float[swarm];
  cy = new float[swarm];
  v = new float[swarm];
  vx = new float[swarm];
  vy = new float[swarm];

  // Initiate the canvas
  width = displayWidth;  
  height = displayHeight;
  size(width, height);

  // Paint the background
  fill(bg);
  stroke(bg);
  rect(0, 0, width, height);

  for (i = 0; i < swarm; i++) {
    cx[i] = random(0 + radius, width - radius);
    cy[i] = random(0 + radius, height - radius);
    v[i] = random(5, 5);
  }
  frameRate(12);
}

void draw() {
  int i, j, k;
  float tx = 0, ty = 0;
  double dist, h, sin_theta, cos_theta;    
  // Paint the background
  fill(bg);
  stroke(bg);
  rect(0, 0, width, height);

  for (i = 0; i < swarm; i++) {
    k = 1;
    for (j = 0; j < swarm; j++) {
      dist = Math.sqrt(Math.pow((cx[i] - cx[j]), 2) + Math.pow((cy[i] - cy[j]), 2));
      if ( dist < max_dist && dist > min_dist) {
        tx += cx[j];
        ty += cy[j];
        k += 1;
      }
    }

    tx = tx / k; 
    ty = ty / k;

    /* Ant trails
    if(i + 1 != swarm){
      tx = cx[i+1]; 
      ty = cy[i+1]; 
    } else {
      tx = cx[0];
      ty = cy[0];
    }
    **/

    // Distance to target
    h = Math.sqrt(Math.pow((cx[i] - tx), 2) + Math.pow((cy[i] - ty), 2));
    cos_theta = (tx - cx[i]) / h;
    sin_theta = (ty - cy[i]) / h;
    vx[i] = (float) (v[i] * cos_theta);
    vy[i] = (float) (v[i] * sin_theta);
    
    if ((int)cx[i] <= 0 + radius || (int) cx[i] >= width - radius) {
      vx[i] = -vx[i];
    }
    if ((int)cy[i] <= 0 + radius || (int) cy[i] >= height - radius) {
      vy[i] = -vy[i];
    }

    if (h > 10) {
      cx[i] += vx[i];
      cy[i] += vy[i];
    }

    fill(fg);
    ellipse((int)cx[i], (int)cy[i], radius * 2, radius * 2);
  }
}

