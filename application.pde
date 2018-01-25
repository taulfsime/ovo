class application
{
  layout layout;
  public int x;
  public int y;
  public int w;
  public int h;
  
  void init() {}
  void preinit() {}
  
  void render()
  {
    layout.updateComponent(x, y, w, h);
    layout.render(); //<>// //<>// //<>//
  }
  
  void setLayout(layout newLayout)
  {
    if(newLayout != null)
    {
      layout = newLayout;
    }
  }
  
  layout getLayout()
  {
    return layout;
  }
  
  void updateComponent(int x, int y)
  {
    this.x = x;
    this.y = y;
    layout = new layout(x, y, w, h);
  }
  
  void updateComponent(int x, int y, int w, int h)
  {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    layout = new layout(x, y, w, h);
  }
}