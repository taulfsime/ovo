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