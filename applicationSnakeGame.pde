class snakeGame extends application
{
  int px;
  int py;
  int sx = 0;
  int sy = 1;
  int x;
  int y;
  int w;
  int h;
  double delay = 0;
  void init()
  { 
    delay += 0.1;
    if(delay > 2.1)
      delay = 0;
    
    if(delay > 2)
    {
      move(sx, sy);
      renderPlayer();
      
      this.x = x;
      this.y = y;
      this.w = w;
      this.h = h;
    }    
    control();
  }
  
  void preinit()
  {
    px = this.x + w/2;
    py = this.y + h/2;
  }
  
  void move(int xSpeed, int ySpeed)
  {
    if(px > this.x && px < this.x + this.w)
      px = xSpeed + px;
    if(py > this.y && py < this.y + this.h)
      py = ySpeed + py;
  }
  
  void renderPlayer()
  {
    fill(0, 255, 0);
    rect(px - 10, py - 10, 20, 20);
  }
  
  void control()
  {
    if(keyPressed)
    {
      if(keyCode == 'w')
      {
        py = 1;
        px = 0;
      }
      else if(keyCode == 'a')
      {
        py = 0;
        px = -1;
      }
      else if(keyCode == 's')
      {
        py = -1;
        px = 0;
      }
      else if(keyCode == 'd')
      {
        py = 0;
        px = 1;
      }
    }
  }
  
}