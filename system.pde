class system
{
  window subwindow;
  ArrayList<window> windows = new ArrayList<window>();
  ArrayList<String> renderWindows = new ArrayList<String>();
  
  system(){}
  
  void openSubwindow(window w)
  {
    subwindow = w;
    subwindow.open();
  }
  
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
  
  void open(String systemName)
  {
    for(window w : windows)
    {
      if(w.systemName == systemName && !w.isOpen)
      {
        getWindow(systemName).open();
        break;
      }
    }
  }
  
  void close(String systemName)
  {
    for(window w : windows)
    {
      if(w.systemName == systemName && w.isOpen)
      {
        getWindow(systemName).close();
        break;
      }
    }
  }
  
  void render()
  {
    for(window w : windows)
    {
      if(w.isOpen)
      {
        boolean exist = false;
        for(int a = 0; a < renderWindows.size(); a++)
        {
          if(checkStrings(w.systemName, renderWindows.get(a)))
          {
            exist = true;
            a = renderWindows.size() + 10;
          }
        }
        
        if(!exist)
        {
          renderWindows.add(w.systemName);
        }
      }
      else
      {
        boolean exist = false;
        for(int a = 0; a < renderWindows.size(); a++)
        {
          if(checkStrings(w.systemName, renderWindows.get(a)))
          {
            exist = true;
            a = renderWindows.size() + 10;
          }
        }
        
        if(exist)
        {
          renderWindows.remove(w.systemName);
        }
      }
    }
    
    //for(int a = 0; a < renderWindows.size(); a++)
    //{
    //  for(int q = 0; q < renderWindows.size(); q++)
    //  {
    //    if(!checkStrings(renderWindows.get(a), renderWindows.get(q)))
    //    {
    //      String w1 = renderWindows.get(a);
    //      String w2 = renderWindows.get(q);
          
    //      println(w1 + " - " + getWindow(w1).y ,w2 + " - " + getWindow(w2).y);
          
    //      if(getWindow(w1).y > getWindow(w2).y)
    //      {
    //        getWindow(w1).setToolBarActive(true);
    //        getWindow(w2).setToolBarActive(false);
    //      }
    //      else
    //      {
    //        getWindow(w1).setToolBarActive(false);
    //        getWindow(w2).setToolBarActive(true);
    //      }
    //    }
    //  }
    //}
    
    //printArray(renderWindows);
    
    for(int a = 0; a < renderWindows.size(); a++)
    {
      String w = renderWindows.get(a);
      if(a == renderWindows.size() - 1 && subwindow == null)
      {
        getWindow(w).setActive(true);
        getWindow(w).setToolBarActive(true);
      }
      else
      {
        getWindow(w).setActive(false);
        getWindow(w).setToolBarActive(false);
      }
      
      getWindow(w).render();
      getWindow(w).move();
    }
    
    if(subwindow != null)
    {
      if(subwindow.isOpen)
      {
        subwindow.setActive(true);
        subwindow.setToolBarActive(true);
        subwindow.render();
        subwindow.move();
      }
      else
      {
        subwindow = null;
      }
    }
  }
}