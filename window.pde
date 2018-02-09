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
  String addToTitle = null;
  boolean isOpen = false;
  boolean isLocked = true;
  boolean isActive = true;
  boolean isToolBarActive = true;
  button btnClose;
  label lbIcon;
  collisionBox toolBar;
  dataReader dataReader = new dataReader();
  
  window(String systemName, application app)
  {
    this.app = app;
    this.app.setActive(isActive);
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
  }
  
  void setToolBarActive(boolean active)
  {
    isToolBarActive = active;
  }
  
  void open() 
  {
    isOpen = true;
  }
  
  void close()
  {
     x = (width - this.w)/2;
     y = (height - this.h)/2;
     
    if(app != null)
    {
      this.app.init();
    }
    
    isOpen = false;
  }
  
  void update()
  {
    toolBar = new collisionBox(x, y + 7, w, 14);
    
    icon = dataReader.getImage("textures/applicationIcon/" + systemName + ".png");
    lbIcon = new label(x + 2, y + 2, 17, 17, icon);
    title = dataReader.getAppTitle(systemName, lang);
    btnClose = new button(x + w - 42, y, 35, 16, loadImage("textures/button/close/normal.png"), loadImage("textures/button/close/over.png"), loadImage("textures/button/close/clicked.png"));
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
      if(addToTitle == null)
      {
        text(title, x + 24, y + 15.5);
      }
      else
      {
        text(title + " | " + addToTitle, x + 24, y + 15.5);
      }
      
      btnClose.setActive(isToolBarActive);
      
      btnClose.render();
      lbIcon.render();
      
      if(app != null)
      {
        app.updateComponent(x, y);
        if(app.w + 12 > width - this.x)
        {
          this.x = (width - this.w)/2;
        }
        
        if(app.h + 27 > height - this.y)
        {
          this.y = (height - this.h)/2;
        }
        
        w = app.w + 12;
        h = app.h + 27;
        app.setActive(isActive && isLocked);
        app.update();
        app.render();
      }
        
      if(isToolBarActive && mouseClicked && isOpen && mouseButton == LEFT)
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
      
      if(isToolBarActive && mouseDragged && isOpen)
      {
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
      
      if(mouseX < 0 || mouseX > width || mouseY < 0 || mouseY > height)
      {
        isLocked = true;
      }
      
      if(btnClose.isClicked)
      {
        close();
      }
    }
  }
  
  void move()
  {
    newX = mouseX - x;
    newY = mouseY - y;
  }
}

class dialog
{
  int x;
  int y;
  layout main;
  boolean isOpen = false;
  
  dialog(layout l)
  {
    this.main = l;
  }
  
  void open(int x, int y)
  {
    this.x = x;
    this.y = y;

    if(!isOpen)
    {
      isOpen = true;
    }
  }
  
  void close()
  {
    if(mouseClicked && (mouseX < x || mouseX > x + main.w || mouseY < y || mouseY > y + main.h))
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
      rect(x, y, main.w + 12, main.h + 12);
      
      //base
      fill(200, 200, 200);
      rect(x + 6, y + 6, main.w, main.h);
      
      if(main != null)
      {
        main.updateComponent(x + 6, y + 6);
        this.main.render();
      }
      
      close();
    }
  }
}