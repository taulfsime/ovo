taskManager taskManager;
taskBar taskBar;
desktop desktop;
startButton startButton;
system system;
data data;

String lang = "eng.txt";
final String VERSION = "alpha v0.1";
boolean mouseClicked = false;
boolean mouseDragged = false;
boolean keyClicked = false;
boolean needTextureUpdate = false;

/*******************

  *TODO: check for file exist (langs) /helper/
  *TODO: Add suport for change a background color!! /painter/

*******************/

void setup()
{  
  fullScreen();
  //size(1000, 700);

  if(needTextureUpdate)
  {
    background(0);
    needTextureUpdate = false;
  }
  
  system = new system();
  taskBar = new taskBar();
  taskManager = new taskManager(taskBar.getWidth());
  startButton = new startButton();
  desktop = new desktop();
    
  taskBar.registerApplication(loadImage("textures/taskBar/setting.png"), new setting());

  system.registerApplication("calculator", new calculator());
  system.registerApplication("painter", new painter());
  system.registerApplication("exampleApp", new example());
  system.registerApplication("appMaker", new appMaker());
  
  taskManager.registerApplication("calculator");
  taskManager.registerApplication("exampleApp");
  taskManager.registerApplication("painter");
}

void draw()
{
  background(0);
  
  desktop.render();
  taskManager.render();
  startButton.render();
  taskBar.render();
  system.render();
  
  mouseDragged = false;
  mouseClicked = false;
  keyClicked = false;
  fps();
}

void mouseDragged()
{
  mouseDragged = true;
}

void mousePressed()
{
  mouseClicked = true;
}

void keyPressed()
{
  keyClicked = true;
}

void mouseReleased()
{
  
}

void fps()
{
  frameRate(60);
  if(frameRate < 60)
  {
    fill(255, 0, 0);
  }
  else if(frameRate > 60)
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

class clock extends application
{
  layout layout;
  label clock;
  image displayClock;
  PGraphics imgClock;
    
  int cx, cy;
  int radius;

  void preinit()
  {
    layout = new layout(250, 250);
    displayClock = new image(1, 1, 180, 180);
    imgClock = createGraphics(displayClock.w, displayClock.h);
    clock = new label(3, 190, 177, 30, "");
        
    cx = imgClock.width / 2;
    cy = imgClock.height / 2;
    
    radius = min(cx, cy) - 2;
    
    layout.addComponent(displayClock);
    layout.addComponent(clock);
  }
  
  void init()
  {
    setLayout(layout);
    
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
    clock.setText(taskBar.clock(true));
  }
}

class setting extends application
{
  layout layout;
  dataReader dataReader = new dataReader();
  itemList langs;
  
  void preinit()
  {
    //layout = new layout(x, y, w, h);
    //langs = new itemList(1, 1, 150, 25, dataReader.getLanguages()[0][0]);
    
    //layout.addComponent(langs);
    
    //for(int a = 0; a < dataReader.getNumLanguages(); a++)
    //{
    //  langs.addItem(dataReader.getLanguages()[a][0]);
    //}
  }
  
  void init()
  {
    setLayout(layout);
    
    lang = dataReader.getLanguages()[langs.getSelectedNum()][1];
  }
}