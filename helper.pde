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
}

class data
{
  String dir;
  data(String dir)
  {
    this.dir = dir;
  }
  
  public void writeToFile(String tag, String info)
  {
    String[] data = loadStrings("data/dataTags/" + dir + ".txt");
    
    for(int a = 0; a < data.length; a++)
    {

    }
    saveStrings("data/data.txt", data);
  }
  
  String readFromFile(String tag)
  {
    String[] data = loadStrings("data/dataTags/" + dir + ".txt");
    String result = "";
    
    int n = data.length;
    for(int b = 0; b < n; b++)
    {
      result = "";
      for(int a = 0; a < tag.length(); a++)
      {
        result += data[b].charAt(a);
      }
      
      if(result.equals(tag))
      {
        b = n + 10;
      }
      else
      {
        result = "";
      }
    }
    return result;
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
  
  PImage getImage(String dir, int x, int y, int cw, int ch)
  {
    x -= 1;
    y -= 1;
    
    PImage loadImg = loadImage(dir);
    PGraphics img = createGraphics(cw, ch);
    
    //load pixels
    loadImg.loadPixels();
    
    img.beginDraw();
    for(int dy = x*ch; dy < ch + x*ch; dy++) 
    {
      for(int dx = y*cw; dx < cw + y*cw; dx++)
      {
        int loc = (dx + x) + (dy + y)*loadImg.width;
        
        float r = red(loadImg.pixels[loc]);
        float g = green(loadImg.pixels[loc]);
        float b = blue(loadImg.pixels[loc]);
        
        img.set(dx - x, dy - y, color(r, g, b));
      }
    }
    loadImg.updatePixels();
    img.endDraw();

    return img;
  }
}