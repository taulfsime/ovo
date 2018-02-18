class console extends application
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
    {"help", "help [command]"}, 
    {"clear", "clear"}, 
    {"file", "file [crete:delete:rename:copy:find] <fileName> <type>"},
    {"exit", "exit"}
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
    
    setLayout(main);
  }

  void update()
  {
    

    if (enter.isClicked)
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
        commandOpen(readCommand.substring(cmd.length()));
      }
      break;

      case "close":
      {
        commandClose(readCommand.substring(cmd.length()));
      }
      break;

      case "list":
      {
        commandList();
      }
      break;

      case "help":
      {
        commandHelp(readCommand.substring(cmd.length()));
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
      
      case "exit":
      {
        exit();
      }
      break;

      default:
      {
        if (pressEnter)
        {
          if (readCommand != "")
          {
            logger.add("> Unknown command!", color(245, 0, 0));
          }
          pressEnter = false;
        }
      }
      break;
    }

    if (readCommand != "")
    {
      readCommand = "";
    }
  }

  String getCommand(String text)
  {
    if (text != "")
    {
      for (int a = 0; a < COMMANDS.length; a++)
      {
        int l = COMMANDS[a][0].length();
        for (int b = 0; b < l; b++)
        {
          if (text.length() >= l)
          {
            if (checkStrings(COMMANDS[a][0], text.substring(0, l)))

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
    //file [crete:delete:rename:copy:find] <fileName> [type:newFileName]"
    String c = null, fName = null, type = null;
    String[] t = split(text, ' ');
    for(String s : t)
    {
      if(s.length() > 0)
      {
        if(c == null)
        {
          c = s;
        }
        else if(fName == null)
        {
          fName = s;
        }
        else if(type == null)
        {
          type = s;
        }
      }
    }
    
    switch(c)
    {
      case "delete":
      {
        
      }
      break;
      
      case "rename":
      {
        
      }
      break;
      
      case "copy":
      {
        
      }
      break;
      
      case "find":
      {
        
      }
      break;
      
      case "create":
      {
        
      }
      break;
    }
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
    for (int a = 0; a < test.length; a++)
    {
      if (test[a].length() > 0)
      {
        systemName = test[a];
        break;
      }
    }

    int l = system.getSystemNames().length;
    for (int a = 0; a < l; a++)
    {
      if (checkStrings(systemName, system.getSystemNames()[a]))
      {
        int l1 = taskManager.getSystemNames().length;
        for (int b = 0; b < l1; b++)
        {
          if (checkStrings(systemName, taskManager.getSystemNames()[b]) && !show1)
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
        if (!show)
        {
          logger.add(">'" + systemName + "' window does not exist!", color(150, 0, 0));
          show = true;
        }
      }
    }

    if (add)
    {
      taskManager.registerApplication(systemName);
    }
  }

  void commandHelp(String text)
  {
    String[] t = split(text, ' ');
    String systemName = "";
    for(String s : t)
    {
      if(s.length() > 0)
      {
        systemName = s;
        break;
      }
    }
    
    
    if (systemName != "")
    {
      for(int a = 0; a < COMMANDS.length; a++)
      {
        if(checkStrings(COMMANDS[a][0], systemName))
        {
          logger.add("> " + COMMANDS[a][1], color(200, 255, 255));
          return;
        }
      }
    } 
    else
    {
      for (int a = 0; a < COMMANDS.length; a++)
      {
        logger.add("> " + COMMANDS[a][1], color(200, 255, 255));
      }
    }
  }

  void commandList()
  {
    for (String s : system.getSystemNames())
    {
      logger.add("> '" + s + "' is " + system.getWindow(s).title, color(200, 255, 255));
    }
  }

  void commandOpen(String text)
  {
    boolean show = false;
    String systemName = "";

    String[] test = split(text, ' ');  
    for (int a = 0; a < test.length; a++)
    {
      if (test[a].length() > 0)
      {
        systemName = test[a];
        break;
      }
    }

    for (int a = 0; a < system.getSystemNames().length; a++)
    {
      if (checkStrings(systemName, system.getSystemNames()[a]))
      {
        window w = system.getWindow(system.getSystemNames()[a]);
        if (!w.isOpen)
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
    if (!show)
    {
      logger.add("> '" + systemName + "' window does not exist!", color(150, 0, 0));
    }
  }

  void commandClose(String text)
  {
    String systemName = "";
    String[] test = split(text, ' ');

    for (int a = 0; a < test.length; a++)
    {
      if (test[a].length() > 0)
      {
        systemName = test[a];
        break;
      }
    }

    if (systemName != "")
    {
      
      boolean show = false;
      for (int a = 0; a < system.getSystemNames().length; a++)
      {
        if (checkStrings(systemName, system.getSystemNames()[a]))
        {
          window w = system.getWindow(system.getSystemNames()[a]);
          if (w.isOpen)
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
      if (!show)
      {
        logger.add(">'" + systemName + "' window does not exist!", color(150, 0, 0));
      }
    } 
    else
    {
      if (system.getWindow("console").isOpen)
      {
        system.getWindow("console").close();
      }
    }
  }
}

class cmdLogger extends component
{
  //12
  ArrayList<String> texts = new ArrayList<String>();
  ArrayList<Integer> textColor = new ArrayList<Integer>();
  scrollBar scroll;
  int vLines;
  color backgroundColor = color(30, 30, 30);

  cmdLogger(int xPos, int yPos, int xLength, int yLength)
  {
    super(xPos, yPos, xLength, yLength);
    vLines = w/21;

    scroll = new scrollBar(x + w - 15, y + 4, 15, h - 8);
    scroll.setScrollSize(50);

    scroll.setColor(backgroundColor);
  }

  void add(String text, color c)
  {
    texts.add(text);
    textColor.add(c);
  }

  void add(String text)
  {
    texts.add(text);
    textColor.add(color(110, 110, 110));
  }

  void clear()
  {
    texts.clear();
    textColor.clear();
  }

  void render()
  {
    fill(border);
    noStroke();
    rect(x + tx, y + ty, w, h);

    fill(backgroundColor);
    noStroke();
    rect(x + borderWidth + tx, y + borderWidth + ty, w - borderWidth*2, h - borderWidth*2);

    if (texts.size() > vLines)
    {
      scroll.updateComponent(x + tx + w - scroll.w - 2, y + ty + 4);
      scroll.render();

      int sc = min(scroll.h/2 - (int) (texts.size()*0.5), scroll.h/2);

      scroll.setScrollSize(sc > 20 ? (sc < scroll.h/2 ? sc : scroll.h) : 20);
    }

    textSize(12);
    if (texts.size() > 0)
    {
      int start = texts.size() > vLines ? (int) (scroll.getPer()*(texts.size() - vLines)) : 0;
      int finish = texts.size() > vLines ? (start + vLines < texts.size() ? start + vLines : texts.size()) : texts.size();
      for (int a = start; a < finish; a++)
      {
        fill(textColor.get(a));
        text(texts.get(a), x + tx + borderWidth + 12, y + ty + borderWidth + 15*((a - start) + 1));
      }
    }
  }
}