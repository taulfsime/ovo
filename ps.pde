taskManager taskManager;
taskBar taskBar;
desktop desktop;
startButton startButton;
system system;

String lang = "eng.txt";
final String VERSION = "alpha v0.1";
boolean mouseClicked = false;
boolean mouseDragged = false;
boolean mouseReleased = false;
boolean keyClicked = false;

/*******************

  *TODO: check for file exist (langs) /helper/
  *TODO: Add suport for change a background color!! /painter/
  *TODO: Add a scrollbar in cmdLogger /applicationCMD/
  
*******************/

void setup()
{  
  fullScreen();
  //size(1000, 700);
  
  background(0);
  system = new system();
  taskBar = new taskBar();
  taskManager = new taskManager(taskBar.getWidth());
  startButton = new startButton();
  desktop = new desktop();
    
  taskBar.registerApplication(loadImage("textures/taskBar/setting.png"), setting());

  system.registerApplication("painter", new painter());
  system.registerApplication("calculator", new calculator());
  system.registerApplication("exampleApp", new example());
  system.registerApplication("carCalculator", new carCalculator());
  system.registerApplication("testTextArea", new testTextArea());
  system.registerApplication("appMaker", new appMaker());
  system.registerApplication("consoleNewV", new consoleNewV());

  system.registerApplication("console", new console());

  for(String s : system.getSystemNames())
  {
    taskManager.registerApplication(s);
  }
}

void draw()
{
  background(0);
  
  fps();
  desktop.render();
  taskManager.render();
  startButton.render();
  taskBar.render();
  system.render();
  
  mouseDragged = false;
  mouseClicked = false;
  keyClicked = false;
  mouseReleased = false;
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
  mouseReleased = true;
}

void fps()
{
  //frameRate(60);
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

boolean checkStrings(String s1, String s2)
{
  if(s1.length() != s2.length())
  {
    return false;
  }
  
  for(int a = 0; a < s1.length(); a++)
  {
    if(s1.charAt(a) != s2.charAt(a))
    {
      return false;
    }
  }
  return true;
}

String replaceChar(String text, char prevCh, char newCh)
{
  for(int a = 0; a < text.length(); a++)
  {
    if(text.charAt(a) == prevCh)
    {
      text = text.substring(0, a - 1) + newCh + text.substring(a);
    }
  }
  return text;
}

layout setting()
{
  layout main = new layout(250, 250);
  
  return main; //<>// //<>//
}