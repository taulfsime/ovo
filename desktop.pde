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

    for (int a = 0; a < buttons.length; a++)
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

  button clock;
  dialog clockDialog;

  ArrayList<PImage> icons = new ArrayList<PImage>();
  ArrayList<dialog> dialogs = new ArrayList<dialog>();

  taskBar()
  {
    clock = new button(width - 73, height - 39, 70, 30, "");
    clockDialog = new dialog(320, 235, new clock());
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

  void registerApplication(PImage icon, application app) 
  {
    if (icons.size() < 6)
    {
      this.icons.add(icon);
      if (app != null)
      {
        dialog d = new dialog(250, 250, app);
        this.dialogs.add(d);
      }

      updateWidth();
    }
  }

  void render()
  {
    fill(198, 198, 198);
    stroke(0);
    rect(width - w, height - 42, w, 42);

    clock.render();
    clockDialog.render();
    clock.setText(clock(false));

    if (clock.isClicked)
    {
      clockDialog.open(mouseX - clockDialog.w, height - 42 - clockDialog.h);
    }

    for (int a = 0; a < icons.size(); a++)
    {
      button buttons[] = new button[icons.size()];

      buttons[a] = new button((int) (width - ((a + 2.4) * 38 + 18)), (int) (height - 38.5), 30, 30, icons.get(a));
      buttons[a].render();
      dialogs.get(a).render();

      if (buttons[a].isClicked)
      {
        dialogs.get(a).open(mouseX - 250, height - 42 - 250);
      }
    }
  }

  String clock(boolean showSecs)
  {
    String clockText;

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