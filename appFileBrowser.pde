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
      println(enterInfo.getInfo());
    }
    
    /***************************ERROR*************************/

    back.setEnable(items.dir.length() > 0);
        
    if(items.items.size() > 0 && items.getSelectedName().length() > 0)
    {
      next.setEnable(isFolder(items.getSelectedName()));
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
  ArrayList<PImage> icons = new ArrayList<PImage>();
  int vLines;
  scrollBar scroll;
  boolean useDir = true;
  String dir = "";
  String mainDir = "";
  int selected = 0;
  compList(int xPos, int yPos, int xLength, int yLength)
  {
    super(xPos, yPos, xLength, yLength);
    vLines = h/40;
    scroll = new scrollBar(w - 17, 5, 15, vLines*40 - 10);
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
  
  PImage getSelectedIcon()
  {
    if(icons.size() > selected)
    {
      return icons.get(selected);
    }
    
    return null;
  }
  
  void render()
  {
    noStroke();
    fill(border);
    rect(x + tx, y + ty, w, vLines*41 + borderWidth*4);
    
    fill(normal);
    rect(x + tx + borderWidth, y + ty + borderWidth, w - borderWidth*2, (vLines*41) + borderWidth*2);
    
    if(items.size() > vLines)
    {
      scroll.translate(x + tx, y + ty);
      scroll.setScrollSize(vLines, items.size());
      scroll.render();
    }
    
    if(useDir)
    {
      items.clear();
      icons.clear();
      for(String s : getFolderData(mainDir + dir))
      {
        boolean hasChar = false;
        
        for(int a = 0; a < s.length(); a++)
        {
          if(s.charAt(a) == '.')
          {
            hasChar = true;
            icons.add(getImage("textures/files/" + s.substring(a + 1) + ".png"));
            break;
          }
        }
        
        if(!hasChar)
        {
          icons.add(getImage("textures/files/folder_empty.png"));
        }
        
        items.add(s);
      }
    }
    
    int start = items.size() > vLines ? (int) (scroll.getPer()*(items.size() - vLines)) : 0;
    int finish = items.size() > vLines ? (start + vLines < items.size() ? start + vLines : items.size()) : items.size();
    for(int a = start; a < finish; a++)
    {
      label icon = new label(x + tx + borderWidth*2 + 4, y + ty + borderWidth*2 + 4 + 41*(a - start), 24, 24, icons.get(a));
      collisionBox cb = new collisionBox(x + tx + borderWidth + 2, y + ty + borderWidth + 2 + 41*(a - start), items.size() > vLines ? w - borderWidth*2 - 22 : w - borderWidth*2 - 4, 40);
      
      if(mouseClicked && cb.isOver() && isActive)
      {
        if(items.size() > vLines)
        {
          if(!scroll.cb.isOver())
          {
            selected = a;
          }
        }
        else
        {
          selected = a;
        }
      }
      
      fill(border);
      rect(x + tx + borderWidth + 2, y + ty + borderWidth + 2 + 41*(a - start), items.size() > vLines ? w - borderWidth*2 - 22 : w - borderWidth*2 - 4, 40);
      
      if(a == selected)
      {
        fill(over);
      }
      else
      {
        fill(normal);
      }
      rect(x + tx + borderWidth*2 + 2, y + ty + borderWidth*2 + 2 + 41*(a - start), items.size() > vLines ? w - borderWidth*4 - 22 : w - borderWidth*4 - 4, 38);
      
      icon.updateComponent(x + tx + borderWidth*2 + 9, y + ty + borderWidth*2 + 9 + 41*(a - start));
      icon.render();
      
      textSize(16);
      fill(0, 0, 0);
      text(items.get(a), x + tx + borderWidth*2 + 2 + 40, y + ty + borderWidth*2 + 2 + 41*(a - start) + 22);
    }
  }
  
  void addItem(String s, PImage i)
  {
    useDir = false;
    
    items.add(s);
    icons.add(i);
  }
  
  void clear()
  {
    items.clear();
    icons.clear();
  }
  
  void setItems(String[] s, PImage[] i)
  {
    if(s.length > 0 && i.length > 0)
    {
      useDir = false;
      
      items.clear();
      icons.clear();
      
      for(String t : s)
      {
        items.add(t);
      }
      
      for(PImage t : i)
      {
        icons.add(t);
      }
    }
  }
  
  void setItems(String[] s, PImage i)
  {
    if(s.length > 0)
    {
      useDir = false;
      
      items.clear();
      icons.clear();
      
      for(String t : s)
      {
        items.add(t);
        icons.add(i);
      }
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
}