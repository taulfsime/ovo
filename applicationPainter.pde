class painter extends application
{
  //Tools
  String tool = "pencil";
  
  layout tools;
  data data;
    
  button toolPencil;
  button toolEraser;
  button toolBucket;
  button newFile;
  button saveFile;
  slider sliderRed;
  slider sliderGreen;
  slider sliderBlue;
  button[] colors = new button[20];
  
  float red = 0, green = 0, blue = 0;
  canvas canvas;
  
  void preinit()
  {
    data = new data();
    tools = new layout(501, y, w - 501, h - 128);
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
    colors[0] = new button(506, 190, 15, 15, data.getImage("textures/painter/colors/black.png"), data.getImage("textures/painter/colors/black.png"), data.getImage("textures/painter/colors/black.png"));
    colors[1] = new button(523, 190, 15, 15, data.getImage("textures/painter/colors/gray.png"), data.getImage("textures/painter/colors/gray.png"), data.getImage("textures/painter/colors/gray.png"));
    colors[2] = new button(540, 190, 15, 15, data.getImage("textures/painter/colors/red.png"), data.getImage("textures/painter/colors/red.png"), data.getImage("textures/painter/colors/red.png"));
    colors[3] = new button(557, 190, 15, 15, data.getImage("textures/painter/colors/orange.png"), data.getImage("textures/painter/colors/orange.png"), data.getImage("textures/painter/colors/orange.png"));
   
    //second line
    colors[4] = new button(506, 207, 15, 15, data.getImage("textures/painter/colors/yellow.png"), data.getImage("textures/painter/colors/yellow.png"), data.getImage("textures/painter/colors/yellow.png"));
    colors[5] = new button(523, 207, 15, 15, data.getImage("textures/painter/colors/green.png"), data.getImage("textures/painter/colors/green.png"), data.getImage("textures/painter/colors/green.png"));
    colors[6] = new button(540, 207, 15, 15, data.getImage("textures/painter/colors/light_blue.png"), data.getImage("textures/painter/colors/light_blue.png"), data.getImage("textures/painter/colors/light_blue.png"));
    colors[7] = new button(557, 207, 15, 15, data.getImage("textures/painter/colors/dark_blue.png"), data.getImage("textures/painter/colors/dark_blue.png"), data.getImage("textures/painter/colors/dark_blue.png"));
    
    //third line
    colors[8] = new button(506, 224, 15, 15, "");
    colors[9] = new button(523, 224, 15, 15, "");
    colors[10] = new button(540, 224, 15, 15, "");
    colors[11] = new button(557, 224, 15, 15, "");
        
    tools.addComponent(toolPencil);
    tools.addComponent(newFile);
    tools.addComponent(saveFile);
    tools.addComponent(sliderRed);
    tools.addComponent(sliderGreen);
    tools.addComponent(sliderBlue);
    tools.addComponent(toolEraser);
    tools.addComponent(toolBucket);
    tools.addComponent(colors[0]);
    tools.addComponent(colors[1]);
    tools.addComponent(colors[2]);
    tools.addComponent(colors[3]);
    tools.addComponent(colors[4]);
    tools.addComponent(colors[5]);
    tools.addComponent(colors[6]);
    tools.addComponent(colors[7]);
    tools.addComponent(colors[8]);
    tools.addComponent(colors[9]);
    tools.addComponent(colors[10]);
    tools.addComponent(colors[11]);
  }
  
  void init()
  {
    setLayout(tools);
    
    red = sliderRed.getPercentage()*255;
    green = sliderGreen.getPercentage()*255;
    blue = sliderBlue.getPercentage()*255;
    if(colors[0].isClicked)
    {
      red = 255;
      green = 255;
      blue = 255;
    }
    else if(colors[1].isClicked)
    {
      red = 165;
      green = 165;
      blue = 165;
    }
    else if(colors[2].isClicked)
    {
      red = 255;
      green = 0;
      blue = 0;
    }
    else if(colors[3].isClicked)
    {
      red = 255;
      green = 153;
      blue = 0;
    }
    else if(colors[4].isClicked)
    {
      red = 165;
      green = 165;
      blue = 165;
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
      canvas.setBackground(255, 255, 255);
    }
    else if(toolBucket.isClicked)
    {
      tool = "bucket";
    }
    
    canvas.updatePos(x, y, 500, 500);
    canvas.render();
        
    if(mouseX >= x && mouseX <= x + 500 && mouseY >= y && mouseY <= y + 500)
    {
      int dx = (mouseX - x)/5;
      int dy = (mouseY - y)/5;
      
      if(tool == "pencil")
      {
        if(mousePressed)
        {
          canvas.setPixel(dx, dy, red, green, blue);
        }
      }
      else if(tool == "eraser")
      {
        if(mousePressed)
        {
          canvas.setPixel(dx, dy, canvas.getBackground("red"), canvas.getBackground("green"), canvas.getBackground("blue"));
        }
      }
      else if(tool == "bucket")
      {
        if(mousePressed)
          cfill(dx, dy, red, green, blue, canvas);
      }
      
    }
  } //<>//
  
  void cfill(int dx, int dy, float red, float green, float blue, canvas canvas)
  {
    for(int a = -1; a < 2; a++)
    {
      for(int b = -1; b < 2; b++)
      {
        if(dx + a > 0 && dy + b > 0)
        {
          float[] Color = new float[3];
          Color = canvas.getPixel(dx, dy);
          if(Color == canvas.getPixel(dx + a, dy + b))
          {
            //canvas.setPixel(dx + a, dy + b, red, green, blue);
            println(0);
          }
          //println(dx + a, dy + b);
        }
      }
    }
  }
}

