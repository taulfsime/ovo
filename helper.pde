class dataReader
{
  String[][] getLanguages()
  {
    String[] reader = loadStrings("data/language.txt");
    String[][] data = new String[reader.length][2];
    
    for(int a = 0; a < reader.length; a++)
    {
      int n = 0;
      data[a][0] = "";
      data[a][1] = "";
      for(int b = 0; b < reader[a].length(); b++)
      {
        char ch = reader[a].charAt(b);
        if(ch != ' ' || ch == '.')
        {
          if(ch == '=')
          {
            n = 1;
          }
          else
          {
            data[a][n] += ch;
          }
        }
      }
    }
    
    return data;
  }
  
  int getNumLanguages()
  {
    return loadStrings("data/language.txt").length;
  }
  
  String getAppTitle(String systemName, String source)
  {
    BufferedReader reader = createReader("data/lang/" + source);
    String data = "window." + systemName + ".title";
    String loadFile = null;
    systemName = "window." + systemName + ".title";
    
    if(true) //TODO: check for file exist
    {
      try 
      {
        while ((loadFile = reader.readLine()) != null) 
        {
          boolean isTrue = false;
          if(loadFile.length() > systemName.length())
            for(int a = 0; a < systemName.length(); a++)
            {
              if(systemName.charAt(a) == loadFile.charAt(a))
              {
                isTrue = true;
              }
              else
              {
                isTrue = false;
                a = systemName.length();
              }
            }
          
          if(isTrue)
          {
            int n = 0;
            data = "";
            
            if(loadFile.charAt(systemName.length()) == ' ') n++;
            else if(loadFile.charAt(systemName.length()) == '=') n++;
            if(loadFile.charAt(systemName.length() + 1) == '=') n++;
            else if(loadFile.charAt(systemName.length() + 1) == ' ') n++;
            if(loadFile.charAt(systemName.length() + 2) == ' ') n++;
            
            if(loadFile.charAt(systemName.length()) == '=' || loadFile.charAt(systemName.length() + 1) == '=')
              for(int a = systemName.length() + n; a < loadFile.length(); a++)
                data += loadFile.charAt(a);
            else data = systemName;
            break;
          }
        }
        reader.close();
      }
      
      catch (IOException e) 
      {
        e.printStackTrace();
      }
    }
    
    return data;
  }
  
  PImage getImage(String dir)
  {
    PImage img = null;
    
    img = loadImage(dir);
    
    if(img != null) 
    {
      return img;
    }
    
    return loadImage("basic/unknown.png");
  }
}

class data
{
  data(){}
  
  public void writeToFile(String tag, String info)
  {
    int n = loadStrings("data/data.txt").length;
    String[] data = new String[n];
    
    for(int a = 0; a < n; a++)
    {
      if(getData()[a][0].toLowerCase() == tag.toLowerCase())
      {
        data[a] = getData()[a][0] + " = " + info;
      }
      else
      {
        data[a] = getData()[a][0] + " = " + getData()[a][1];
      }
    }
    saveStrings("data/data.txt", data);
  }
  
  private String[][] getData()
  {
    String[] reader = loadStrings("data/data.txt");
    String[][] data = new String[reader.length][2];
    
    for(int a = 0; a < reader.length; a++)
    {
      int n = 0;
      data[a][0] = "";
      data[a][1] = "";
      for(int b = 0; b < reader[a].length(); b++)
      {
        char ch = reader[a].charAt(b);
        if(ch != ' ')
        {
          if(ch == '=')
          {
            n = 1;
          }
          else
          {
            data[a][n] += ch;
          }
        }
      }
    }
    return data;
  }
}