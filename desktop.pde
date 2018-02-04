/**************************
 - Desktop
 - Start Button
 - Task Manager
 - Task bar 
 **************************/

//Desktop
class desktop
{
  ArrayList<window> windows = new ArrayList<window>();

  desktop()
  {
    
  }

  void registerWindow(window w)
  {
    this.windows.add(w);
  }

  void render()
  {
    fill(255);
    textSize(15);
    text("ovo " + VERSION, 20, 20);
  }
}

//Start Button
class startButton
{
  button start = new button(13, height - 38, 35, 30, loadImage("textures/button/start/normal.png"));
  startButton() {}

  void render()
  {
    start.render();
    if (start.isClicked)
    {
      exit();
    }
  }
}

//Task Manager
class taskManager
{
  int w;

  ArrayList<String> systemNames = new ArrayList<String>();

  taskManager(int w)
  {
    this.w = w;
  }
  
  String[] getSystemNames()
  {
    String st[] = new String[systemNames.size()];
    for(int a = 0; a < systemNames.size(); a++)
    {
      st[a] = systemNames.get(a);
    }
    
    return st;
  }

  void registerApplication(String systemName)
  {
    this.systemNames.add(systemName);
  }

  void render()
  {
    fill(218, 218, 218);
    stroke(0);
    rect(0, height - 42, width - w, 42);
    button[] buttons = new button[systemNames.size()];

    for (int a = 0; a < systemNames.size(); a++)
    {
      buttons[a] = new button((int) ((a + 1) * 38 + 18), (int) (height - 38.5), 32, 32, system.getWindow(systemNames.get(a)).icon); //system.getWindow(systemNames.get(a)).icon)
      buttons[a].render();
      if(buttons[a].isClicked)
      {
        system.getWindow(systemNames.get(a)).open();
      }
    }
  }
}

//Task Bar
class taskBar
{
  int w = 191;
  int rw = w;

  button btnClock;
  dialog clockDialog;
  layout lClock;
  label clockDisplay;
  image displayClock;
  PGraphics imgClock;
  int cx, cy;
  int radius;

  ArrayList<PImage> icons = new ArrayList<PImage>();
  ArrayList<dialog> dialogs = new ArrayList<dialog>();

  taskBar()
  {
    btnClock = new button(width - 73, height - 39, 70, 30, "");
    
    lClock = new layout(320, 235);
    displayClock = new image(1, 1, 180, 180);
    imgClock = createGraphics(displayClock.w, displayClock.h);
    clockDisplay = new label(3, 190, 177, 30, "");
        
    cx = imgClock.width / 2;
    cy = imgClock.height / 2;
    
    radius = min(cx, cy) - 2;
    
    lClock.addComponent(displayClock);
    lClock.addComponent(clockDisplay);
    
    clockDialog = new dialog(lClock);
  }

  void updateWidth()
  {
    if (icons.size() > 2)
    {
      w = rw + ((icons.size() - 3) * 38);
    }
  }

  int getWidth() 
  {
    return w;
  }

  void registerApplication(PImage icon, layout l) 
  {
    if (icons.size() < 6)
    {
      this.icons.add(icon);
      if (l != null)
      {
        this.dialogs.add(new dialog(l));
      }

      updateWidth();
    }
  }

  void render()
  {
    fill(198, 198, 198);
    stroke(0);
    rect(width - w, height - 42, w, 42);

    btnClock.render();
    clockDialog.render();
    btnClock.setText(clock(false));
    
    drawClock();

    if (btnClock.isClicked)
    {
      clockDialog.open(mouseX - clockDialog.main.w - 12, height - 42 - clockDialog.main.h - 12);
    }

    for (int a = 0; a < icons.size(); a++)
    {
      button buttons[] = new button[icons.size()];

      buttons[a] = new button((int) (width - ((a + 2.4) * 38 + 18)), (int) (height - 38.5), 30, 30, icons.get(a));
      buttons[a].render();
      dialogs.get(a).render();

      if (buttons[a].isClicked)
      {
        dialogs.get(a).open(mouseX - dialogs.get(a).main.w - 12, height - 42 - dialogs.get(a).main.h - 12);
      }
    }
  }
  
  void drawClock()
  {
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

  String clock(boolean showSecs)
  {
    String clockText = "";

    if (minute() < 10)
    {
      if (hour() < 10)
      {
        clockText = "0" + hour() + ":0" + minute();
      } 
      else
      {
        clockText = hour() + ":0" + minute();
      }
    }
    else
    {
      if (hour() < 10)
      {
        clockText = "0" + hour() + ":" + minute();
      } 
      else 
      {
        clockText = hour() + ":" + minute();
      }

      if (showSecs)
      {
        if (second() < 10)
        {
          clockText += ":0" + second();
        } 
        else 
        {
          clockText += ":" + second();
        }
      }
    }

    return clockText;
  }
}