class console extends application
{
  layout main;
  textField enterCommand;
  button enter;
  cmdLogger logger;
  boolean pressEnter = false;
  String[] COMMANDS = 
  {
    "open",
    "close",
    "list",
  };
  
  String readCommand = "";
  
  void init()
  {
    main = new layout(500 + 6, 400 + 27);
    enterCommand = new textField    (10, 360, 420, 30, "Enter command:");
    enter = new button              (435, 360, 50, 30, "Enter");
    logger = new cmdLogger          (10, 10, 475, 340); //475
    
    enter.bindKey(ENTER);
    
    main.addComponent(enterCommand);
    main.addComponent(enter);
    main.addComponent(logger);
  }
  
  void update()
  {
    setLayout(main);
    
    if(enter.isClicked)
    {
      readCommand = enterCommand.getText();
      logger.add("> " + readCommand);
      enterCommand.text = "";
      pressEnter = true;
    }
    
    switch(getCommand(readCommand))
    {
      case "open":
      {
        commandOpen(removeChar(readCommand.substring("open".length(), readCommand.length()), ' '));
      }
      break;
      
      case "close":
      {
        commandClose(removeChar(readCommand.substring("close".length(), readCommand.length()), ' '));
      }
      break;
      
      case "list":
      {
        commandList();
      }
      break;
      
      default:
      {
        if(pressEnter)
        {
          if(readCommand != "")
          {
            logger.add("Unknown command!", color(245, 0, 0));
          }
          pressEnter = false;
        }
      }
      break;
    }
    
    if(readCommand != "")
    {
      readCommand = "";
    }
  }
  
  String getCommand(String text)
  {
    if(text != "")
    {
      for(int a = 0; a < COMMANDS.length; a++)
      {
        int l = COMMANDS[a].length();
        for(int b = 0; b < l; b++)
        {
          if(text.length() >= l)
          {
            if(checkStrings(COMMANDS[a], text.substring(0, l)))
            {
              return COMMANDS[a];
            }
          }
          else
          {
            b = l + 10;
          }
        }
      }
    }
    return "";
  }
  
  String removeChar(String text, char ch)
  {
    String result = "";
    
    for(int a = 0; a < text.length(); a++)
    {
      if(text.charAt(a) != ch)
      {
        result += text.charAt(a);
      }
    }
    return result;
  }
  
  boolean checkStrings(String t1, String t2)
  {
    for(int a = 0; a < t1.length(); a++)
    {
      if(t1.charAt(a) != t2.charAt(a))
      {
        return false;
      }
    }
    return true;
  }
  
  // WORK ON COMMANDS
  
  void commandList()
  {
    for(int a = 0; a < system.getSystemNames().length; a++)
    {
      logger.add(a + ": " + system.getSystemNames()[a], color(200, 255, 255));
    }
  }
  
  void commandOpen(String systemName)
  {
    boolean show = false;
    for(int a = 0; a < system.getSystemNames().length; a++)
    {
      if(checkStrings(systemName, system.getSystemNames()[a]))
      {
        window w = system.getWindow(system.getSystemNames()[a]);
        if(!w.isOpen)
        {
          w.open();
          logger.add("'" + w.systemName + "' window was opened!", color(200, 255, 255));
        }
        else
        {
          logger.add("'" + w.systemName + "' window is already opened!", color(200, 0, 0));
        }
        return;
      }
      else
      {
        if(!show)
        {
          logger.add("'" + systemName + "' window does not exist!", color(150, 0, 0));
          show = true;
        }
      }
    }
  }
  
  void commandClose(String systemName)
  {
    boolean show = false;
    for(int a = 0; a < system.getSystemNames().length; a++)
    {
      if(checkStrings(systemName, system.getSystemNames()[a]))
      {
        window w = system.getWindow(system.getSystemNames()[a]);
        if(w.isOpen)
        {
          w.close();
          logger.add("'" + w.systemName + "' window was closed!", color(230, 255, 255));
        }
        else
        {
          logger.add("'" + w.systemName + "' window is already closed!", color(150, 0, 0));
        }
        return;
      }
      else
      {
        if(!show)
        {
          logger.add("'" + systemName + "' window does not exist!", color(150, 0, 0));
          show = true;
        }
      }
    }
  }
}

class cmdLogger extends component
{
  //12
  String[] texts;
  
  int col;
  color backgroundColor = color(30, 30, 30);
  color[] textColor;
  cmdLogger(int xPos, int yPos, int xLength, int yLength)
  {
    super(xPos, yPos, xLength, yLength);
    col = w/21;
    texts = new String[col];
    textColor = new color[col];
    for(int a = 0; a < col; a++)
    {
      texts[a] = "";
      textColor[a] = color(110, 110, 110);
    }
  }
  
  void add(String text, color c)
  {
    for(int a = 1; a < col; a++)
    {
      texts[a - 1] = texts[a];
      textColor[a - 1] = textColor[a];
    }
    texts[col - 1] = text;                   //"[" + hour() + ":" + minute() + ":" + second() + "] " + 
    textColor[col - 1] = c;
  }
  
  void add(String text)
  {
    for(int a = 1; a < col; a++)
    {
      texts[a - 1] = texts[a];
      textColor[a - 1] = textColor[a];
    }
    texts[col - 1] = text;
    textColor[col - 1] = color(110, 110, 110);
  }
  
  void render()
  {
    fill(border);
    noStroke();
    rect(x + tx, y + ty, w, h);
    
    fill(backgroundColor);
    noStroke();
    rect(x + borderWidth + tx, y + borderWidth + ty, w - borderWidth*2, h - borderWidth*2);
    
    textSize(12);
    for(int a = 0; a < col; a++)
    {
      fill(textColor[a]);
      text(texts[a], x + tx + borderWidth + 12, y + ty + borderWidth + 15 + 15*a);
    }
  }
}