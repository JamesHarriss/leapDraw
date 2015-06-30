import com.leapmotion.leap.*; 
import org.seltar.Bytes2Web.*;
boolean cursorP = true;
int maxCursorSize = 35;
PShape cursor;
color secondColor = color(255, 10, 10);
Controller leap = new Controller();



//menu


static final int NUMMENUBUTTONS = 3;
boolean drawBoxes;

void setup() {
  frameRate(120);
  smooth();
  size(1000, 1000, P3D);
  background(255, 255, 255);
  noStroke();
  cursor = createShape(ELLIPSE, 0, 0, 30, 30);
  //// second frame
  

}

void draw() {
if (millis() < 10000)//in milliseconds
  {
     
    displayMenu();
  }
  else {
    //rest of the code
    background(255);
  Frame frame = leap.frame();
  Pointable pointer = frame.pointables().frontmost();

  if (pointer.isValid()) {
    color frontColor = color(12, 135, 224);
    InteractionBox iBox = frame.interactionBox();
    Vector tip = iBox.normalizePoint(pointer.tipPosition());
    fingerPaint(tip, frontColor);
  }

  //second frame
 
}
}
void fingerPaint(Vector tip, color paintColor) {
  fill(paintColor);
  float x = tip.getX() * width;
  float y = height - tip.getY() * height;
  float cursorSize = maxCursorSize - maxCursorSize * tip.getZ();
  rect(128, 128, 30, cursorSize);

  if (cursorSize > 14) {
    fill(12, 135, 224);
    ellipse(x, y, cursorSize, cursorSize);
  } else if (cursorSize < 14) {
    
    fill(128, 128, 128);
    ellipse(x, y, 3, 3);
  }
}
void keyPressed() {

  if (keyPressed == true) {
    //background(255, 255, 255);
    String url = "http://192.168.8.35:3000/upload";
    ImageToWeb img = new ImageToWeb(this);
    img.save("jpg", true);
    img.post("img", url, "img", true, img.getBytes(g));
    draw();
   
  }
}

void displayMenu() {
background(255, 255, 255);
  PFont font;
// The font must be located in the sketch's 
// "data" directory to load successfully
font = loadFont("NanumGothic-24.vlw");
textFont(font, 24);
fill(12, 135, 224);
text("test", 480, 100);
text("Lorem ipsum dolor sit amet, consectetur adipiscing", 250, 400);
  
}



