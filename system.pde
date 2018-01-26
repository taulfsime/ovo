class system
{
  ArrayList<window> windows = new ArrayList<window>();
  
  system() {}
  
  void registerApplication(String systemName, application app)
  {
    this.windows.add(new window(systemName, app));
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