class painter extends application
{
  dataReader data = new dataReader();
  
  picture pic;
  
  //Tools
  String tool = "";
  boolean drawing;
  boolean saved = false;
  
  /* DRAWINNG */
  layout drawingTools;
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
  
  /* CREATE PICTURE */
  layout createPicture;
  
  button create;
  button load;
  textField enterName;
  
  /* SAVING */
  layout saving;
  button saveIt;
  button dSaveIt;
  label textSave;
  
  void init()
  {
    drawing = false;
    
    /* DRAWING */
    draw = new layout(576, 501);
    drawingTools = new layout(87, 400);
    canvas = new canvas(0, 0, 500, 500);
    toolPencil = new button(510, 10, 25, 25, data.getImage("textures/painter/tools/pencil.png"));
    toolEraser = new button(540, 10, 25, 25, data.getImage("textures/painter/tools/eraser.png"));
    toolBucket = new button(510, 40, 25, 25, data.getImage("textures/painter/tools/bucket.png"));
    saveFile = new button(510, 70, 25, 25, data.getImage("textures/painter/tools/saveFile.png"));
    newFile = new button(540, 70, 25, 25, data.getImage("textures/painter/tools/newFile.png"));
    
    sliderRed = new slider(504, 100, 68, 25, data.getImage("textures/painter/tools/redSlider.png"));
    sliderGreen = new slider(504, 130, 68, 25, data.getImage("textures/painter/tools/greenSlider.png"));
    sliderBlue = new slider(504, 160, 68, 25, data.getImage("textures/painter/tools/blueSlider.png"));
    
    //first line
    colors[0] = new button(506, 190, 15, 15, "");
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
        
    //add Components
    drawingTools.addComponent(toolPencil);
    drawingTools.addComponent(newFile);
    drawingTools.addComponent(saveFile);
    drawingTools.addComponent(sliderRed);
    drawingTools.addComponent(sliderGreen);
    drawingTools.addComponent(sliderBlue);
    drawingTools.addComponent(toolEraser);
    drawingTools.addComponent(toolBucket);
    
    for(int a = 0; a < colors.length; a++)
    {
      drawingTools.addComponent(colors[a]);
    }
    
    draw.addComponent(drawingTools);
    draw.addComponent(canvas);
    
    /* CREATE PICTURE */
    createPicture = new layout(250, 100);
    create = new button(150, 60, 90, 30, "Create new");
    load = new button(85, 60, 60, 30, "Load");
    enterName = new textField(10, 10, 230, 30, "Name");
    
    createPicture.addComponent(create);
    createPicture.addComponent(load);
    createPicture.addComponent(enterName);
    
    /* SAVING */
    saving = new layout(250, 100);
    saveIt = new button(150, 60, 90, 30, "Yes!");
    dSaveIt = new button(85, 60, 60, 30, "No!");
    textSave = new label(10, 10, 230, 30, "Do you want to save it?");
    
    saving.addComponent(saveIt);
    saving.addComponent(dSaveIt);
    saving.addComponent(textSave);
  }
  
  void update()
  {
    if(drawing)
    {
      if(saved)
      {
        setLayout(saving);
        saving();
      }
      else
      {
        setLayout(draw);
        drawing();
      }
    }
    else
    {
      setLayout(createPicture);
      createPicture();
    }
  } //<>//
  
  void saving()
  {
    if(saveIt.isClicked)
    {
      saved = false;
      pic.save(canvas.getPixel());
      
      canvas.empty();
    }
    else if(dSaveIt.isClicked)
    {
      saved = false;
      
      canvas.empty();
    }
  }
  
  void createPicture()
  {    
    if(create.isClicked)
    {
      drawing = true;
    }
    else if(load.isClicked)
    {
      pic = new picture(enterName.getText());
      canvas.pixel = pic.read();
      drawing = true;
    }
    
    if(enterName.getText() == "")
    {
      create.setWorking(false);
      load.setWorking(false);
    }
    else
    {
      create.setWorking(true);
      load.setWorking(true);
    }
  }
  
  void drawing()
  {
    drawColor = color(sliderRed.getPercentage()*255, sliderGreen.getPercentage()*255, sliderBlue.getPercentage()*255);
    
    if(colors[0].isClicked)
    {
      drawColor = color(255, 255, 255);
    }
    else if(colors[1].isClicked)
    {
      drawColor = color(165, 165, 165);
    }
    else if(colors[2].isClicked)
    {
      drawColor = color(255, 0, 0);
    }
    else if(colors[3].isClicked)
    {
      drawColor = color(255, 153, 0);
    }
    else if(colors[4].isClicked)
    {
      drawColor = color(165, 165, 165);
    }
    else if(toolPencil.isClicked)
    {
      tool = "pencil";
    }
    else if(toolEraser.isClicked)
    {
      tool = "eraser";
    }
    else if(newFile.isClicked)
    {
      saved = true;
    }
    else if(toolBucket.isClicked)
    {
      tool = "bucket";
    }
    else if(saveFile.isClicked)
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
            saved = false;
          }
        }
        break;
        
        case "eraser":
        {
          if(mousePressed)
          {
            canvas.setPixel(dx, dy, canvas.getBackground());
            saved = false;
          }
        }
        break;
        
        case "bucket":
        {
          if(mouseClicked)
          {
            bucketFill(dx, dy, canvas.getPixel(dx, dy), drawColor);
            saved = false;
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
    pixel[y*row + x] = c;
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