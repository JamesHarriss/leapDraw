import com.leapmotion.leap.*; 
import org.seltar.Bytes2Web.*;
boolean cursorP = true;
int maxCursorSize = 35;
PShape cursor;
color secondColor = color(255, 10, 10);
PFont font;
PFont font2;
int time;
ArrayList <Cursor> cursors = new ArrayList <Cursor>();

PImage photo;
PImage screen1;
PImage logo;
PImage smallLogo;

Cursor myCursor;
import generativedesign.*;
import processing.pdf.*;
import java.util.Calendar;
import com.leapmotion.leap.*;
boolean savePDF = false;
Controller leap = new Controller();


void setup() {
  frameRate(120);
  smooth();
  size(1000, 1000, P3D);
  noStroke();
  cursor = createShape(ELLIPSE, 0, 0, 30, 30);
  time = millis();//store the current time
  myCursor = new Cursor(width/2, height/2, 0.00, 10, color(0, 0, 0));
  photo = loadImage("point.png");
   logo = loadImage("logo.png");
   smallLogo = loadImage("smallLogo.png");
  screen1 = loadImage("screen.png");
  font = loadFont("LucidaConsole-28.vlw");
  font2 = loadFont("LucidaConsole-16.vlw");
}

void draw() {
  if (millis() < 10000)
  {
    displayMenu();
  } else {


    Frame frame = leap.frame();
    Pointable pointer = frame.pointables().frontmost();

    if (pointer.isValid()) {
      color frontColor = color(12, 135, 224);
      InteractionBox iBox = frame.interactionBox(); 
      Vector tip = iBox.normalizePoint(pointer.tipPosition());
      myCursor.updateCursor(tip.getX(), tip.getY());
      background(255, 255, 255);

      for (int i = cursors.size ()-1; i>0; i--) {
        cursors.get(i).drawCursor();
        smooth();
image(smallLogo, 450, 30);
        image(screen1, 0, 790);
      }
      if (tip.getZ() >= 0.70) {
        myCursor.drawCursor();
      } else if (tip.getZ() <= 0.70) {
        float maxSize = constrain(tip.getZ(), 0.15, 0.3);
        cursors.add(0, new Cursor(tip.getX() * width, height - tip.getY() * height, 0, 4 / maxSize, color(#5DAA00)));
      }
    }
  }

  if (millis() >= 60000) {
    redraw();
  }
}

void keyPressed() {
  /* if (keyPressed == true) {
   String url = "http://192.168.8.35:3000/upload";
   ImageToWeb img = new ImageToWeb(this);
   img.save("jpg", true);
   img.post("img", url, "img", true, img.getBytes(g));
   fill(255, 255, 255);
   rect(0, 0, 1000, 1000);
   cursors.clear();
   millis();
   }
   */
  if (key == 's' || key == 'S') {
    String url = "http://localhost:3000/upload";
    ImageToWeb img = new ImageToWeb(this);
    img.save("jpg", true);
    img.post("img", url, "img", true, img.getBytes(g));
  }
  if (key == 'c' || key == 'C') {
    fill(255, 255, 255);
    rect(0, 0, 1000, 1000);
    cursors.clear();
    millis();
  }
}


void displayMenu() {
  background(255, 255, 255);
  textFont(font, 28);
  fill(#5DAA00);
  text("Draw with your finger.", 300, 570);
  text("Press C to clear and S to save", 240, 620 );
  image(logo, 360, 60);

  if (millis() > 9800) {
    background(255, 255, 255);
  }
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

