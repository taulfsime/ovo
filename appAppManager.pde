class appManager extends application
{
  appManager() {super(new applicationInfo("data/apps/appManager.json"));}
  
  String[] appList;
  /* MAIN */
  layout main;
  compList items;
  button view;
  textField searchBar;
  button search;
  
  /* SHOW APPS */
  image wallpaper;
  layout showApp;
  button back;
  button getApp;
  image icon;
  label name;
  label version;
  
  void init()
  { 
    /* MAIN */
    main = new layout(600, 510);
    items = new compList(10, 45, 500, 415);
    view = new button(10, 470, 100, 30, "View");
    searchBar = new textField(10, 10, 465, 30, "Search Bar");
    search = new button(480, 10, 30, 30, getImage("textures/button/tools/active/search.png"), getImage("textures/button/tools/unactive/search.png"));
    
    search.bindKey(ENTER);
    appList = getFolderData("apps");
    main.addComponent(items);
    main.addComponent(searchBar);
    main.addComponent(search);
    main.addComponent(view);
    
    /* SHOW APP INFO */
    showApp = main.get();
    back = new button(10, 10, 30, 30, getImage("textures/button/tools/active/arrow_back.png"), getImage("textures/button/tools/unactive/arrow_back.png"));
    icon = new image(50, 50, 70, 70, getImage(getIcon(appList[items.getSelected()])));
    name = new label(130, 60, 150, 40, "");
    version = new label(130, 105, 150, 40, "");
    wallpaper = new image(0, 0, 598, 200, getImage("textures/app/appManager/wallpaper.png"));
    
    showApp.addComponent(wallpaper);
    showApp.addComponent(back);
    showApp.addComponent(icon);
    showApp.addComponent(name);
    showApp.addComponent(version);
    
    for(String s : appList)
    {
      items.addItem(getName(s), getIcon(s) == null ? getImage("textures/files/app.png") : getImage(getIcon(s)));
    }
    
    setLayout(main);
  }
  
  void mainLayout()
  {
    if(search.isClicked())
    {
      items.clear();
      for(String s : appList)
      {
        for(int a = 0; a < getName(s).length() - searchBar.getText().length(); a++)
        {
          if(checkStrings(searchBar.getText().toLowerCase(), getName(s).substring(a, a + searchBar.getText().length()).toLowerCase()))
          {
            items.addItem(getName(s), getIcon(s) == null ? getImage("textures/files/app.png") : getImage(getIcon(s)));
            break;
          }
        }
      }
    }
    else if(view.isClicked())
    {
      String file = null;
      
      for(String s : appList)
      {
        if(checkStrings(getName(s), items.getSelectedName()))
        {
          file = s;
          break;
        }
      }
      
      if(file != null)
      {
        icon.setImage(getImage(getIcon(file)));
        name.setText(getName(file));
        version.setText(getVersion(file));
      }
      
      setLayout(showApp);
    }
  }
  
  void showAppLayout()
  {
    if(back.isClicked())
    {
      setLayout(main);
    }
  }
  
  void update()
  {
    if(getLayout() == main)
    {
      mainLayout();
    }
    else if(getLayout() == showApp)
    {
      showAppLayout();
    }
  }
  
  String getName(String file)
  {
    return loadJSONObject("data/apps/" + file).getString("title");
  }
  
  String getSystemName(String file)
  {
    return loadJSONObject("data/apps/" + file).getString("systemName");
  }
  
  String getVersion(String file)
  {
    return loadJSONObject("data/apps/" + file).getString("version");
  }
  
  String getDescription(String file)
  {
    return loadJSONObject("data/apps/" + file).getString("description");
  }
  
  String getAuthor(String file)
  {
    return loadJSONObject("data/apps/" + file).getString("author");
  }
  
  String getFile(String file)
  {
    return loadJSONObject("data/apps/" + file).getString("file");
  }
  
  String getIcon(String file)
  {
    return loadJSONObject("data/apps/" + file).getString("icon");
  }
}

//String[] info = new String[5];
    
    //if(items.getSelectedName().length() > 0)
    //{
    //  load = loadJSONArray("data/apps/" + items.getSelectedName());
    //  JSONObject obj = load.getJSONObject(0);
    //  //showInfo.setInfo(obj.getString("systemName"), obj.getString("appFile"), obj.getString("author"), obj.getString("version"), obj.getString("description"));
    //}