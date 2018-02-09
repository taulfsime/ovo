class application
{
  layout layout;
  public int x;
  public int y;
  public int w;
  public int h;
  public boolean isActive = true;
  
  void init() {}
  void update() {}
  
  void setActive(boolean active)
  {
    isActive = active;
  }
  
  void render()
  {
    layout.setActive(isActive);
    
    layout.updateComponent(x, y);
    layout.render(); //<>//
  } //<>//
  
  void setLayout(layout newLayout)
  {
    if(newLayout != null)
    {
      layout = newLayout; //<>//
      
      w = layout.w;
      h = layout.h;
    }
  }
  
  void updateComponent(int x, int y)
  {
    this.x = x + 6;
    this.y = y + 21;
    layout = new layout(w, h);
    layout.x = this.x;
    layout.y = this.y;
  }
}