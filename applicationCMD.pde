class consoleNewV extends application
{
  layout main;
  textField enterCommand;
  button enter;
  cmdLogger logger;
  boolean pressEnter = false;
  String[][] COMMANDS = 
  {
    {"open", "open <systemName>"},
    {"close", "close <systemName>"},
    {"list", "list"},
    {"help", "help [command:page]"},
    {"clear", "clear"},
    {"file", "file [crete:delete] <type> <fileName>"}
  };
  
  String readCommand = "";
  
  void init()
  {
    main = new layout               (500, 400);
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
   
    String cmd = getCommand(readCommand);
    switch(cmd)
    {
      case "open":
      {
        commandOpen(cmd.substring(cmd.length()));
      }
      break;
      
      case "close":
      {
        
      }
      break;
      
      case "list":
      {
        commandList();
      }
      break;
      
      case "help":
      {
        commandHelp("");
      }
      break;
      
      case "file":
      {
        commandFile(readCommand.substring(cmd.length()));
      }
      break;
      
      case "clear":
      {
        commandClear();
      }
      break;
      
      default:
      {
        if(pressEnter)
        {
          if(readCommand != "")
          {
            logger.add("> Unknown command!", color(245, 0, 0));
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
        int l = COMMANDS[a][0].length();
        for(int b = 0; b < l; b++)
        {
          if(text.length() >= l)
          {
            if(checkStrings(COMMANDS[a][0], text.substring(0, l)))
            
            {
              return COMMANDS[a][0];
            }
          }
          else
          {
            break;
          }
        }
      }
    }
    return "";
  }
  
        /* COMMANDS */
  void commandFile(String text)
  {
    
  }
  
  void commandClear()
  {
    logger.clear();
  }
    
  void commandPin(String text)
  {
    boolean show = false;
    boolean show1 = false;
    boolean add = true;
    String systemName = "";
    
    String[] test = split(text, ' ');
    for(int a = 0; a < test.length; a++)
    {
      if(test[a] != "")
      {
        systemName = test[a];
        break;
      }
    }
    
    int l = system.getSystemNames().length;
    for(int a = 0; a < l; a++)
    {
      if(checkStrings(systemName, system.getSystemNames()[a]))
      {
        int l1 = taskManager.getSystemNames().length;
        for(int b = 0; b < l1; b++)
        {
          if(checkStrings(systemName, taskManager.getSystemNames()[b]) && !show1)
          {
              logger.add(">'" + systemName + "' window is already added is taskManager!", color(150, 0, 0));
              b = l1 + 10;
              a = l + 10;
              add = false;
          }
        }
      }
      else
      {
        if(!show)
        {
          logger.add(">'" + systemName + "' window does not exist!", color(150, 0, 0));
          show = true;
        }
      }
    }
    
    if(add)
    {
      taskManager.registerApplication(systemName);
    }
  }
  
  void commandHelp(String text)
  {
    if(text != "")
    {
      int n = Integer.parseInt(text);
      if(n > 0 && n < COMMANDS.length / 5)
      {
        for(int a = n * 5; a < (n + 1) * 5; a++)
        {
          logger.add(COMMANDS[a][1], color(200, 255, 255));
        }
      }
      else
      {
        logger.add("Unknown page!", color(150, 0, 0));
      }
    }
    else
    {
      for(int a = 0; a < COMMANDS.length; a++)
      {
        logger.add(COMMANDS[a][1], color(200, 0, 0));
      }
    }
  }
  
  void commandList()
  {
    for(int a = 0; a < system.getSystemNames().length; a++)
    {
      logger.add(a + ": " + system.getSystemNames()[a], color(200, 255, 255));
    }
  }
  
  void commandOpen(String text)
  {
    boolean show = false;
    String systemName = "";
    
    String[] test = split(text, ' ');
    for(int a = 0; a < test.length; a++)
    {
      if(test[a] != "")
      {
        systemName = test[a];
        break;
      }
    }
    
    for(int a = 0; a < system.getSystemNames().length; a++)
    {
      if(checkStrings(systemName, system.getSystemNames()[a]))
      {
        window w = system.getWindow(system.getSystemNames()[a]);
        if(!w.isOpen)
        {
          w.open();
          logger.add("> '" + w.systemName + "' window was opened!", color(200, 255, 255));
          show = true;
        }
        else
        {
          logger.add("> '" + w.systemName + "' window is already opened!", color(200, 0, 0));
          show = true;
        }
      }
    }
     if(!show)
    {
      logger.add("> '" + systemName + "' window does not exist!", color(150, 0, 0));
    }
  }
  
  void commandClose(String systemName)
  {
    if(systemName != "")
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
            logger.add(">'" + w.systemName + "' window was closed!", color(230, 255, 255));
            show = true;
          }
          else
          {
            logger.add(">'" + w.systemName + "' window is already closed!", color(150, 0, 0));
            show = true;
          }
          return;
        }
      }
      if(!show)
      {
        logger.add(">'" + systemName + "' window does not exist!", color(150, 0, 0));
      }
    }
    else
    {
      if(system.getWindow("console").isOpen)
      {
        system.getWindow("console").close();
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
  
  void clear()
  {
    for(int a = 0; a < texts.length; a++)
    {
      if(texts[a] != "")
      {
        texts[a] = "";
      }
    }
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
    "help",
    "clear"
  };
  
  String[] cmdINFO =
  {
    "open <systemName>",
    "close <systemName>",
    "list",
    "help [command:page]",
    "clear"
  };
  
  String readCommand = "";
  
  void init()
  {
    main = new layout               (500, 400);
    enterCommand = new textField    (10, 360, 420, 30, "Enter command:");
    enter = new button              (435, 360, 50, 30, "Enter");
    logger = new cmdLogger          (10, 10, 475, 340); //475
    
    enter.bindKey(ENTER);
    for(int a = 0; a < COMMANDS.length; a++)
    {
      enterCommand.addToLibrary(COMMANDS[a]);
    }
    
    for(int a = 0; a < system.getSystemNames().length; a++)
    {
      enterCommand.addToLibrary(system.getSystemNames()[a]);
      //println(system.getSystemNames()[a]);
    }
    
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
      
      case "help":
      {
        commandHelp(removeChar(readCommand.substring("help".length(), readCommand.length()), ' '));
      }
      break;
      
      case "clear":
      {
        commandClear();
      }
      break;
      
      default:
      {
        if(pressEnter)
        {
          if(readCommand != "")
          {
            logger.add("> Unknown command!", color(245, 0, 0));
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
            break;
          }
        }
      }
    }
    return "";
  }
  
  String removeChar(String text, char ch)
  {
    String result = "";
    if(text != "")
    {
      for(int a = 0; a < text.length(); a++)
      {
        if(text.charAt(a) != ch)
        {
          result += text.charAt(a);
        }
      }
    }
    return result;
  }
  
  // WORK ON COMMANDS
  void commandClear()
  {
    logger.clear();
  }
    
  void commandPin(String systemName)
  {
    boolean show = false;
    boolean show1 = false;
    boolean add = true;
    
    int l = system.getSystemNames().length;
    for(int a = 0; a < l; a++)
    {
      if(checkStrings(systemName, system.getSystemNames()[a]))
      {
        int l1 = taskManager.getSystemNames().length;
        for(int b = 0; b < l1; b++)
        {
          if(checkStrings(systemName, taskManager.getSystemNames()[b]) && !show1)
          {
              logger.add(">'" + systemName + "' window is already added is taskManager!", color(150, 0, 0));
              b = l1 + 10;
              a = l + 10;
              add = false;
          }
        }
      }
      else
      {
        if(!show)
        {
          logger.add(">'" + systemName + "' window does not exist!", color(150, 0, 0));
          show = true;
        }
      }
    }
    
    if(add)
    {
      taskManager.registerApplication(systemName);
    }
  }
  
  void commandHelp(String text)
  {
    if(text != "")
    {
      int n = Integer.parseInt(text);
      if(n > 0 && n < cmdINFO.length / 5)
      {
        for(int a = n * 5; a < (n + 1) * 5; a++)
        {
          logger.add(cmdINFO[a], color(200, 255, 255));
        }
      }
      else
      {
        logger.add("Unknown page!", color(150, 0, 0));
      }
    }
    else
    {
      for(int a = 0; a < cmdINFO.length; a++)
      {
        logger.add(cmdINFO[a], color(200, 0, 0));
      }
    }
  }
  
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
          logger.add("> '" + w.systemName + "' window was opened!", color(200, 255, 255));
          show = true;
        }
        else
        {
          logger.add("> '" + w.systemName + "' window is already opened!", color(200, 0, 0));
          show = true;
        }
      }
    }
     if(!show)
    {
      logger.add("> '" + systemName + "' window does not exist!", color(150, 0, 0));
    }
  }
  
  void commandClose(String systemName)
  {
    if(systemName != "")
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
            logger.add(">'" + w.systemName + "' window was closed!", color(230, 255, 255));
            show = true;
          }
          else
          {
            logger.add(">'" + w.systemName + "' window is already closed!", color(150, 0, 0));
            show = true;
          }
          return;
        }
      }
      if(!show)
      {
        logger.add(">'" + systemName + "' window does not exist!", color(150, 0, 0));
      }
    }
    else
    {
      if(system.getWindow("console").isOpen)
      {
        system.getWindow("console").close();
      }
    }
  }
}