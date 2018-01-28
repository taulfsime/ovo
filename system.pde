class system
{
  ArrayList<window> windows = new ArrayList<window>();
  
  system() {}
  
  void registerApplication(String systemName, application app)
  {
    this.windows.add(new window(systemName, app));
  }
  
  String[] getSystemNames()
  {
    String[] ws = new String[windows.size()];
    for(int a = 0; a < windows.size(); a++)
    {
      ws[a] = windows.get(a).systemName;
    }
    return ws;
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
  
  
  void render()
  { 
    for(window w : windows)
    {
        w.render();
        w.move();
    }
  }
}