class snakeGame extends application
{
  snakeGame() {super(new applicationInfo("data/apps/snakeGame.json"));}
  
  data data;
    
  color headColor = color(0, 175, 0);
  color tailColor = color(0, 115, 0);
    
  layout main;
  compSnakeGame s;
  
  layout menu;
  button start;
  button settings;
  
  layout setting;
  button back;
  textField enterName;
  slider getRed;
  slider getGreen;
  slider getBlue;
  showColor sc;
  slider getRed1;
  slider getGreen1;
  slider getBlue1;
  showColor sc1;
  button save;
  
  void init()
  {
    data = new data("snakeGame");
    
    //////////////GAME/////////////////
    main = new layout(800, 600);
    s = new compSnakeGame(0, 0, 800, 600);
    
    main.addComponent(s);
    /////////////MENU//////////////////////
    
    menu = new layout(400, 300);
    start = new button(100, 70, 200, 30, "Start");
    settings = new button(100, 105, 200, 30, "Settings");
    
    menu.addComponent(start);
    menu.addComponent(settings);
    
    //////////////SETTINGS/////////////////
    setting = new layout(400, 300);
    back = new button(5, 5, 30, 30, "<");
    enterName = new textField(10, 70, 190, 30, "Name");
    getRed = new slider(10, 105, 190, 30, loadImage("textures/painter/tools/redSlider.png"));
    getGreen = new slider(10, 140, 190, 30, loadImage("textures/painter/tools/greenSlider.png"));
    getBlue = new slider(10, 175, 190, 30, loadImage("textures/painter/tools/blueSlider.png"));
    sc = new showColor(10, 210, 190, 30, color(getRed.getPercentage()*255, getGreen.getPercentage()*255, getBlue.getPercentage()*255));
    
    getRed1 = new slider(210, 105, 190, 30, loadImage("textures/painter/tools/redSlider.png"));
    getGreen1 = new slider(210, 140, 190, 30, loadImage("textures/painter/tools/greenSlider.png"));
    getBlue1 = new slider(210, 175, 190, 30, loadImage("textures/painter/tools/blueSlider.png"));
    sc1 = new showColor(210, 210, 190, 30, color(getRed.getPercentage()*255, getGreen.getPercentage()*255, getBlue.getPercentage()*255));
    
    save = new button(10, 245, 100, 30, "Save");
    
    setting.addComponent(enterName);
    setting.addComponent(back);
    setting.addComponent(getBlue);
    setting.addComponent(getGreen);
    setting.addComponent(getRed);
    setting.addComponent(sc);
    setting.addComponent(getBlue1);
    setting.addComponent(getGreen1);
    setting.addComponent(getRed1);
    setting.addComponent(sc1);
    setting.addComponent(save);
    
    setLayout(menu);
  }
  
  void update()
  {
    if(getLayout() == menu)
    {
      menu();
    }
    else if(getLayout() == setting)
    {
      setting();
    }
  }
  
  void menu()
  {
    if(start.isClicked())
    {
      s.setHeadColor(headColor);
      s.setTailColor(tailColor);
      setLayout(main);
    }
    else if(settings.isClicked())
    {
      setLayout(setting);
      
      String load;
      
      load = data.getTag("getRed_head");
      if(load.length() > 0)
      {
        getRed.setPercentage(Float.parseFloat(load));
      }
      
      load = data.getTag("getGreen_head");
      if(load.length() > 0)
      {
        getGreen.setPercentage(Float.parseFloat(load));
      }
      
      load = data.getTag("getBlue_head");
      if(load.length() > 0)
      {
        getBlue.setPercentage(Float.parseFloat(load));
      }
      
      load = data.getTag("getRed_tail");
      if(load.length() > 0)
      {
        getRed1.setPercentage(Float.parseFloat(load));
      }
      
      load = data.getTag("getGreen_tail");
      if(load.length() > 0)
      {
        getGreen1.setPercentage(Float.parseFloat(load));
      }
      
      load = data.getTag("getBlue_tail");
      if(load.length() > 0)
      {
        getBlue1.setPercentage(Float.parseFloat(load));
      }
      
      load = data.getTag("name");
      if(load.length() > 0)
      {
        enterName.setText(load);
      }
    }
  }
  
  void setting()
  {
    if(back.isClicked())
    {
      setLayout(menu);
    }
    else if(save.isClicked())
    {
      data.toTag("name", enterName.getText());
      data.toTag("getRed_head", String.valueOf(getRed.getPercentage()));
      data.toTag("getGreen_head", String.valueOf(getGreen.getPercentage()));
      data.toTag("getBlue_head", String.valueOf(getBlue.getPercentage()));
      data.toTag("name", enterName.getText());
      
      data.toTag("getRed_tail", String.valueOf(getRed1.getPercentage()));
      data.toTag("getGreen_tail", String.valueOf(getGreen1.getPercentage()));
      data.toTag("getBlue_tail", String.valueOf(getBlue1.getPercentage()));
      
      headColor = color(getRed.getPercentage()*255, getGreen.getPercentage()*255, getBlue.getPercentage()*255);
      tailColor = color(getRed1.getPercentage()*255, getGreen1.getPercentage()*255, getBlue1.getPercentage()*255);
    }
    sc.setColor(color(getRed.getPercentage()*255, getGreen.getPercentage()*255, getBlue.getPercentage()*255));
    sc1.setColor(color(getRed1.getPercentage()*255, getGreen1.getPercentage()*255, getBlue1.getPercentage()*255));
  }
}

