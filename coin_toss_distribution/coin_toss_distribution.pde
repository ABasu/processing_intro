// Global variables - available across functions
// Screen dimensions
int width;
int height;

// Background and foreground colors
color bg = color(0, 0, 0);
color fg = color(200, 200, 200);

// The distribution of toss results
int[] tossResults = new int[1000]; 

// The vertical unit for drawing the bars
int barUnit = 10;
int barWidth;


/*************************************************************************
 The main setup functions - runs once
 *************************************************************************/
void setup() {
  // Initiate the canvas
  width = displayWidth;  
  height = displayHeight - 100;
  size(width, height);
  
  barWidth = width / 100;

  // Paint the background
  fill(bg);
  stroke(bg);
  rect(0, 0, width, height);
  frameRate(1000);
  }

/*************************************************************************
 The draw function - this loops repeatedly
 *************************************************************************/
void draw(){
  int result;
  
  // Toss the coins a 1000 times and record the no. of heads.
  result = tossCoins();
  // Increment the relevant column in the histogram by 1
  tossResults[result] += 1;
  // draw the graph
  drawBars();
}

/*************************************************************************
 Toss the coins and count the number of heads
 *************************************************************************/
int tossCoins(){
  // Index, number of heads and individual tosses
  int i, heads = 0;
  float toss;
  
  for(i = 0; i < 1000; i++){
    toss = random(-1, 1);
    if(toss > 0){
      heads += 1;
    }
  }
  return heads;
}

/*************************************************************************
 Draw the histogram
 *************************************************************************/
void drawBars(){
  // Index, height
  int i, h;
  // Paint the background
  fill(bg);
  rect(0, 0, width, height);
  fill(fg);
  
  // Loop through the values we want to plot
  for(i = 450; i < 550; i++){
    // Check if we've hit the top of the screen and adjust barUnits accordingly.
    if(tossResults[i] * barUnit > height){
      barUnit /= 1.01;
    }
    // Draw the bars
    rect((i - 450) * barWidth, height, barWidth, -tossResults[i] * barUnit);
  }
}
