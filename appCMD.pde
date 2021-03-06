class console extends application
{
  console() {super(new applicationInfo("data/apps/console.json"));}
  
  layout main;
  textField enterCommand;
  button enter;
  cmdLogger logger;
  boolean pressEnter = false;
  
  color errorColor = color(245, 0, 0);
  color outputColor = color(200, 255, 255);
  color messageColor = color(200, 0, 0);
  
  String[][] COMMANDS = 
    {
    {"open", "open <systemName>"}, 
    {"close", "close <systemName>"}, 
    {"list", "list"}, 
    {"help", "help [command]"}, 
    {"clear", "clear"}, 
    {"file", "file [crete:delete:rename:copy:find] <fileName> <type>"},
    {"exit", "exit"},
    {"pin", "pin [add:remove:list] [systemName]"},
    {"tag", "tag <command> [tag] [data]"},
    {"info", "info <systemName>"}
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
    if (enter.isClicked())
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
      
      case "info":
      {
        commandInfo(readCommand.substring(cmd.length()));
      }
      break;

      case "file":
      {
        commandFile(readCommand.substring(cmd.length()));
      }
      break;
      
      case "pin":
      {
        commandPin(readCommand.substring(cmd.length()));
      }
      break;
      
      case "tag":
      {
        commandTag(readCommand.substring(cmd.length()));
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
            logger.add(">> Unknown command!", errorColor);
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
  void commandInfo(String text)
  {
    String systemName = null;
    for(String s : split(text, ' '))
    {
      if(s.length() > 0)
      {
        systemName = s;
        break;
      }
    }
    
    if(systemName != null)
    {
      for(String s : system.getSystemNames())
      {
        if(checkStrings(s, systemName))
        {
          JSONObject o = loadJSONArray("data/apps/" + s + ".json").getJSONObject(0);
          logger.add(s + ": ");
          logger.add(o.getString("systemName"));
          logger.add(o.getString("appFile"));
          logger.add(o.getString("author"));
          logger.add(o.getFloat("version") + "");
          logger.add(o.getString("description"));
          
          break;
        }
      }
    }
  }
  
  void commandTag(String text)
  {
    data d = new data("CMDTestTags");
    String command = null;
    String tag = null;
    String data = null;
    
    for(String s : split(text, ' '))
    {
      if(s.length() > 0)
      {
        if(command == null)
        {
          command = s;
        }
        else if(tag == null)
        {
          tag = s;
        }
        else if(data == null)
        {
          data = s;
        }
      }
    }
    
    switch(command)
    {
      case "write":
      {
        logger.add("write " + tag + ", " + data);
        d.toTag(tag, data);
      }
      break;
      
      case "read":
      {
        logger.add(d.getTag(tag));
      }
      break;
      
      case "remove":
      {
        logger.add("remove " + tag);
        
        d.removeTag(tag);
      }
      break;
      
      case "getTags":
      {
        for(String s : d.getTags())
        {
          logger.add(s);
        }
      }
      break;
      
      case "clear":
      {
        logger.add("clear");
        d.clear();
      }
      break;
    }
  }
  
  void commandPin(String text)
  {
    String systemName = null;
    String command = null;
    for(String s : split(text, ' '))
    {
      if(s.length() > 0)
      {
        if(command == null)
        {
          command = s;
        }
        else if(systemName == null)
        {
          systemName = s;
        }
      }
    }
    
    if(command != null)
    {
      switch(command)
      {
        case "add":
        {
          if(systemName != null)
          {
            for(String s : system.getSystemNames())
            {
              if(checkStrings(s, systemName))
              {
                for(String t : taskManager.getSystemNames())
                {
                  if(checkStrings(t, s))
                  {
                    logger.add(">> '" + s + "' window is already added!", messageColor);
                    return;
                  }
                }
                logger.add(">> '" + s + "' window has been added to Task Manager!", outputColor);
                taskManager.registerApplication(s);
                taskManager.save();
                return;
              }
            }
            logger.add(">> '" + systemName + "' window does not exist!", errorColor);
          }
        }
        break;
        
        case "remove":
        {
          if(systemName != null)
          {
            for(String s : taskManager.getSystemNames())
            {
              if(checkStrings(s, systemName))
              {
                logger.add(">> '" + s + "' window has been removed from Task Manager!", outputColor);
                taskManager.unregisterApplication(systemName);
                taskManager.save();
                return;
              }
            }
            logger.add(">> '" + systemName + "' window is already removed or does not exist!", errorColor);
          }
        }
        break;
        
        case "list":
        {
          int n = 1;
          for(String s : taskManager.getSystemNames())
          {
            logger.add(">> '" + s + "' window is at " + n +  " position at task manager!", outputColor);
            n++;
          }
        }
        break;
        
        default:
        {
          logger.add(">> Unknown command!", errorColor);
        }
        break;
      }
    }
  }
  
  void commandFile(String text)
  {
    //file [crete:delete:rename:copy:find] <fileName> [type:newFileName]"
    String c = null, fName = null, type = null;
    for(String s : split(text, ' '))
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
    
    if(c != null)
    {
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
  }

  void commandClear()
  {
    logger.clear();
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
          logger.add("> " + COMMANDS[a][1], outputColor);
          return;
        }
      }
    } 
    else
    {
      for (int a = 0; a < COMMANDS.length; a++)
      {
        logger.add(">> " + COMMANDS[a][1], outputColor);
      }
    }
  }

  void commandList()
  {
    for (String s : system.getSystemNames())
    {
      logger.add(">> '" + s + "' is " + system.getWindow(s).getTitle(), outputColor);
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
          logger.add(">> '" + w.systemName + "' window was opened!", outputColor);
          show = true;
        }
        else
        {
          logger.add(">> '" + w.systemName + "' window is already opened!", messageColor);
          show = true;
        }
      }
    }
    if (!show)
    {
      logger.add(">> '" + systemName + "' window does not exist!", errorColor);
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
            logger.add(">>'" + w.systemName + "' window was closed!", outputColor);
            show = true;
          } 
          else
          {
            logger.add(">>'" + w.systemName + "' window is already closed!", messageColor);
            show = true;
          }
          return;
        }
      }
      if (!show)
      {
        logger.add(">>'" + systemName + "' window does not exist!", errorColor);
      }
    } 
    else
    {
      if (system.getWindow("console").isOpen)
      {
        system.close("console");
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
    scroll.setScrollSize(0, 0);

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

      //int sc = min(scroll.h/2 - (int) (texts.size()*0.5), scroll.h/2);

      scroll.setScrollSize(vLines, texts.size());
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