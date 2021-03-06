class window
{
  application app;
  int x;
  int y;
  int w;
  int h;
  
  int newX;
  int newY;
  String systemName;
  boolean isOpen = false;
  boolean isLocked = true;
  boolean isActive = true;
  boolean isToolBarActive = true;
  button btnClose;
  label lbIcon;
  dataReader dataReader = new dataReader();
  PGraphics window;
  
  window(application app)
  {
    this.app = app;
    
    if(this.app != null)
    {
      this.app.init();
      this.app.update();
    }
    
    init();
  }
  
  void init()
  {
    if(app != null)
    {
      this.app.setActive(isActive);
      this.w = app.w + 12;
      this.h = app.h + 27;
    }
    else
    {
      this.app = new application(new applicationInfo("data/apps/empty.json"));
      this.w = 500;
      this.h = 500;
    }
    
    x = (width - this.w)/2;
    y = (height - this.h)/2;
    
    window = createGraphics(w + 1, h + 1);
    
    window.beginDraw();
    window.stroke(0);
    window.fill(216, 216, 216);
    window.rect(0, 0, w, 21);
    window.fill(216, 216, 216);
    window.rect(0, 21, w, h - 21);
    window.fill(200, 200, 200);
    window.rect(6, 21, w - 12, h - 27);
    window.endDraw();
    systemName = app.getInfo().getSystemName();
    
    lbIcon = new label(2, 2, 17, 17, getImage(app.getInfo().getIconDir()));
    btnClose = new button(w - 42, 0, 35, 16, loadImage("textures/button/close/normal.png"), loadImage("textures/button/close/over.png"), loadImage("textures/button/close/clicked.png"));
  }
  
  void addComponent(component c)
  {
    app.addComponent(c);
    app.init();
    app.update();
  }
  
  PImage getIcon()
  {
    return getImage(app.getInfo().getIconDir());
  }
  
  String getTitle()
  {
    return app.getInfo().getTitle();
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
  
  boolean isOverWindow()
  {
    if(mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h)
    {
      return true;
    }
    
    return false;
  }
  
  void open() 
  {
    init();
    isOpen = true;
  }
  
  void close()
  {
     x = (width - this.w)/2;
     y = (height - this.h)/2;
     
    init();
    
    isOpen = false;
  }
  
  boolean isOverToolBar()
  {
    if(mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + 14)
    {
      return true;
    }
    
    return false;
  }
  
  void render()
  {    
    if(isOpen)
    {
      lbIcon.translate(x, y);
      btnClose.translate(x, y);
      btnClose.setActive(isToolBarActive);
      
      if(app != null)
      {
        app.updateComponent(x + 6, y + 21);
        if(app.w + 12 > width - this.x)
        {
          this.x = (width - this.w)/2;
        }
        
        if(app.h + 27 > height - this.y)
        {
          this.y = (height - this.h)/2;
        }
        
        if(this.w != app.w + 12 || this.h != app.h + 27)
        {
          init();
        }
        app.setActive(isActive && isLocked);
        
        image(window, x, y);
        btnClose.render();
        lbIcon.render();
        app.update();
        app.render();
        
        fill(0);
        textSize(13);
        text(app.getInfo().getTitle(), x + 24, y + 15.5);
      }
        
      if(isToolBarActive && mouseButton == LEFT && mouseClicked)
      {
        if(isOverToolBar())
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
      
      if(mouseX < 0 || mouseX > width || mouseY < 0 || mouseY > height || mouseReleased)
      {
        isLocked = true;
      }
      
      if(btnClose.isClicked())
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

class windowMessage extends window
{
  layout main;
  label mess;
  button done;
  String text;
  
  windowMessage(String text)
  {
    super(null);
    this.text = text;
  }
  
  void init()
  {
    super.init();
    main = new layout(250, 150);
    mess = new label(20, 10, 210, 80, text);
    done = new button(210, 100, 60, 30, "Done!");
    
    main.addComponent(mess);
    main.addComponent(done);
    
    this.app.setLayout(main);
  }
  
  void render()
  {
    super.render();
    
  }
}

class windowGetInfo extends window
{
  String info = "";
  layout main;
  button done;
  button cancel;
  textField enterInfo;
  
  windowGetInfo()
  {
    super(null);
  }
  
  void init()
  {
    super.init();
    
    main = new layout(250, 150);
    enterInfo = new textField(10, 70, 230, 30, "Enter:");
    done = new button(35, 110, 100, 30, "Done");
    cancel = new button(140, 110, 100, 30, "Cancel");
    
    ////////ERROR////////////
    
    main.addComponent(enterInfo);
    main.addComponent(done);
    main.addComponent(cancel);
    
    app.setLayout(main);
  }
  
  void render()
  {
    super.render();
    if(done.isClicked())
    {
      info = enterInfo.getText();
      //super.close();
    }
    else if(cancel.isClicked())
    {
      //super.close();
    }
  }
  
  String getInfo()
  {
    return info;
  }
}

class dialog
{
  int x;
  int y;
  application app;
  boolean isOpen = false;
  
  dialog(application app)
  {
    this.app = app;
    this.app.init();
    this.app.update();
  }
  
  void open(int x, int y)
  {
    this.x = x;
    this.y = y;

    if(!isOpen)
    {
      app.init();
      isOpen = true;
    }
  }
  
  void close()
  {
    if(isOpen)
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
      rect(x, y, app.w + 12, app.h + 12);
      
      //base
      fill(200, 200, 200);
      rect(x + 6, y + 6, app.w, app.h);
      
      if(app != null)
      {
        app.updateComponent(x + 6, y + 6);
        app.update();
        app.render();
      }
      
      if(mouseClicked && (mouseX < x || mouseX > x + app.w + 12 || mouseY < y || mouseY > y + app.h + 12))
      {
        close();
      }
    }
  }
}