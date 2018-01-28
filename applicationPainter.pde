class painter extends application
{
  dataReader data = new dataReader();
  
  //Tools
  String tool = "";
  boolean drawing = false;
  
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
  image[] images = new image[20];
  
  color drawColor = color(0, 0, 0);
  canvas canvas;
  
  /* CREATE PICTURE */
  layout createPicture;
  
  button create;
  button load;
  textField enterName;
  textField enterAuthor;
  
  void init()
  {
    /* DRAWING */
    drawingTools = new layout(87, 400);
    draw = new layout(588, 528);
    canvas = new canvas(x, y, 500, 500);
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
    drawingTools.addComponent(colors[0]);
    drawingTools.addComponent(colors[1]);
    drawingTools.addComponent(colors[2]);
    drawingTools.addComponent(colors[3]);
    drawingTools.addComponent(colors[4]);
    drawingTools.addComponent(colors[5]);
    drawingTools.addComponent(colors[6]);
    drawingTools.addComponent(colors[7]);
    drawingTools.addComponent(colors[8]);
    drawingTools.addComponent(colors[9]);
    drawingTools.addComponent(colors[10]);
    drawingTools.addComponent(colors[11]);
    
    draw.addComponent(drawingTools);
    draw.addComponent(canvas);
    
    /* CREATE PICTURE */
    createPicture = new layout(300, 200);
    create = new button(185, 130, 90, 30, "Create new");
    load = new button(120, 130, 60, 30, "Load");
    enterName = new textField(10, 20, 150, 30, "Name");
    enterAuthor = new textField(10, 55, 150, 30, "Author");
    
    createPicture.addComponent(create);
    createPicture.addComponent(load);
    createPicture.addComponent(enterName);
    createPicture.addComponent(enterAuthor);
  }
  
  void update()
  {
    if(drawing)
    {
      setLayout(draw);
      drawing();
    }
    else
    {
      setLayout(createPicture);
      createPicture();
    }
  } //<>//
  
  void createPicture()
  {
    create.setActive(false);
    
    if(create.isClicked)
    {
      drawing = true;
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
      canvas.setBackground(color(255, 255, 255));
      /*
      * TODO: Add suport for change a background color!!
      */
    }
    else if(toolBucket.isClicked)
    {
      tool = "bucket";
    }
    
    if(mouseX >= x && mouseX <= x + 500 && mouseY >= y && mouseY <= y + 500)
    {
      int dx = (mouseX - x)/5;
      int dy = (mouseY - y)/5;
      
      switch(tool)
      {
        case "pencil":
          if(mousePressed)
          {
            canvas.setPixel(dx, dy, drawColor);
          }
        break;
        
        case "eraser":
          if(mousePressed)
          {
            canvas.setPixel(dx, dy, canvas.getBackground());
          }
        break;
        
        case "bucket":
        
        break;
      }
    }
  }
}

class canvas extends component
{
  color[][] pixel = new color[100][100];
  
  color background = color(255, 255, 255);
  
  canvas(int xPos, int yPos, int xLength, int yLength) 
  {
    super(xPos, yPos, xLength, yLength);
    fillBackground();
  }
  
  void fillBackground()
  {
    for(int dx = 0; dx < 100; dx++)
    {
      for(int dy = 0; dy < 100; dy++)
      {
        pixel[dx][dy] = background;
      }
    }
  }
  
  void setBackground(color c)
  {
    background = c;
    
    fillBackground();
  }
  
  color getBackground()
  {
    return background;
  }
  
  color getPixel(int x, int y)
  {
    return pixel[x][y];
  }
  
  void setPixel(int x, int y, color c)
  {
    pixel[x][y] = c;
  }
  
  void loadPicture(picture p)
  {
    pixel = p.getPicture();
  }
  
  void render()
  {
    //println(x + tx, y + ty);
    
    for(int dx = 1; dx <= 500; dx += 5)
    {
      for(int dy = 1; dy <= 500; dy += 5)
      {
        fill(pixel[dx/5][dy/5]);
        rect(x + dx + tx, y + dy + ty, 5, 5);
      }
    }
  }
}