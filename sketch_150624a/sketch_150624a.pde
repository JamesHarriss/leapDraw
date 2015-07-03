import com.leapmotion.leap.*; 
import org.seltar.Bytes2Web.*;
boolean cursorP = true;
int maxCursorSize = 35;
PShape cursor;
color secondColor = color(255, 10, 10);
PFont font;
int time;
Controller leap = new Controller();
Cursor myCursor;
Typetester tester;


ArrayList <Cursor> cursors = new ArrayList <Cursor>();


void setup() {
  frameRate(120);
  smooth();
  size(1000, 1000, P3D);
  noStroke();
  cursor = createShape(ELLIPSE, 0, 0, 30, 30);
  time = millis();//store the current time
  myCursor = new Cursor(width/2, height/2, 0.00, 10, color(0, 0, 0));
  tester = new Typetester();
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
      // fingerPaint(tip, frontColor);
      myCursor.updateCursor(tip.getX(), tip.getY());
      //
      background(255, 255, 255);
println(tip.getZ());
      for (int i = cursors.size ()-1; i>0; i--) {
        //cursors.get(i).drawCursor();
        cursors.get(i).drawCursor();
      }
      if (tip.getZ() >= 0.70) {
        
      myCursor.drawCursor();
      } else if (tip.getZ() <= 0.70){
        cursors.add(0, new Cursor(tip.getX() * width, height - tip.getY() * height, 0, 20, color(#1286FF)));
      }
    }
  }

  if (millis() >= 60000) {
    draw();
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

void timer() {
  font = loadFont("NanumGothic-24.vlw");
  textFont(font, 24);
  fill(12, 135, 224);
  time = millis();
  text(time, 100, 100);
}

class Cursor {
  float x;
  float y;
  float z;
  float r;
  color c;

  Cursor(float xpos, float ypos, float zpos, float radius, color colour) {
    x = xpos;
    y = ypos;
    z = zpos;
    r = radius;
    c = colour;
  }

  void drawCursor() {
    fill(this.c);
    ellipse(this.x, this.y, this.r, this.r);
  }

  void updateCursor(float newx, float newy) {
    this.x = newx * width;
    this.y = height - newy * height;
  }
}

class Typetester {
  void printType(byte x) {
    System.out.println(x + " is an byte");
  }
  void printType(int x) {
    System.out.println(x + " is an int");
  }
  void printType(float x) {
    System.out.println(x + " is an float");
  }
  void printType(double x) {
    System.out.println(x + " is an double");
  }
  void printType(char x) {
    System.out.println(x + " is an char");
  }
}

