class window
{
  application app;
  PImage icon;
  int x;
  int y;
  int w;
  int h;
  
  int newX;
  int newY;
  int timer = 0;
  String systemName;
  String title;
  boolean isOpen = false;
  boolean isLocked = true;
  boolean isActive = true;
  button btnClose;
  label lbIcon;
  collisionBox toolBar;
  data data = new data("");
  dataReader dataReader = new dataReader();
  
  window(String systemName, application app)
  {
    this.app = app;
    this.app.init();
    this.app.update();
    this.w = app.w;
    this.h = app.h;
    
    x = (width - this.w)/2;
    y = (height - this.h)/2;
    
    this.systemName = systemName;
    
    update();
  }
  
  //SETS
  void setActive(boolean active) 
  {
    this.isActive = active;
    
    btnClose.setActive(active);
  }
  
  void open() 
  {
    if(app != null)
    {
      this.app.init();
    }
    
    isOpen = true;
  }
  
  void close()
  {
     x = (width - this.w)/2;
     y = (height - this.h)/2;
    
    isOpen = false;
  }
  
  void update()
  {
    toolBar = new collisionBox(x, y + 7, w, 14);
    
    icon = data.getImage("textures/applicationIcon/" + systemName + ".png");
    lbIcon = new label(x + 2, y + 2, 17, 17, icon);
    title = dataReader.getAppTitle(systemName, lang);
    btnClose = new button(x + w - 42, y, 35, 16, loadImage("basic/button/close/normal.png"), loadImage("basic/button/close/over.png"), loadImage("basic/button/close/clicked.png"));
  }
  
  void render()
  {
    if(isOpen)
    {
      update();
      
      stroke(0);
      fill(216, 216, 216);
      rect(x, y, w, 21);
      fill(216, 216, 216);
      rect(x, y + 21, w, h - 21);
      fill(200, 200, 200);
      rect(x + 6, y + 21, w - 12, h - 27);
      
      fill(0);
      textSize(13);
      text(title, x + 24, y + 15.5);
      
      btnClose.render();
      lbIcon.render();
      
      if(app != null)
      {
        app.updateComponent(x, y);
        w = app.w;
        h = app.h;
        app.update();
        app.render();
      }
        
      mousePress();
      mouseDrag();
      
      if(mouseX < 0 || mouseX > width || mouseY < 0 || mouseY > height)
      {
        isLocked = true;
      }
      
      if(isActive)
      {
        if(btnClose.isClicked)
        {
          close();
        }
      }
    }
  }
  
  void renderAtTaskManager(int num)
  {
    int displayNameTime = 30; //Timer
    
    label displayName = new label((int) (num * 38 + 18) + 16 - (int) (textWidth(title)/2), height - 62, (int) textWidth(title), 20, title);
    
    button btnTaskManager = new button((int) (num * 38 + 18), (int) (height - 38.5), 32, 32, icon); //32
    
    btnTaskManager.setActive(!isOpen);
    btnTaskManager.render();
    
    if(btnTaskManager.isClicked)
    {
      if(!isOpen)
      {
        open();
        btnTaskManager.setActive(false);
      }
      
      timer = displayNameTime + 1;
    } 
    else if(btnTaskManager.isOver)
    {
      String a = dataReader.getAppTitle(systemName, lang);
      if(title != a)
      {
        title = a;
      }
      
      if(timer < displayNameTime + 1)
        timer++;
    }
    else 
    {
      timer = 0;
    }
      
    if(timer > displayNameTime && timer < displayNameTime + 2)
    {
      displayName.render();
    }
  }
  
  void move()
  { 
      newX = mouseX - x;
      newY = mouseY - y;
  }
  
  void mousePress()
  {
    if(isActive && mouseClicked && isOpen && mouseButton == LEFT)
    {
      if(toolBar.isOver())
      {
        isLocked = false;
      }
      else 
      {
        isLocked = true;
      }
    }
  }
  
  public void mouseDrag()
  {
    if(isActive && mouseDragged && isOpen)
    {
      needTextureUpdate = true;
      if(!isLocked) //move
      {
        if(mouseX - newX >= 0 && mouseX - newX + w < width)
        {
          x = mouseX - newX;
        }
        if(mouseY - newY >= 0 && mouseY - newY + h < height)
        {
          y = mouseY - newY;
        }
      }
    }
  }
}

class dialog
{
  int x;
  int y;
  int w;
  int h;
  application app;
  boolean isOpen = false;
  
  dialog(int w, int h, application app)
  {
    this.w = w;
    this.h = h;
    this.app = app;
  }
  
  dialog(int w, int h)
  {
    this.w = w;
    this.h = h;
  }
  
  void open(int x, int y)
  {
    this.x = x;
    this.y = y;
    needTextureUpdate = true;
    
    if(!isOpen)
    {
      if(app != null)
      {
        app.init();
      }
      
      isOpen = true;
    }
  }
  
  void close()
  {
    if(mouseClicked && (mouseX < x || mouseX > x + w || mouseY < y || mouseY > y + h))
    {
      isOpen = false;
    }
  }
  
  void render()
  {
    if(isOpen)
    {
      stroke(0, 0, 0);
      
      //border
      fill(216, 216, 216);
      rect(x, y, w, h);
      
      //base
      fill(200, 200, 200);
      rect(x + 6, y + 6, w - 12, h - 12);
      
      if(app != null)
      {
        app.updateComponent(x + 6, y + 6);
        w = app.w - 12;
        h = app.h - 12;
        app.init();
        app.render();
      }
      
      close();
    }
  }
}