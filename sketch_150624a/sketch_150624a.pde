import com.leapmotion.leap.*; 
import org.seltar.Bytes2Web.*;
boolean cursorP = true;
int maxCursorSize = 35;
PShape cursor;
color secondColor = color(255, 10, 10);
PFont font;
int time;
ArrayList <Cursor> cursors = new ArrayList <Cursor>();

Cursor myCursor;
import generativedesign.*;
import processing.pdf.*;
import java.util.Calendar;
import com.leapmotion.leap.*;
boolean savePDF = false;
Controller leap = new Controller();
// an array for the nodes
Node[] nodes = new Node[100];
// an array for the springs
Spring[] springs = new Spring[0];

// dragged node
Node selectedNode = null;

float nodeDiameter = 16;
void setup() {
  frameRate(120);
  smooth();
  size(1000, 1000, P3D);
  noStroke();
  cursor = createShape(ELLIPSE, 0, 0, 30, 30);
  time = millis();//store the current time
  myCursor = new Cursor(width/2, height/2, 0.00, 10, color(0, 0, 0));
  initNodesAndSprings();
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
      println(5/tip.getZ());

      for (int i = cursors.size ()-1; i>0; i--) {
        cursors.get(i).drawCursor();
      }
      if (tip.getZ() >= 0.70) {
        myCursor.drawCursor();
      } else if (tip.getZ() <= 0.70) {
    float maxSize = constrain(tip.getZ(), 0.15, 0.3);
        cursors.add(0, new Cursor(tip.getX() * width, height - tip.getY() * height, 0, 4 / maxSize, color(#1286FF)));
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
      String url = "http://192.168.8.35:3000/upload";
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
  for (int i = 0 ; i < nodes.length; i++) {
    nodes[i].attract(nodes);
  } 
  // apply spring forces
  for (int i = 0 ; i < springs.length; i++) {
    springs[i].update();
  } 
  // apply velocity vector and update position
  for (int i = 0 ; i < nodes.length; i++) {
    nodes[i].update();
  } 
  // draw nodes
  stroke(0, 130, 164);
  strokeWeight(2);
  for (int i = 0 ; i < springs.length; i++) {
    line(springs[i].fromNode.x, springs[i].fromNode.y, springs[i].toNode.x, springs[i].toNode.y);
  }
  // draw nodes
  noStroke();
  for (int i = 0 ; i < nodes.length; i++) {
    fill(255);
    ellipse(nodes[i].x, nodes[i].y, nodeDiameter, nodeDiameter);
    fill(0);
    ellipse(nodes[i].x, nodes[i].y, nodeDiameter-4, nodeDiameter-4);
  }
  font = loadFont("NanumGothic-24.vlw");
  textFont(font, 24);
  fill(12, 135, 224);
  text("test", 480, 100);
  text("Lorem ipsum dolor sit amet, consectetur adipiscing", 250, 400);
  if (millis() > 9800) {
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
void initNodesAndSprings() {
  // init nodes
  float rad = nodeDiameter/2;
  for (int i = 0; i < nodes.length; i++) {
    nodes[i] = new Node(width/2+random(-200, 200), height/2+random(-200, 200));
    nodes[i].setBoundary(rad, rad, width-rad, height-rad);
    nodes[i].setRadius(100);
    nodes[i].setStrength(-5);
  } 

  // set springs randomly
  springs = new Spring[0];

  for (int j = 0 ; j < nodes.length-1; j++) {
    int rCount = floor(random(1, 2));
    for (int i = 0; i < rCount; i++) {
      int r = floor(random(j+1, nodes.length));
      Spring newSpring = new Spring(nodes[j], nodes[r]);
      newSpring.setLength(20);
      newSpring.setStiffness(1);
      springs = (Spring[]) append(springs, newSpring);
    }
  }

}
