class fileBrowser extends application
{
  compList items;
  data data;
  layout main;
  button back;
  button next;
  textField address;
  button find;
  button newFile;
  button delFile;
  button pasteFile;
  windowGetInfo enterInfo;
  
  void init()
  {
    enterInfo = new windowGetInfo();
    
    main = new layout(600, 500);
    back = new button(10, 10, 30, 30, getImage("textures/button/tools/active/arrow_back.png"), getImage("textures/button/tools/unactive/arrow_back.png"));
    next = new button(45, 10, 30, 30, getImage("textures/button/tools/active/arrow_next.png"), getImage("textures/button/tools/unactive/arrow_next.png"));
    address = new textField(10, 45, 465, 30, "Address");
    find = new button(480, 45, 30, 30, getImage("textures/button/tools/active/search.png"), getImage("textures/button/tools/unactive/search.png"));
    newFile = new button(80, 10, 30, 30, getImage("textures/button/tools/active/folder_new.png"), getImage("textures/button/tools/unactive/folder_new.png"));
    delFile = new button(115, 10, 30, 30, getImage("textures/button/tools/active/folder_delete.png"), getImage("textures/button/tools/unactive/folder_delete.png"));
    pasteFile = new button(150, 10, 30, 30, getImage("textures/button/tools/active/folder_paste.png"), getImage("textures/button/tools/unactive/folder_paste.png"));
    
    items = new compList(10, 80, 500, 415);
    items.setMainDir("files");
        
    main.addComponent(items);
    main.addComponent(back);
    main.addComponent(next);
    main.addComponent(address);
    main.addComponent(find);
    main.addComponent(newFile);
    main.addComponent(delFile);
    main.addComponent(pasteFile);
    
    setLayout(main);
  }
  
  void update()
  {
    if(find.isClicked)
    {
      items.dir = address.getText();
    }
    else if(back.isClicked)
    {
      items.dir = items.getBackDir();
      address.setText(items.dir);
    }
    else if(next.isClicked)
    {
      items.addDir(items.items.get(items.getSelected()));
      address.setText(items.dir);
    }
    else if(newFile.isClicked)
    {
      system.openSubwindow(enterInfo);
    }
    
    /***************************ERROR*************************/

    back.setEnable(items.dir.length() > 0);
        
    if(items.items.size() > 0 && items.getSelectedName().length() > 0)
    {
      next.setEnable(checkStrings("folder", items.getFileType(items.getSelectedName())));
    }
    else
    {
      next.setEnable(false);
    }
  }
}

class compList extends component
{
  ArrayList<String> items = new ArrayList<String>();
  boolean useDir = true;
  String dir = "";
  String mainDir = "";
  int selected = 0;
  compList(int xPos, int yPos, int xLength, int yLength)
  {
    super(xPos, yPos, xLength, yLength);
  }
  
  void setDir(String dir)
  {
    if(items.size() > 0)
    {
      selected = 0;
    }
    else
    {
      selected = -1;
    }
    this.dir = dir;
  }
  
  void setMainDir(String s)
  {
    mainDir = s;
  }
  
  void addDir(String dir)
  {
    this.dir += ("/" + dir);
    if(items.size() > 0)
    {
      selected = 0;
    }
    else
    {
      selected = -1;
    }
  }
  
  String getBackDir()
  {
    boolean hasChar = false;
    int leng = 0;
    for(int a = dir.length() - 1; a > 0; a--)
    {
      if(dir.charAt(a) == '/')
      {
        hasChar = true;
        leng = a;
        break;
      }
    }
    
    if(hasChar)
    {
      return dir.substring(0, leng);
    }
    return "";
  }
  
  int getSelected()
  {
    return selected;
  }
  
  String getSelectedName()
  {
    if(items.size() > selected)
    {
      return items.get(selected);
    }
    return "";
  }
  
  String removeString(String text, String rText)
  {
    for(int a = 0; a < text.length() - rText.length(); a++)
    {
      if(checkStrings(rText, text.substring(a)))
      {
        return text.substring(0, a);
      }
    }
    
    return text;
  }
  
  void render()
  {
    noStroke();
    fill(border);
    rect(x + tx, y + ty, w, h);
    
    fill(normal);
    rect(x + tx + borderWidth, y + ty + borderWidth, w - borderWidth*2, h - borderWidth*2);
    
    if(useDir)
    {
      items.clear();
      for(String s : getFolderData(mainDir + dir))
      {
        items.add(s);
      }
    }
    
    for(int a = 0; a < items.size(); a++)
    {
      String type = getFileType(items.get(a));
      label icon = new label(x + tx + borderWidth*2 + 4, y + ty + borderWidth*2 + 4 + 41*a, 24, 24, getImage("textures/files/" + (type == "folder" ? (getFolderData("files/" + items.get(a)) != null ? "folder_full" : "folder_empty") : type) + ".png"));
      collisionBox cb = new collisionBox(x + tx + borderWidth + 2, y + ty + borderWidth + 2 + 41*a, w - borderWidth*2 - 4, 40);
      
      if(mouseClicked && cb.isOver() && isActive)
      {
        selected = a;
      }
      
      fill(border);
      rect(x + tx + borderWidth + 2, y + ty + borderWidth + 2 + 41*a, w - borderWidth*2 - 4, 40);
      
      if(a == selected)
      {
        fill(over);
      }
      else
      {
        fill(normal);
      }
      rect(x + tx + borderWidth*2 + 2, y + ty + borderWidth*2 + 2 + 41*a, w - borderWidth*4 - 4, 38);
      
      icon.updateComponent(x + tx + borderWidth*2 + 9, y + ty + borderWidth*2 + 9 + 41*a);
      icon.render();
      
      textSize(16);
      fill(0, 0, 0);
      text(getFileType(items.get(a)) == "folder" ? items.get(a) : (getFileName(items.get(a)) + "." + getFileType(items.get(a))), x + tx + borderWidth*2 + 2 + 40, y + ty + borderWidth*2 + 2 + 41*a + 22);
    }
  }
  
  void setItems(String[] s)
  {
    useDir = false;
    items.clear();
    for(String t : s)
    {
      items.add(t);
    }
  }
  
  String getFileName(String file)
  {
    for(int a = 0; a < file.length(); a++)
    {
      if(file.charAt(a) == '.')
      {
        return file.substring(0, a);
      }
    }
    
    return "";
  }
  
  String getFileType(String fileName)
  {
    if(fileName.length() > 0)
    {
      boolean hasChar = false;
      
      for(int a = 0; a < fileName.length(); a++)
      {
        if(fileName.charAt(a) == '.')
        {
          hasChar = true;
          break;
        }
      }
      
      if(hasChar)
      {
        switch(split(fileName, '.')[1])
        {
          case "json":
            return "app";
          
          default:
            return split(fileName, '.')[1];
        }
      }
      return "folder";
    }
    return null;
  }
}