import com.leapmotion.leap.*; 
import org.seltar.Bytes2Web.*;
boolean cursorP = true;
int maxCursorSize = 35;
PShape cursor;
color secondColor = color(255, 10, 10);
//


Vector tip;
color paintColor;
//float x = tip.getX() * width;
//float y = height - tip.getY() * height;
//float cursorSize = maxCursorSize - maxCursorSize * tip.getZ();

Controller leap = new Controller();

void setup() {
  frameRate(120);
  smooth();
  size(1000, 1000, P3D);
  background(255, 255, 255);
  noStroke();
  cursor = createShape(ELLIPSE, 0, 0, 30, 30);
}

void draw() {
  //leap motion size
  //println( getStabilizedPosition);
  Frame frame = leap.frame();
  Pointable pointer = frame.pointables().frontmost();
  //locate finger ("pointer")
  if (pointer.isValid()) {
    color frontColor = color(12, 135, 224);

    InteractionBox iBox = frame.interactionBox();
    Vector tip = iBox.normalizePoint(pointer.tipPosition());
    fingerPaint(tip, frontColor);
    //cursorPaint(tip);
  }
}

void fingerPaint(Vector tip, color paintColor) {
  fill(paintColor);
  float x = tip.getX() * width;
  float y = height - tip.getY() * height;
  float cursorSize = maxCursorSize - maxCursorSize * tip.getZ();


  if (cursorSize > 13) {
    fill(12, 135, 224);
    ellipse(x, y, cursorSize, cursorSize);
  }

  if (cursorSize < 13) {
    fill(255, 135, 70);
    ellipse(x, y, 20, 20);
  }
}

//println(tip.getZ());


/*void cursorPaint(Vector tip) {
 float x = tip.getX() * width;
 float y = height - tip.getY() * height;
 float cursorSize = maxCursorSize - maxCursorSize * tip.getZ();
 
 if ((cursorSize < 13) && (cursorP)) {
 
 fill(255, 33, 124);
 ellipse(x, y, 15, 15);
 //cursorP = false;
 
 }
 }
 */
/*void keyPressed() {

  if (keyPressed == true) {
    background(255,255,255);
       String url = "http://192.168.8.50:3000/upload";
   ImageToWeb img = new ImageToWeb(this);
   img.save("jpg", true);
   img.post("IMG", url, "IMG", true, img.getBytes(g));
    }
   
  }*/
  
  
 


