class appManager extends application
{
  layout main;
  compList items;
  JSONArray load;
  String[] appList;
  ArrayList<String> apps = new ArrayList<String>();
  button view;
  textField searchBar;
  button search;
  
  layout showApp;
  
  void init()
  {
    main = new layout(600, 510);
    items = new compList(10, 50, 500, 415);
    appList = getFolderData("apps");
    view = new button(10, 470, 100, 30, "View");
    searchBar = new textField(10, 10, 460, 30, "Search Bar");
    search = new button(480, 10, 30, 30, getImage("textures/button/tools/active/search.png"), getImage("textures/button/tools/unactive/search.png"));
    
    items.setItems(appList);
    
    main.addComponent(items);
    main.addComponent(searchBar);
    main.addComponent(search);
    main.addComponent(view);
    
    showApp = new layout(600, 500);
    setLayout(main);
  }
  
  void update()
  {
    if(search.isClicked)
    {
      apps.clear();
      for(String s : appList)
      {
        if(checkStrings(searchBar.getText(), s.substring(0, searchBar.getText().length())))
        {
          apps.add(s);
        }
      }
      String[] newApps = new String[apps.size()];
      for(int a = 0; a < apps.size(); a++)
      {
        newApps[a] = apps.get(a);
      }
      items.setItems(newApps);
    }
    
    //String[] info = new String[5];
    
    //if(items.getSelectedName().length() > 0)
    //{
    //  load = loadJSONArray("data/apps/" + items.getSelectedName());
    //  JSONObject obj = load.getJSONObject(0);
    //  //showInfo.setInfo(obj.getString("systemName"), obj.getString("appFile"), obj.getString("author"), obj.getString("version"), obj.getString("description"));
    //}
  }
}