class painter extends application
{
  painter() {super(new applicationInfo("data/apps/painter.json"));}
  
  picture pic;
  
  //Tools
  String tool = "";
  
  /* DRAWINNG */
  layout draw;
  
  button toolPencil;
  button toolEraser;
  button toolBucket;
  button newFile;
  button saveFile;
  slider sliderRed;
  slider sliderGreen;
  slider sliderBlue;
  button[] colors = new button[20];
  color drawColor = color(0, 0, 0);
  canvas canvas;
  showColor sc;
  
  /* CREATE PICTURE */
  layout createPicture;
  
  button create;
  button load;
  textField enterName;
  button customLoad;
  
  /* SAVING */
  layout saving;
  button saveIt;
  button dSaveIt;
  label textSave;
  
  void init()
  {
    /* DRAWING */
    draw = new layout(576, 501);
    canvas = new canvas(0, 0, 500, 500);
    toolPencil = new button(510, 10, 25, 25, getImage("textures/painter/tools/pencil.png"));
    toolEraser = new button(540, 10, 25, 25, getImage("textures/painter/tools/eraser.png"));
    toolBucket = new button(510, 40, 25, 25, getImage("textures/painter/tools/bucket.png"));
    saveFile = new button(510, 70, 25, 25, getImage("textures/button/tools/active/save_file.png"));
    newFile = new button(540, 70, 25, 25, getImage("textures/button/tools/active/new_file.png"));
    
    sliderRed = new slider(504, 100, 68, 25, getImage("textures/painter/tools/redSlider.png"));
    sliderGreen = new slider(504, 130, 68, 25, getImage("textures/painter/tools/greenSlider.png"));
    sliderBlue = new slider(504, 160, 68, 25, getImage("textures/painter/tools/blueSlider.png"));
    
    //first line
    colors[0] = new button(506, 190, 15, 15, createPImage(color(0, 0, 0), 15, 15), createPImage(color(10, 0, 0), 15, 15), createPImage(color(20, 0, 0), 15, 15));
    colors[1] = new button(523, 190, 15, 15, "");
    colors[2] = new button(540, 190, 15, 15, "");
    colors[3] = new button(557, 190, 15, 15, "");
   
    //second line
    colors[4] = new button(506, 207, 15, 15, "");
    colors[5] = new button(523, 207, 15, 15, "");
    colors[6] = new button(540, 207, 15, 15, "");
    colors[7] = new button(557, 207, 15, 15, "");
    
    //third line
    colors[8] = new button(506, 224, 15, 15, "");
    colors[9] = new button(523, 224, 15, 15, "");
    colors[10] = new button(540, 224, 15, 15, "");
    colors[11] = new button(557, 224, 15, 15, "");
    
    sc = new showColor(504, 245, 68, 25, drawColor);
            
    //add Components
    draw.addComponent(toolPencil);
    draw.addComponent(newFile);
    draw.addComponent(saveFile);
    draw.addComponent(sliderRed);
    draw.addComponent(sliderGreen);
    draw.addComponent(sliderBlue);
    draw.addComponent(toolEraser);
    draw.addComponent(toolBucket);
    draw.addComponent(sc);
    
    for(int a = 0; a < colors.length; a++)
    {
      draw.addComponent(colors[a]);
    }
    
    draw.addComponent(canvas);
    
    /* CREATE PICTURE */
    createPicture = new layout(250, 100);
    create = new button(150, 60, 90, 30, "Create new");
    load = new button(85, 60, 60, 30, "Load");
    customLoad = new button(10, 60, 60, 30, "CLoad");
    enterName = new textField(10, 10, 230, 30, "Name");
    
    createPicture.addComponent(create);
    createPicture.addComponent(load);
    createPicture.addComponent(enterName);
    createPicture.addComponent(customLoad);
    
    /* SAVING */
    saving = new layout(250, 100);
    saveIt = new button(150, 60, 90, 30, "Yes!");
    dSaveIt = new button(85, 60, 60, 30, "No!");
    textSave = new label(10, 10, 230, 30, "Do you want to save it?");
    
    saving.addComponent(saveIt);
    saving.addComponent(dSaveIt);
    saving.addComponent(textSave);
    
    setLayout(createPicture);
  }
  
  void update()
  {
    if(getLayout() == draw)
    {
      drawing();
    }
    else if(getLayout() == saving)
    {
      saving();
    }
    else if(getLayout() == createPicture)
    {
      createPicture();
    }
  }
  
  void saving()
  {
    if(saveIt.isClicked())
    {
      pic.save(canvas.getPixel());
      setLayout(draw);
      canvas.empty();
    }
    else if(dSaveIt.isClicked())
    {
      setLayout(draw);
      canvas.empty();
    }
  }
  
  void createPicture()
  {
    if(create.isClicked())
    {
      setLayout(draw);
    }
    else if(load.isClicked())
    {
      pic = new picture(enterName.getText());
      if(pic.load() != null)
      {
        canvas.pixel = pic.load();
      }
      setLayout(draw);
    }
    else if(customLoad.isClicked())
    {
      pic = new picture(split(enterName.getText(), '.')[0]);
      canvas.pixel = pic.customLoad(enterName.getText());
      setLayout(draw);
    }
    
    if(enterName.getText() == "")
    {
      create.setEnable(false);
      load.setEnable(false);
    }
    else
    {
      create.setEnable(true);
      load.setEnable(true);
    }
  }
  
