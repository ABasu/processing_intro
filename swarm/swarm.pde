int width;
int height;

color bg = color(0, 0, 0);
color fg = color(200, 200, 200, 150);

int fishcount = 1000; // No. of circles
float min_dist = 75;  // Dist for repulsion
float max_dist = 400; // Dist for attraction
float min_speed = 10; // Speed range 
float max_speed = 25;
float turn_angle = (PI / 180) * 8;
int safe_neighbors = 400;

int pause = 1;

float[][] fish;     // The list of points, each defined by two vectors, position and a unit vector for direction

/*************************************************************************
 The main setup functions - runs once
 *************************************************************************/
void setup() {
  int i;
  float[] vector; 

  // Build the canvas
  width = displayWidth;  
  height = displayHeight - 50;
  size(width, height);
  // Paint the background
  fill(bg);
  stroke(bg);
  rect(0, 0, width, height);
  stroke(fg);
  fill(fg);
  strokeWeight(5);

  // Initialize speheres in random positions and with random directions and speed
  fish = new float[fishcount][5];

  for (i = 0; i < fishcount; i++) {
    fish[i][0] = random(0, width);
    fish[i][1] = random(0, height);
    // Generate another pair of random points on the screen and compute a unit vector pointing to that point. 
    // This is our randomized direction
    vector = computeUnitVector(fish[i][0], fish[i][1], fish[i][0] + random(-10, 10), fish[i][1] + random(-10, 10));
    fish[i][2] = vector[0];
    fish[i][3] = vector[1];
    // Finally, we need a speed.
    fish[i][4] = random(min_speed, max_speed);
    line(fish[i][0], fish[i][1], fish[i][0] + fish[i][2] * fish[i][4], fish[i][1] + fish[i][3] * fish[i][4]);

  }
  frameRate(10);
}

/*************************************************************************
 The draw loop
 *************************************************************************/
void draw() {
  
  if(pause == 1){
    return;
  }
  
  color fishcolor;
  int no_neighbors = 0;
  int i, j;
  float dist = 0, weight, sign, turn = 0;
  float[] newSpeedVector = new float[2];
  
  //Paint the background
  fill(bg);
  stroke(bg);
  rect(0, 0, width, height);
  stroke(fg);

  // Loop through all fishes
  for (i = 0; i < fishcount; i++) {
    no_neighbors = 0;
    // Loop through all the other fish
    for (j = 0; j < fishcount; j++) {
      turn = 0;
      // don't compare the point to itself
      if(i == j){
        continue;
      }
      // find distance between fishes
      dist = computeDistance(fish[i], fish[j]);
      
      // If Min dist has been reached fish march together, but we introduce a smattering of randomness 
      if (dist < min_dist){
        // close fish count as two neighbors in safety terms
        no_neighbors += 2;
        
        fish[i][2] = fish[j][2];
        fish[i][3] = fish[j][3];
        turn = random(0, 10);
        if (turn > 8){
          turn = random(-10, 10);
        } else{
          turn = 0;
        }
      } else if (dist < max_dist && dist > min_dist){
        no_neighbors += 1;
        
        weight = (max_dist - dist) / max_dist;  // between 0 and 1
        sign = computeSign(fish[i], fish[j]);   // 0 = no effect, 1 = left, -1 = right
        turn += turn + (weight * sign);
      }
    }  // Done with j loop
    // Turn should now be either +ve or -ve, left or right. 
    turn = Math.signum(turn) * turn_angle;
    newSpeedVector = rotateVector(fish[i], turn);

    if(no_neighbors > safe_neighbors){
      no_neighbors = safe_neighbors;
    }
    fishcolor = (lerpColor(color(255, 50, 0, 200), color(0, 100, 255, 200), (float)no_neighbors / safe_neighbors));
    stroke(fishcolor);
    
    // Bounce off the walls
    if(fish[i][0] <= 0 || fish[i][0] >= width){
      newSpeedVector = new float[] {fish[i][2] * -1, fish[i][3]};
    }
    if(fish[i][1] <= 0 || fish[i][1] >= height){
      newSpeedVector = new float[] {fish[i][2], fish[i][3] * -1};
    }

    line(fish[i][0], fish[i][1], fish[i][0] + newSpeedVector[0] * fish[i][4], fish[i][1] + newSpeedVector[1] * fish[i][4]);

    fish[i][0] += newSpeedVector[0] * fish[i][4];
    fish[i][1] += newSpeedVector[1] * fish[i][4];
    fish[i][2] = newSpeedVector[0];
    fish[i][3] = newSpeedVector[1];
  }    // Done with i loop
}

void mouseClicked(){
  if(pause == 0){
    pause = 1;
  } else{
    pause = 0;
  }
}

/*************************************************************************
 Calculates distance between two fishes
 *************************************************************************/
float computeDistance(float[] i, float[] j){
  return (float) Math.sqrt(Math.pow(i[0] - j[0], 2) + Math.pow(i[1] - j[1], 2));
}

/*************************************************************************
 calculates the unit vector for a vector between two points
 *************************************************************************/
float[] computeUnitVector(float x1, float y1, float x2, float y2) {
  float len;
  float[] vector = new float[2];

  len = (float)Math.sqrt(Math.pow(x1 - x2, 2) + Math.pow(y1 - y2, 2));
  vector[0] = (x1 - x2) / len;
  vector[1] = (y1 - y2) / len;

  return vector;
}

/*************************************************************************
 Calculate the angle in radians between the speed vector of one fish and 
 the position of another
*************************************************************************/
int computeSign(float[] i, float[] j) {
  float[] jVector = new float[2];
  float cos_theta, sin_theta;
  int sign;
  
  sign = (int) Math.signum((i[0] - i[2]) * (j[1] - i[3]) - (i[1] - i[3]) * (j[0] - i[2]));
  return(-1 * sign);
}

/*************************************************************************
 Take the speed vector of a fish and rotate it by an angle theta
*************************************************************************/
float[] rotateVector(float[] i, float theta){
  float[] vector = new float[2];
  
  vector[0] = (float) (i[2] * Math.cos(theta) - i[3] * Math.sin(theta));
  vector[1] = (float) (i[2] * Math.sin(theta) + i[3] * Math.cos(theta));
  
  return vector;
}
