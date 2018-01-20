class system
{
  ArrayList<window> windows = new ArrayList<window>();
  ArrayList<application> app = new ArrayList<application>();
  
  system() {}
  
  void registerApplication()
  {
    window window = new window("test");
    this.windows.add(window);
    taskManager.registerWindow(window);
  }
  
  void registerApplication(String systemName, application app)
  {
    window window = new window(systemName);
    window.setApplication(app);
    this.windows.add(window);
    taskManager.registerWindow(window);
  }
  
  void registerApplication(String systemName, int w, int h, application app)
  {
    window window = new window(systemName, w, h);
    window.setApplication(app);
    this.windows.add(window);
    taskManager.registerWindow(window);
  }
  
  window getWindow(String systemName)
  {
    for(window w : windows)
    {
      if(w.systemName == systemName)
      {
        return w;
      }
    }
    return null;
  }
  
  PImage getIcon(String systemName)
  {
    for(window w : windows)
    {
      if(w.systemName == systemName)
      {
        return w.icon;
      }
    }
    return null;
  }
  
  
  void render()
  { 
    for(window w : windows)
    {
        w.render();
        w.move();
    }
  }
}