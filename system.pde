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
  
  void registerApplication(application app)
  {
    this.windows.add(new window(app));
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
    if(renderWindows.size() > 1)
    {
      for(int a = renderWindows.size() - 1; a > 0 ; a--)
      {
        if(!getWindow(renderWindows.get(a)).isOverWindow() && getWindow(renderWindows.get(a - 1)).isOverWindow() && mouseClicked)
        {
          String s = renderWindows.get(a - 1);
          renderWindows.set(a - 1, renderWindows.get(a));
          renderWindows.set(a, s);
          
          //for(int q = a; q > 0; q--)
          //{
          //  renderWindows.set(q, renderWindows.get(q - 1));
          //}
        }
      }
    }
  }
}