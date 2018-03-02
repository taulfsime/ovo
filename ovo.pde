taskManager taskManager; //<>//
taskBar taskBar;
desktop desktop;
system system;

String lang = "eng.txt";
final String VERSION = "alpha v0.1";
boolean mouseClicked = false;
boolean mouseDragged = false;
boolean mouseReleased = false;
boolean keyClicked = false;
int scroll = 0;

/*******************
 
 *TODO: Add suport for change a background color!! /painter/
 *TODO: Remake textSize in components with text /components/
 *TODO: Finish file command /applicationCMD/
 *TODO: appMaker - editor /appMaker/
 *TODO: appManager - load apps /appManager/
 *TODO: fix creator /appMaker/
 *TODO: compList /filebrowser/
 
 *******************/

void setup()
{  
  fullScreen();
  //size(1000, 700);

  background(0);
  system = new system();
  taskBar = new taskBar();
  taskManager = new taskManager(taskBar.getWidth());
  desktop = new desktop();

  taskBar.registerApplication(loadImage("textures/taskBar/setting.png"), new setting());

  system.registerApplication(new painter());
  system.registerApplication(new calculator());
  system.registerApplication(new example());
  system.registerApplication(new carCalculator());
  system.registerApplication(new appMaker());
  system.registerApplication(new snakeGame());
  system.registerApplication(new textEditor());
  system.registerApplication(new fileBrowser());
  system.registerApplication(new appManager());
  system.registerApplication(new console());

  taskManager.registerApplication("console");
  taskManager.read();
}

void draw()
{
  //println(keyCode);
  
  background(0);
  fps();
  desktop.render();
  taskManager.render();
  taskBar.render();
  system.render();

  mouseDragged = false;
  mouseClicked = false;
  keyClicked = false;
  mouseReleased = false;
  scroll = 0;
}

void mouseDragged()
{
  mouseDragged = true;
}

void mousePressed()
{
  mouseClicked = true;
}

void mouseWheel(MouseEvent event) 
{
  scroll += event.getCount();
}

void keyPressed()
{
  keyClicked = true;
}

void mouseReleased()
{
  mouseReleased = true;
}

void fps()
{
  if (frameRate < 60)
  {
    fill(255, 0, 0);
  } 
  else if (frameRate > 60)
  {
    fill(0, 255, 0);
  }
  else 
  {
    fill(255, 255, 0);
  }
  textSize(17);
  text(frameRate, width - 65, 50);
}

boolean isFileExist(String dir)
{
  String[] s = null;
  s = loadStrings(dir);
  if (s != null)
  {
    return true;
  }

  return false;  
}

boolean isFolder(String fileName)
{
  for(int a = 0; a < fileName.length(); a++)
  {
    if(fileName.charAt(a) == '.')
    {
      return false;
    }
  }
  
  return true;
}

PImage createPImage(color c, int w, int h)
{
  PGraphics img = createGraphics(w, h);
  img.beginDraw();
  img.background(c);
  img.endDraw();
  return img;
}

boolean checkStrings(String s1, String s2)
{
  if (s1.length() != s2.length())
  {
    return false;
  }

  for (int a = 0; a < s1.length(); a++)
  {
    if (s1.charAt(a) != s2.charAt(a))
    {
      return false;
    }
  }
  return true;
}

PImage getImage(String dir)
{
  PImage img = null;

  img = loadImage(dir);

  if (img != null) 
  {
    return img;
  }

  return loadImage("textures/unknown.png");
}

String[] getFolderData(String dir)
{
  File d = new File(dataPath(dir));
  return d.list();
}

String replaceChar(String text, char prevCh, char newCh)
{
  for (int a = 0; a < text.length(); a++)
  {
    if (text.charAt(a) == prevCh)
    {
      text = text.substring(0, a - 1) + newCh + text.substring(a);
    }
  }
  return text;
}

String clock(boolean showSecs)
{
  String clockText = "";

  if (minute() < 10)
  {
    if (hour() < 10)
    {
      clockText = "0" + hour() + ":0" + minute();
    } else
    {
      clockText = hour() + ":0" + minute();
    }
  } else
  {
    if (hour() < 10)
    {
      clockText = "0" + hour() + ":" + minute();
    } else 
    {
      clockText = hour() + ":" + minute();
    }

    if (showSecs)
    {
      if (second() < 10)
      {
        clockText += ":0" + second();
      } else 
      {
        clockText += ":" + second();
      }
    }
  }

  return clockText;
}

class setting extends application
{
  layout main = new layout(250, 250);
  
  setting()
  {
    super(null);
  }
  
  void init()
  {
    
  }

  void update()
  {
    setLayout(main);
  }
}

class clockTaskBar extends application
{
  layout main;
  label clockDisplay;
  image displayClock;
  PGraphics imgClock;
  int cx, cy;
  int radius;

  clockTaskBar()
  {
    super(null);
  }

  void init()
  {
    main = new layout(320, 235);

    displayClock = new image(1, 1, 180, 180);
    imgClock = createGraphics(displayClock.w, displayClock.h);
    clockDisplay = new label(5, 185, 177, 30, "");

    cx = imgClock.width / 2;
    cy = imgClock.height / 2;

    radius = min(cx, cy) - 2;

    main.addComponent(displayClock);
    main.addComponent(clockDisplay);
  }

  void update()
  {
    setLayout(main);

    //Start To Create Clock Image
    imgClock.beginDraw();
    imgClock.fill(80);
    imgClock.noStroke();
    imgClock.ellipse(cx, cy, radius *1.8, radius *1.8);

    float s = map(second(), 0, 60, 0, TWO_PI) - HALF_PI;
    float m = map(minute() + norm(second(), 0, 60), 0, 60, 0, TWO_PI) - HALF_PI; 
    float h = map(hour() + norm(minute(), 0, 60), 0, 24, 0, TWO_PI * 2) - HALF_PI;

    imgClock.stroke(255);
    imgClock.strokeWeight(1);
    imgClock.line(cx, cy, cx + cos(s) * radius * 0.72, cy + sin(s) * radius * 0.72);
    imgClock.strokeWeight(2);
    imgClock.line(cx, cy, cx + cos(m) * radius * 0.6, cy + sin(m) * radius * 0.6);
    imgClock.strokeWeight(4);
    imgClock.line(cx, cy, cx + cos(h) * radius * 0.5, cy + sin(h) * radius * 0.5);

    imgClock.strokeWeight(2);
    imgClock.beginShape(POINTS);
    for (int a = 0; a < 360; a += 6) 
    {
      float angle = radians(a);
      float x = cx + cos(angle) * radius * 0.72;
      float y = cy + sin(angle) * radius * 0.72;
      imgClock.vertex(x, y);
    }
    imgClock.endDraw();
    //End Of Create Clock Image

    displayClock.setImage(imgClock);
    clockDisplay.setText(clock(true));
  }
}