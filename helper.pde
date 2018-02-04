class dataReader
{
  PImage getImage(String dir)
  {
    PImage img = null;
    
    img = loadImage(dir);
    
    if(img != null) 
    {
      return img;
    }
    
    return loadImage("textures/unknown.png");
  }
  
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
}

class data
{
  String dir;
  data(String dir)
  {
    this.dir = dir;
  }
  
  void writeToFile(String tag, String info)
  {
    String[] data = loadStrings("data/tags/" + dir + ".txt");
    if(readFromFile(tag) == null)
    {
      String[] newData = new String[data.length + 1];
      newData[data.length] = tag + "=" + info;
      saveStrings("data/tags/" + dir + ".txt", newData);
    }
  }
  
  String readFromFile(String tag)
  {
    String[] data = loadStrings("data/tags/" + dir + ".txt");
    
    for(int b = 0; b < data.length; b++)
    {
      String t = "";
      String testTag = "";
      
      //Remove spaces from tag
      for(int a = 0; a < data[b].length(); a++)
      {
        if(data[b].charAt(a) != ' ')
        {
          t += data[b].charAt(a);
        }
      }
      
      //Get tag from text
      for(int a = 0; a < tag.length(); a++)
      {
        testTag += t.charAt(a);
      }
      
      //Check tags  
      if(check(tag, testTag))
      {
        String result = "";
        for(int a = testTag.length(); a < (t.length()); a++)
        {
          if(t.charAt(a) != '=')
          {
            result += t.charAt(a);
          }
        }
        return result;
      }
    }
    return null;
  }
  
  boolean check(String t1, String t2)
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
  
  //private String[][] getData()
  //{
  //  String[] reader = loadStrings("data/data.txt");
  //  String[][] data = new String[reader.length][2];
    
  //  for(int a = 0; a < reader.length; a++)
  //  {
  //    int n = 0;
  //    data[a][0] = "";
  //    data[a][1] = "";
  //    for(int b = 0; b < reader[a].length(); b++)
  //    {
  //      char ch = reader[a].charAt(b);
  //      if(ch != ' ')
  //      {
  //        if(ch == '=')
  //        {
  //          n = 1;
  //        }
  //        else
  //        {
  //          data[a][n] += ch;
  //        }
  //      }
  //    }
  //  }
  //  return data;
  //}
}