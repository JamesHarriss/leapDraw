import com.leapmotion.leap.*; 
import org.seltar.Bytes2Web.*;
boolean cursorP = true;
int maxCursorSize = 35;
PShape cursor;
color secondColor = color(255, 10, 10);
PFont font;
Controller leap = new Controller();

void setup() {
  frameRate(120);
  smooth();
  size(1000, 1000, P3D);
  noStroke();
  cursor = createShape(ELLIPSE, 0, 0, 30, 30);
}

void draw() {
  if (millis() < 5000)
  {
    displayMenu();
  } else {
    Frame frame = leap.frame();
    Pointable pointer = frame.pointables().frontmost();
    if (pointer.isValid()) {
      color frontColor = color(12, 135, 224);
      InteractionBox iBox = frame.interactionBox();
      Vector tip = iBox.normalizePoint(pointer.tipPosition());
      fingerPaint(tip, frontColor);
    }
  }
  if (millis() >= 60000) {
    draw();
  }
}
void fingerPaint(Vector tip, color paintColor) {
  fill(paintColor);
  float x = tip.getX() * width;
  float y = height - tip.getY() * height;
  float cursorSize = maxCursorSize - maxCursorSize * tip.getZ();

  if (cursorSize > 14) {
    noStroke();
    fill(12, 135, 224);
    ellipse(x, y, cursorSize, cursorSize);
  } else if (cursorSize < 14) {
    fill(255, 255, 255);
    stroke(2255);
    ellipse(x, y, 5, 5);
  }
}

void keyPressed() {
  if (keyPressed == true) {
    String url = "http://192.168.8.35:3000/upload";
    ImageToWeb img = new ImageToWeb(this);
    img.save("jpg", true);
    img.post("img", url, "img", true, img.getBytes(g));
    draw();
  }
}

void displayMenu() {
  background(255, 255, 255);
  font = loadFont("NanumGothic-24.vlw");
  textFont(font, 24);
  fill(12, 135, 224);
  text("test", 480, 100);
  text("Lorem ipsum dolor sit amet, consectetur adipiscing", 250, 400);
  if (millis() > 4800) {
    background(255, 255, 255);
  }
}

