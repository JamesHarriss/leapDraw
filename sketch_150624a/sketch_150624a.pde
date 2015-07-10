import com.leapmotion.leap.*; 
import org.seltar.Bytes2Web.*;
boolean cursorP = true;
boolean savePDF = false;
int maxCursorSize = 35;
int time;
color secondColor = color(255, 10, 10);
PFont font;
PFont font2;
PShape cursor;
ArrayList <Cursor> cursors = new ArrayList <Cursor>();
PImage photo;
PImage screen1;
PImage logo;
PImage smallLogo;
Controller leap = new Controller();
Cursor myCursor;


String generateName() {
  String[] prefixes = {
    "Agreeable", "Exa", "Benders", "Optima", "Cyber", "Galactic",
    "General", "Oz", "Franklin", "Titan", "Super", "Union", "Nexus",
    "Boomer", "Hacksaw", "Wall", "Monsters", "Bombach", "Burger",
    "Fuzzy", "e", "O\'Niner", "Tricycle", "The Nerd", "Halibut",
    "McQueen", "Hamilton", "McCoy", "Harold"
  };
  String[] middles = {
    "Corp", " & Sons", "Mart", " World", " Banks", "-Mech",
    "rax", "", "BigBucks", " Plumbing", " Brothers", "Greens",
    " Town", " Place", "Donalds", " Consortium", " Firms",
    " Burgers", " Commerce", " Aeronautics", " Technology",
    " Innovations", " Labs", "Lightening", " Vendors", " Steel", " Oil",
    " Publishing", " Manufacturing", " Designers", " Dairy", " Drilling"
  };
  String[] suffixes = {
    "Agreeable", "Exa", "Benders", "Optima", "Cyber", "Galactic",
    "General", "Oz", "Franklin", "Titan", "Super", "Union", "Nexus",
    "Boomer", "Hacksaw", "Wall", "Monsters", "Bombach", "Burger",
    "Fuzzy", "e", "O\'Niner", "Tricycle", "The Nerd", "Halibut",
    "McQueen", "Hamilton", "McCoy", "Harold"
  };
  int pre = (int)random(0, prefixes.length);
  int mid = (int)random(0, middles.length);
  int suf = (int)random(0, suffixes.length);
  return prefixes[pre] + middles[mid] + suffixes[suf];
}
 
PFont font1;
boolean switchName = false;
String currentName = generateName();




void setup() {
  frameRate(120);
  smooth();
  size(1000, 1000, P3D);
  noStroke();
  cursor = createShape(ELLIPSE, 0, 0, 30, 30);
  time = millis();
  myCursor = new Cursor(width/2, height/2, 0.00, 10, color(0, 0, 0));
  photo = loadImage("point.png");
  logo = loadImage("logo.png");
  smallLogo = loadImage("smallLogo.png");
  screen1 = loadImage("screen.png");
  font = loadFont("Futura-Medium-28.vlw");
  font2 = loadFont("Futura-Medium-16.vlw");
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
      background(#EDEDED);
      ui();

      for (int i = cursors.size ()-1; i>0; i--) {
        cursors.get(i).drawCursor();
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
  if (key == 's' || key == 'S') {
    fill(#EDEDED);
  ellipse(482, 62, 200, 200);
  fill(#EDEDED);
  ellipse(100, 800, 250, 90); //down up
  fill(#5DAA00);
   if (switchName) {
    currentName = generateName();
    switchName = false;
  }
    String url = "http://localhost:3000/upload";
    ImageToWeb img = new ImageToWeb(this);
    img.save("jpg", true);
    img.post(currentName, url, currentName, true);
  }
  if (key == 'c' || key == 'C') {
    fill(255, 255, 255);
    rect(0, 0, 1000, 1000);
    cursors.clear();
    millis();
  }
}

void displayMenu() {

  background(#EDEDED);
  textFont(font, 28);
  fill(#5DAA00);
  text("Draw with your finger.", 370, 510);
  text("Press C to clear and S to save", 320, 560 );
  image(logo, 380, 160);

  if (millis() > 9800) {
    background(#EDEDED);
  }
}


void ui() {
  smooth();
  fill(#EDEDED);
  ellipse(482, 62, 100, 100);
  image(smallLogo, 450, 30);
  textFont(font2, 16);
  fill(#EDEDED);
  ellipse(100, 800, 250, 90);
  fill(#5DAA00);
  text("Draw with your finger.", 10, 790);
  text("Press C to clear and S to save", 10, 810 );
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



