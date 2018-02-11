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
  int displayNameTime = 30; //Timer
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
    label[] showNames = new label[systemNames.size()];
    //label showName;

    for (int a = 0; a < systemNames.size(); a++)
    {
      showNames[a] = new label((int) (a * 38 + 18) + 16 - (int) (textWidth(systemNames.get(a))/2), height - 62, (int) textWidth(systemNames.get(a)), 20, systemNames.get(a));
      buttons[a] = new button((int) ((a + 1) * 38 + 18), (int) (height - 38.5), 32, 32, system.getWindow(systemNames.get(a)).icon);
      buttons[a].render();
      if(buttons[a].isClicked)
      {
        system.open(systemNames.get(a));
        //cTimer[a] = displayNameTime + 5;
      }
      
      //if(buttons[a].isOver && cTimer[a] <= displayNameTime)
      //{
      //  cTimer[a]++;
      //}
      //else
      //{
      //  cTimer[a] = 0;
      //}
      //println(cTimer[a], buttons[a].isOver);
      //if(cTimer[a] > displayNameTime && cTimer[a] < displayNameTime + 2)
      //{
      //  showNames[a].render();
      //}
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

  ArrayList<PImage> icons = new ArrayList<PImage>();
  ArrayList<dialog> dialogs = new ArrayList<dialog>();

  taskBar()
  {
    btnClock = new button(width - 73, height - 39, 70, 30, "");
    
    clockDialog = new dialog(new clockTaskBar());
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
        this.dialogs.add(new dialog(app));
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
    

    if (btnClock.isClicked)
    {
      if(clockDialog.isOpen)
      {
        clockDialog.close();
      }
      else
      {
        clockDialog.open(mouseX - clockDialog.app.w - 12, height - 42 - clockDialog.app.h - 12);
      }
    }

    for (int a = 0; a < icons.size(); a++)
    {
      button buttons[] = new button[icons.size()];

      buttons[a] = new button((int) (width - ((a + 2.4) * 38 + 18)), (int) (height - 38.5), 30, 30, icons.get(a));
      buttons[a].render();
      dialogs.get(a).render();

      if (buttons[a].isClicked)
      {
        if(!dialogs.get(a).isOpen)
        {
          dialogs.get(a).open(mouseX - dialogs.get(a).app.w - 12, height - 42 - dialogs.get(a).app.h - 12);
        }
        else
        {
          dialogs.get(a).close();
        }
      }
    }
  }
}