  void drawing()
  {
    drawColor = color(sliderRed.getPercentage()*255, sliderGreen.getPercentage()*255, sliderBlue.getPercentage()*255);
    sc.setColor(drawColor);
    if(colors[0].isClicked())
    {
      drawColor = color(255, 255, 255);
    }
    else if(colors[1].isClicked())
    {
      drawColor = color(165, 165, 165);
    }
    else if(colors[2].isClicked())
    {
      drawColor = color(255, 0, 0);
    }
    else if(colors[3].isClicked())
    {
      drawColor = color(255, 153, 0);
    }
    else if(colors[4].isClicked())
    {
      drawColor = color(165, 165, 165);
    }
    else if(toolPencil.isClicked())
    {
      tool = "pencil";
    }
    else if(toolEraser.isClicked())
    {
      tool = "eraser";
    }
    else if(newFile.isClicked())
    {
      setLayout(saving);
    }
    else if(toolBucket.isClicked())
    {
      tool = "bucket";
    }
    else if(saveFile.isClicked())
    {
      picture p = new picture(enterName.getText());
      p.save(canvas.getPixel());
    }
    
    if(mouseX >= x && mouseX <= x + 500 && mouseY >= y && mouseY <= y + 500)
    {
      int dx = (mouseX - x)/5;
      int dy = (mouseY - y)/5;
      
      switch(tool)
      {
        case "pencil":
        {
          if(mousePressed)
          {
            canvas.setPixel(dx, dy, drawColor);
          }
        }
        break;
        
        case "eraser":
        {
          if(mousePressed)
          {
            canvas.setPixel(dx, dy, canvas.getBackground());
          }
        }
        break;
        
        case "bucket":
        {
          if(mouseClicked)
          {
            bucketFill(dx, dy, canvas.getPixel(dx, dy), drawColor);
          }
        }
        break;
      }
    }
  }
  
  void bucketFill(int x, int y, color prevColor, color newColor)
  {
    if(x < 0 || y < 0 || x >= canvas.row || y >= canvas.col || canvas.getPixel(x, y) != prevColor)
    {
      return;
    }
    
    canvas.setPixel(x, y, newColor);
    
    bucketFill(x + 1, y, prevColor, newColor);
    bucketFill(x - 1, y, prevColor, newColor);
    bucketFill(x, y + 1, prevColor, newColor);
    bucketFill(x, y - 1, prevColor, newColor);
  }
}

class showColor extends component
{
  color c;
  boolean isActive = true;
  showColor(int xPos, int yPos, int xLenght, int yLength, color c)
  {
    super(xPos, yPos, xLenght, yLength);
    this.c = c;
  }
  
  void setActive(boolean active)
  {
    this.isActive = active;
  }
  
  void setColor(color c)
  {
    if(this.c != c)
    {
      this.c = c;
    }
  }
  
  void render()
  {
    fill(border);
    rect(x + tx, y + ty, w, h);
    
    fill(c);
    rect(x + tx + borderWidth, y + ty + borderWidth, w - borderWidth*2, h - borderWidth*2);
  }
}

class canvas extends component
{
  int col = 100;
  int row = 100;
  color[] pixel = new color[row*col];
  
  color background = color(255, 255, 255);
  
  canvas(int xPos, int yPos, int xLength, int yLength) 
  {
    super(xPos, yPos, xLength, yLength);
    for(int dx = 0; dx < 100; dx++)
    {
      for(int dy = 0; dy < 100; dy++)
      {
        pixel[dy*row + dx] = background;
      }
    }
  }
  
  void fillBackground(color newColor)
  {
    for(int dx = 0; dx < 100; dx++)
    {
      for(int dy = 0; dy < 100; dy++)
      {
        if(pixel[dy*row + dx] == background)
        {
          pixel[dy*row + dx] = newColor;
        }
      }
    }
  }
  
  void setBackground(color c)
  {
    background = c;
    
    fillBackground(c);
  }
  
  color getBackground()
  {
    return background;
  }
  
  color getPixel(int x, int y)
  {
    return pixel[y*row + x];
  }
  
  color[] getPixel()
  {
    return pixel;
  }
  
  void setPixel(int x, int y, color c)
  {
    int p = y*row + x;
    
    if(isActive && p < col*row) 
    {
      pixel[p] = c;
    }
  }
  
  void empty()
  {
    for(int dx = 0; dx < 100; dx++)
    {
      for(int dy = 0; dy < 100; dy++)
      {
        pixel[dy*row + dx] = background;
      }
    }
  }
  
  void render()
  {
    for(int dx = 1; dx <= 500; dx += 5)
    {
      for(int dy = 1; dy <= 500; dy += 5)
      {
        fill(pixel[(dx/5) + (dy/5)*row]);
        rect(x + dx + tx, y + dy + ty, 5, 5);
      }
    }
  }
}