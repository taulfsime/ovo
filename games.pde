class gameSnakeGame extends application
{
  String stage = "menu";
  data data;
  
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
  button save;
  
  void init()
  {
    data = new data("snakeGame");
    stage = "menu";
    
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
    enterName = new textField(10, 70, 200, 30, "Name");
    getRed = new slider(10, 105, 200, 30, loadImage("textures/painter/tools/redSlider.png"));
    getGreen = new slider(10, 140, 200, 30, loadImage("textures/painter/tools/greenSlider.png"));
    getBlue = new slider(10, 175, 200, 30, loadImage("textures/painter/tools/blueSlider.png"));
    sc = new showColor(10, 210, 200, 30, color(getRed.getPercentage()*255, getGreen.getPercentage()*255, getBlue.getPercentage()*255));
    save = new button(10, 245, 100, 30, "Save");
    
    setting.addComponent(enterName);
    setting.addComponent(back);
    setting.addComponent(getBlue);
    setting.addComponent(getGreen);
    setting.addComponent(getRed);
    setting.addComponent(sc);
    setting.addComponent(save);
  }
  
  void update()
  {
    switch(stage)
    {
      case "menu":
        setLayout(menu);
        menu();
      break;
      
      case "game":
        setLayout(main);
      break;
      
      case "setting":
        setLayout(setting);
        setting();
      break;
    }
  }
  
  void menu()
  {
    if(start.isClicked)
    {
      stage = "game";
    }
    else if(settings.isClicked)
    {
      stage = "setting";
      
      String load;
      
      load = data.readFromFile("getRed");
      if(load.length() > 0)
      {
        getRed.setPercentage(Float.parseFloat(load));
      }
      
      load = data.readFromFile("getGreen");
      if(load.length() > 0)
      {
        getGreen.setPercentage(Float.parseFloat(load));
      }
      
      load = data.readFromFile("getBlue");
      if(load.length() > 0)
      {
        getBlue.setPercentage(Float.parseFloat(load));
      }
      
      load = data.readFromFile("name");
      if(load.length() > 0)
      {
        enterName.setText(load);
      }
    }
  }
  
  void setting()
  {
    if(back.isClicked)
    {
      stage = "menu";
    }
    else if(save.isClicked)
    {
      data.writeToFile("name", enterName.getText());
      data.writeToFile("getRed", String.valueOf(getRed.getPercentage()));
      data.writeToFile("getGreen", String.valueOf(getGreen.getPercentage()));
      data.writeToFile("getBlue", String.valueOf(getBlue.getPercentage()));
           
    }
    sc.setColor(color(getRed.getPercentage()*255, getGreen.getPercentage()*255, getBlue.getPercentage()*255));
  }
}

class compSnakeGame extends component
{
  boolean isActive = true;
  int px;
  int py;
  ArrayList<Integer> tailX = new ArrayList<Integer>();
  ArrayList<Integer> tailY = new ArrayList<Integer>();
  ArrayList<Integer> foodX = new ArrayList<Integer>();
  ArrayList<Integer> foodY = new ArrayList<Integer>();
  color playerColor = color(0, 140, 0);
  color tailColor = color(0, 120, 0);
  color foodColor = color(200, 0, 0);
  String facing; // up, down, left, right
  int tick = 0;
  int score = 0;
  boolean isPlayerDead = false;
  
  compSnakeGame(int xPos, int yPos, int xLength, int yLenght)
  {
    super(xPos, yPos, xLength, yLenght);
    facing = "up";
    px = w/2;
    py = h/2;
    
    generateFood(3);
    
    for(int a = 1; a <= 5; a++)
    {
      tailX.add(px);
      tailY.add(py + a*20);
    }
  }
  
  void setActive(boolean active)
  {
    this.isActive = active;
  }
  
  void render()
  {
    if(isActive)
    {
      if(tick > 8) //15
      {
        moving();
        controlTail();
        
        tick = 0;
      }
      else
      {
        tick++;
      
      }
      playerControl();
      
    }
    drawing();
  }
  
