import com.leapmotion.leap.*; 

int maxCursorSize = 35;
PShape cursor;
color secondColor = color(255, 10, 10);
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
  Frame frame = leap.frame();
  Pointable pointer = frame.pointables().frontmost();
  //locate finger ("pointer")
  if (pointer.isValid()) {
    color frontColor = color(12, 135, 224);
    
    InteractionBox iBox = frame.interactionBox();
    Vector tip = iBox.normalizePoint(pointer.tipPosition());
    fingerPaint(tip, frontColor);
  }
}

void fingerPaint(Vector tip, color paintColor) {
  fill(paintColor);
  float x = tip.getX() * width;
  float y = height - tip.getY() * height;
  float cursorSize = maxCursorSize - maxCursorSize * tip.getZ();

  ellipse(x, y, cursorSize, cursorSize);

  println(tip.getZ());
 
   
println(cursorSize);
 
 if (tip.getZ() < 13) {
   fill(255, 33, 124);
    ellipse(x, y, 30, 30);
   
  }
 
  if (cursorSize == 0.0) {
    //ellipse(x, y, cursorSize, cursorSize);
    println("GONE");
    saveFrame("/Users/jamesharris/Desktop/Draw/sketch_150624a/img/pic###.jpg");
    background(255, 255, 255);
  }
}
void keyPressed() {

  if (keyPressed == true) {
     redraw();
    //background(255, 255, 255);
  }
}

