/**************************
 - Desktop
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

//Task Manager
class taskManager
{
  int displayNameTime = 30; //Timer
  int w;
  data data = new data("taskManagerApps");
  taskButton startButton = new taskButton(13, height - 40, 41, 38, getImage("textures/start.png"), "Start");

  ArrayList<String> systemNames = new ArrayList<String>();
  ArrayList<taskButton> buttons = new ArrayList<taskButton>();

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
  
  void save()
  {
    data.clear();
    int n = 0;
    for(String s : systemNames)
    {
      data.toTag("appSlot" + n, s);
      n++;
    }
  }
  
  void read()
  {
    for(String s : data.getTags())
    {
      for(String t : system.getSystemNames())
      {
        if(checkStrings(data.getTag(s), t) && !checkStrings(t, "console"))
        {
          registerApplication(t);
          break;
        } 
      }
    }
  }

  void registerApplication(String systemName)
  {
    for(String s : system.getSystemNames())
    {
      if(checkStrings(s, systemName))
      {
        this.systemNames.add(s);
        buttons.add(new taskButton((systemNames.size() - 1)*43 + 58, height - 40, 40, 38, system.getWindow(s).getIcon(), system.getWindow(s).getTitle()));
      }
    }
  }
  
  void unregisterApplication(String systemName)
  {
    systemNames.remove(systemName);
  }

  void render()
  {
    fill(218, 218, 218);
    stroke(0);
    rect(0, height - 42, width - w, 42);
    
    startButton.render();
    if(startButton.isClicked())
    {
      exit();
    }
    
    for(int a = 0; a < buttons.size(); a++)
    {
      buttons.get(a).render();
      if(buttons.get(a).isClicked())
      {
        system.open(systemNames.get(a));
      }
    }
    
    startButton.renderText();
    for(taskButton b : buttons)
    {
      b.renderText();
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
    

    if (btnClock.isClicked())
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

      if (buttons[a].isClicked())
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

class taskButton
{
  PImage icon;
  String text;
  int textTimer = 30;
  int timer;
  boolean isActive = true;
  int x;
  int y;
  int w;
  int h;
  
  taskButton(int x, int y, int w, int h, PImage icon, String text)
  {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    
    this.text = text;
    this.icon = icon;
  }
  
  void render()
  {
    stroke(50, 50, 50);
    strokeWeight(0.5);
    
    if(isOver() && isActive)
    {
      if(isClicked())
      {
        fill(200, 200, 200);
      }
      else
      {
        fill(220, 220, 220);
      }
    }
    else
    {
      fill(255, 255, 255);
    }
    rect(x, y, w, h, min(x, y) - 3);
    
    image(icon, x + 8, y + 8, w - 16, h - 16);
  }
  
  void renderText()
  {
    if(isActive && isOver())
    {
      stroke(50, 50, 50);
      strokeWeight(0.3);
      fill(130, 130, 130);
      rect(mouseX, mouseY - 30, textWidth(text) + 10, 30, 29);
      
      textSize(14);
      fill(255, 255, 255);
      text(text, mouseX + 6, mouseY - 10);
    }
  }
  
  void setActive(boolean active)
  {
    this.isActive = active;
  }
  
  boolean isClicked()
  {
    if(isOver() && mouseClicked && isActive)
    {
      return true;
    }
    
    return false;
  }
  
  boolean isOver()
  {
    if(mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h)
    {
      return true;
    }
    
    return false;
  }
}