  void playerControl()
  {
    if(keyClicked)
    switch(key)
    {
      case 'a':
      {
        if(facing != "left" && facing != "right")
        {
          facing = "left";
        }
      }
      break;
      
      case 's':
      {
        if(facing != "down" && facing != "up")
        {
          facing = "down";
        }
      }
      break;
      
      case 'd':
      {
        if(facing != "left" && facing != "right")
        {
          facing = "right";
        }
      }
      break;
      
      case 'w':
      {
        if(facing != "down" && facing != "up")
        {
          facing = "up";
        }
      }
      break;
    }
  }
  
  void generateFood(int n)
  {
    for(int a = 0; a < n; a++)
    {
      // get X
      while(true)
      {
        int nx = (int) random(0, w);
        if(nx % 20 == 0)
        {
          for(int b : foodX)
          {
            if(b == nx)
            {
              break;
            }
          }
          
          for(int b : tailX)
          {
            if(b == nx)
            {
              break;
            }
          }
          
          if(px == nx)
          {
            break;
          }
          
          foodX.add(nx);
          break;
        }
      }
      
      // get Y
      while(true)
      {
        int ny = (int) random(0, h);
        if(ny % 20 == 0)
        {
          for(int b : foodY)
          {
            if(b == ny)
            {
              break;
            }
          }
          
          for(int b : tailY)
          {
            if(b == ny)
            {
              break;
            }
          }
          
          if(px == ny)
          {
            break;
          }
          
          foodY.add(ny);
          break;
        }
      }
      
    }
  }
  
  void controlTail()
  {
    int finish = max(tailX.size(), tailY.size());
    for(int a = finish - 1; a > 0; a--)
    {
      tailX.set(a, tailX.get(a - 1));
      tailY.set(a, tailY.get(a - 1));
    }
    
    tailX.set(0, px);
    tailY.set(0, py);
  }
  
  void addToTile(int n)
  {
    for(int a = 0; a < n; a++)
    {
      tailX.add(tailX.get(tailX.size() - 1));
      tailY.add(tailY.get(tailY.size() - 1));
    }
  }
  
  void moving()
  {
    int speed = 20;
    switch(facing)
    {
      case "down":
      {
        if(py + 20 < h)
        {
          py += speed;
        }
      }
      break;
      
      case "up":
      {
        if(py > 0)
        {
          py -= speed;
        }
      }
      break;
      
      case "left":
      {
        if(px > 0)
        {
          px -= speed;
        }
      }
      break;
      
      case "right":
      {
        if(px + 20 < w)
        {
          px += speed;
        }
      }
      break;
    }
    
    for(int a = 0; a < foodX.size() && a < foodY.size(); a++)
    {
      if(px == foodX.get(a) && py == foodY.get(a))
      {
        score++;
        generateFood(1);
        foodX.remove(a);
        foodY.remove(a);
        break;
      }
    }
    for(int a = 0; a < tailX.size() && a < tailY.size(); a++)
    {
      if(px == tailX.get(a) && py == tailY.get(a))
      {
        isPlayerDead = true;
      }
    }
  }
  
  void drawing()
  {
    fill(playerColor);
    stroke(0, 0, 0);
    rect(tx + x + px, ty + y + py, 20, 20);
    
    for(int a = 1; a < tailX.size() && a < tailY.size(); a++)
    {
      stroke(0, 0, 0);
      fill(tailColor);
      rect(tx + x + tailX.get(a) + 2, ty + y + tailY.get(a) + 2, 16, 16);
    }
    
    for(int a = 0; a < foodX.size() && a < foodY.size(); a++)
    {
      stroke(0, 0, 0);
      fill(foodColor);
      rect(tx + x + foodX.get(a) + 2, ty + y + foodY.get(a) + 2, 16, 16);
    }
    
  }
}