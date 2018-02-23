class fileBrowser extends application
{
  data data;
  layout main;
  compFileBrowser fb;
  button back;
  button next;
  textField address;
  button find;
  
  void init()
  {
    main = new layout(600, 500);
    fb = new compFileBrowser(10, 80, 500, 415);
    back = new button(10, 10, 30, 30, "<");
    next = new button(45, 10, 30, 30, ">");
    address = new textField(10, 45, 465, 30, "Address");
    find = new button(480, 45, 30, 30, "?");
        
    main.addComponent(fb);
    main.addComponent(back);
    main.addComponent(next);
    main.addComponent(address);
    main.addComponent(find);
    
    address.setText(fb.dir);
    
    setLayout(main);
  }
  
  void update()
  {
    if(find.isClicked)
    {
      //fb.setDir(address.getText());
    }
  }
}

class compFileBrowser extends component
{
  ArrayList<String> items = new ArrayList<String>();
  String dir = "files/pictures";
  compFileBrowser(int xPos, int yPos, int xLength, int yLength)
  {
    super(xPos, yPos, xLength, yLength);
  }
  
  void setDir(String dir)
  {
    this.dir = dir;
  }
  
  void render()
  {
    noStroke();
    fill(border);
    rect(x + tx, y + ty, w, h);
    
    fill(normal);
    rect(x + tx + borderWidth, y + ty + borderWidth, w - borderWidth*2, h - borderWidth*2);
    
    items.clear();
    for(String s : getFolderData(dir))
    {
      items.add(s);
    }
    
    for(int a = 0; a < items.size(); a++)
    {
      label icon = new label(x + tx + borderWidth*2 + 4, y + ty + borderWidth*2 + 4 + 41*a, 24, 24, getImage("textures/files/" + getFileType(items.get(a)) + ".png"));
      
      fill(border);
      rect(x + tx + borderWidth + 2, y + ty + borderWidth + 2 + 41*a, w - borderWidth*2 - 4, 40);
      
      fill(normal);
      rect(x + tx + borderWidth*2 + 2, y + ty + borderWidth*2 + 2 + 41*a, w - borderWidth*4 - 4, 38);
      
      icon.updateComponent(x + tx + borderWidth*2 + 9, y + ty + borderWidth*2 + 9 + 41*a);
      icon.render();
      
      textSize(16);
      fill(0, 0, 0);
      text(items.get(a), x + tx + borderWidth*2 + 2 + 40, y + ty + borderWidth*2 + 2 + 41*a + 22);
    }
  }
  
  String getFileType(String fileName)
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
      return split(fileName, '.')[1];
    }
    return null;
  }
}