//  Set to pixels for any size. Defaults create a wallpaper for the current screen size.
int WINDOW_HEIGHT = 900;
int WINDOW_WIDTH = 1440;

int START_HEIGHT = WINDOW_HEIGHT / 150;    // smallest penguins
int END_HEIGHT = WINDOW_HEIGHT / 15;       // and the largest
float SLOPE = float(END_HEIGHT - START_HEIGHT) / float(WINDOW_HEIGHT); // creates the illusion of perspective

float xPos = -200;
float yPos = -20;
float height = START_HEIGHT;
float width = height / 2;

float xJitter = height / 5;
float yJitter = width / 5;

PImage tux;
PFont font;


// Load image and set framerate
void setup(){
  size(WINDOW_WIDTH, WINDOW_HEIGHT);
  font = createFont("Baskerville", WINDOW_HEIGHT * .09);      // Make sure you have the font on your system - otherwise change to one you have
  tux = loadImage("tux.gif");
  frameRate(5);
}

// Draw one row at a time
void draw(){
  int x = 0, y = 0;

  // Screen filled. Write text, save image and exit
  if((yPos + height) > WINDOW_HEIGHT - (WINDOW_HEIGHT * .05)){
      fill(20,20,20, 230);
      rect(0, WINDOW_HEIGHT * .85, WINDOW_WIDTH, WINDOW_HEIGHT);
      textFont(font);
      textAlign(CENTER);
      fill(255,255,255);
      text("GNU / LINUX", WINDOW_WIDTH / 2, WINDOW_HEIGHT * .98);
      textSize(WINDOW_HEIGHT * .04);
      //text("March of the Penguins", WINDOW_WIDTH / 2, WINDOW_HEIGHT * .90);
      save("posters/march_of_penguins.jpg");
      exit();
  }

  // Draw the penguins!
  while(x < WINDOW_WIDTH){
    x = int(xPos + random(-xJitter, xJitter));
    y = int(yPos + random(-yJitter, yJitter));
    pushMatrix();
    translate(x + width / 2, y + height / 2);
    scale(random(.8, 1.2), random(.8, 1.2));
    rotate(random(-20, 20) * PI / 180);
    image(tux, -width / 3, - height / 2, width, height);
    popMatrix();
    xPos += width;
  }
  // Update values for next row
  height += height * SLOPE;
  width += width * SLOPE;
  xJitter += xJitter * SLOPE;
  yJitter += yJitter * SLOPE;
  xPos = -width;
  yPos += yJitter * 1.4;

}