class painterTools
{
  int x, y, w, h;
  painterTools(int x, int y, int w, int h) 
  {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  void updatePos(int x, int y, int w, int h)
  {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
}

class canvas extends painterTools
{
  private int pixelScale = 5;
  float[][] red = new float[500/pixelScale + 1][500/pixelScale + 1];
  float[][] green = new float[500/pixelScale + 1][500/pixelScale + 1]; 
  float[][] blue =  new float[500/pixelScale + 1][500/pixelScale + 1];
  
  float bRed = 255;
  float bGreen = 255;
  float bBlue = 255;
  
  canvas(int xPos, int yPos, int xLength, int yLength) 
  {
    super(xPos, yPos, xLength, yLength);
    fillBackground();
  }
  
  void fillBackground()
  {
    for(int dx = 0; dx <= 500/pixelScale; dx++)
    {
      for(int dy = 0; dy <= 500/pixelScale; dy++)
      {
        red[dx][dy] = bRed;
        green[dx][dy] = bGreen;
        blue[dx][dy] = bBlue;
      }
    }
  }
  
  void setBackground(float r, float g, float b)
  {
    this.bRed = r;
    this.bGreen = g;
    this.bBlue = b;
    
    fillBackground();
  }
  
  float getBackground(String Color)
  {
    switch(Color)
    {
      case "red":
        return bRed;
      
      case "green":
        return bGreen;
      
      case "blue":
        return bBlue;
    }
    return 0;
  }
  
  float[] getPixel(int x, int y)
  {
    float[] Color = new float[3];
    Color[0] = red[x][y];
    Color[0] = green[x][y];
    Color[0] = blue[x][y];
    
    return Color;
  }
  
  void setPixel(int x, int y, float red, float green, float blue)
  {
    this.red[x][y] = red;
    this.green[x][y] = green;
    this.blue[x][y] = blue;
  }
  
  void render()
  {
    for(int dx = 1; dx <= 500; dx += pixelScale)
    {
      for(int dy = 1; dy <= 500; dy += pixelScale)
      {
        fill(red[dx/pixelScale][dy/pixelScale], green[dx/pixelScale][dy/pixelScale], blue[dx/pixelScale][dy/pixelScale]);
        rect(x + dx, y + dy, pixelScale, pixelScale);
      }
    }
  }
}