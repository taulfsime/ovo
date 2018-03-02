class application
{
  layout layout = new layout(500, 500);;
  public int x;
  public int y;
  public int w;
  public int h;
  public boolean isActive = true;
  public String addToTitle = null;
  private applicationInfo appInfo;
  
  application(applicationInfo info)
  {
    appInfo = info;
  }
  
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
    addToTitle = s;
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
  
  applicationInfo getInfo() {return appInfo;}
  
  void updateComponent(int x, int y)
  {
    this.x = x;
    this.y = y;
    layout.x = this.x;
    layout.y = this.y;
  }
}

class applicationInfo
{
  private String systemName = null;
  private String author = null;
  private String version = null;
  private String description = null;
  private String title = null;
  private String iconDir = null;
  
  applicationInfo(String file)
  {
    JSONObject load = loadJSONObject(file);
    systemName = load.getString("systemName");
    author = load.getString("author");
    version = load.getString("version");
    description = load.getString("description");
    title = load.getString("title");
    iconDir = load.getString("icon");
  }
  
  String getSystemName() {return systemName;}
  String getAuthor() {return author;}
  String getVersion() {return version;}
  String getDescription() {return description;}
  String getTitle() {return title;}
  String getIconDir() {return iconDir;}
}