class compSnakeGame extends component
{
  ArrayList<snakePlayer> players = new ArrayList<snakePlayer>();
  ArrayList<Integer> foodX = new ArrayList<Integer>();
  ArrayList<Integer> foodY = new ArrayList<Integer>();
  color foodColor = color(200, 0, 0);
  int tick = 0;
  
  compSnakeGame(int xPos, int yPos, int xLength, int yLenght)
  {
    super(xPos, yPos, xLength, yLenght);
    players.add(new snakePlayer("test", w/2, h/2, "up", 5));
  }
  
  void setHeadColor(color c)
  {
    players.get(0).setHeadColor(c);
  }
  
  void setTailColor(color c)
  {
    players.get(0).setTailColor(c);
  }
  
  void render()
  {
    if(isActive)
    {
      if(tick > 8) //15
      {
        for(snakePlayer s : players)
        {
          s.move(w, h);
        }
        
        tick = 0;
      }
      else
      {
        tick++;
      
      }
      playerControl();
      
    }
    for(snakePlayer s : players)
    {
      s.render(tx + x, ty + y);
    }
  }
  
  void playerControl()
  {
    if(keyClicked)
    {
      switch(key)
      {
        case 'a':
        {
          if(players.get(0).facing != "left" && players.get(0).facing != "right")
          {
            players.get(0).facing = "left";
          }
        }
        break;
        
        case 's':
        {
          if(players.get(0).facing != "down" && players.get(0).facing != "up")
          {
            players.get(0).facing = "down";
          }
        }
        break;
        
        case 'd':
        {
          if(players.get(0).facing != "left" && players.get(0).facing != "right")
          {
            players.get(0).facing = "right";
          }
        }
        break;
        
        case 'w':
        {
          if(players.get(0).facing != "down" && players.get(0).facing != "up")
          {
            players.get(0).facing = "up";
          }
        }
        break;
        
        case ' ':
        {
          
        }
        break;
      }
    }
  }
  
  //void generateFood(int n)
  //{
  //  for(int a = 0; a < n; a++)
  //  {
  //    // get X
  //    while(true)
  //    {
  //      int nx = (int) random(0, w);
  //      if(nx % 20 == 0)
  //      {
  //        for(int b : foodX)
  //        {
  //          if(b == nx)
  //          {
  //            break;
  //          }
  //        }
          
  //        for(int p = 0; p < players.size(); p++)
  //        {
  //          if(players.get(p).snake.get()x == nx)
  //          {
  //            break;
  //          }
  //        }
          
  //        if(px == nx)
  //        {
  //          break;
  //        }
          
  //        foodX.add(nx);
  //        break;
  //      }
  //    }
      
  //    // get Y
  //    while(true)
  //    {
  //      int ny = (int) random(0, h);
  //      if(ny % 20 == 0)
  //      {
  //        for(int b : foodY)
  //        {
  //          if(b == ny)
  //          {
  //            break;
  //          }
  //        }
          
  //        for(int b : tailY)
  //        {
  //          if(b == ny)
  //          {
  //            break;
  //          }
  //        }
          
  //        if(px == ny)
  //        {
  //          break;
  //        }
          
  //        foodY.add(ny);
  //        break;
  //      }
  //    }
      
  //  }
  //}
}

class snakePlayer
{
  String name;
  String facing;
  ArrayList<Integer> tailX = new ArrayList<Integer>();
  ArrayList<Integer> tailY = new ArrayList<Integer>();
  int playerX, playerY;
  color headColor = color(0, 140, 0);
  color tailColor = color(0, 110, 0);
  int playerSize = 20;
  
  snakePlayer(String name, int startX, int startY, String startFacing, int startLength)
  {
    playerX = startX;
    playerY = startY;
    facing = startFacing;
    this.name = name;
    
    for(int a = 1; a <= startLength; a++)
    {
      switch(facing)
      {
        case "left":
        {
          tailX.add(playerX - a);
          tailY.add(playerY);
        }
        break;
        
        case "up":
        {
          tailX.add(playerX);
          tailY.add(playerY - a);
        }
        break;
        
        case "right":
        {
          tailX.add(playerX + a);
          tailY.add(playerY);
        }
        break;
        
        case "down":
        {
          tailX.add(playerX);
          tailY.add(playerY + a);
        }
        break;
      }
    }
  }
  
  void setHeadColor(color c)
  {
    headColor = c;
  }
  
  void setTailColor(color c)
  {
    tailColor = c;
  }
  
  void render(int tx, int ty)
  {
    fill(headColor);
    stroke(0, 0, 0);
    rect(playerX + tx, playerY + ty, playerSize, playerSize);
    
    int f = max(tailX.size(), tailY.size());
    for(int a = 0; a < f; a++)
    {
      fill(tailColor);
      stroke(0, 0, 0);
      rect(tailX.get(a) + 2 + tx, tailY.get(a) + 2 + ty, playerSize - 4, playerSize - 4);
    }
  }
  
  void move(int wArea, int hArea)
  {
    int f = max(tailX.size(), tailY.size());
    for(int a = f - 1; a > 0; a--)
    {
      tailX.set(a, tailX.get(a - 1));
      tailY.set(a, tailY.get(a - 1));
    }
    
    tailX.set(0, playerX);
    tailY.set(0, playerY);
    
    switch(facing)
    {
      case "down":
      {
        if(playerY < hArea)
        {
          playerY += playerSize;
        }
      }
      break;
      
      case "up":
      {
        if(playerY > 0)
        {
          playerY -= playerSize;
        }
      }
      break;
      
      case "left":
      {
        if(playerX > 0)
        {
          playerX -= playerSize;
        }
      }
      break;
      
      case "right":
      {
        if(playerX < wArea)
        {
          playerX += playerSize;
        }
      }
      break;
    }
  }
}