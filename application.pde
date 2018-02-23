class application
{
  layout layout = new layout(500, 500);;
  public int x;
  public int y;
  public int w;
  public int h;
  public boolean isActive = true;
  public String title;
  
  void init() {}
  void update() {}
  
  void setActive(boolean active)
  {
    isActive = active;
  }
  
  layout getLayout()
  {
    return layout;
  }
  
  void addToTitle(String s)
  {
    title = s;
  }
  
  void addComponent(component c)
  {
    layout.addComponent(c);
  }
  
  void render()
  {
    layout.setActive(isActive);
    
    layout.updateComponent(x, y);
    layout.render();
  }
  
  void setLayout(layout newLayout)
  {
    if(newLayout != null)
    {
      layout = newLayout;
      
      w = layout.w;
      h = layout.h;
    }
  }
  
  void updateComponent(int x, int y)
  {
    this.x = x;
    this.y = y;
    layout.x = this.x;
    layout.y = this.y;
  }
}