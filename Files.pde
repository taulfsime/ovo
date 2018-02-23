class file
{
  String name;
  file(String name) 
  {
    this.name = name;
  }
}

class dtext extends file
{
  dtext(String name)
  {
    super(name);
  }
  
  void save(String[] s)
  {
    saveStrings("data/files/dtext/" + name + ".txt", s);
  }
  
  String[] load()
  {
    String d = "data/files/dtext/" + name + ".txt";
    if(isFileExist(d))
    {
      return loadStrings(d);
    }
    return null;
  }
}

class picture extends file
{
  picture(String name)
  {
    super(name);
  }
  
  void save(color[] p)
  {
    ArrayList<String> save = new ArrayList<String>();
    
    int s = 1;
    for(int a = 0; a < p.length - 1; a++)
    {
      if(p[a] == p[a + 1])
      {
        if(a == p.length - 2)
        {
          save.add(p[a] + (s == 1 ? "" : "^" + s));
          break;
        }
        s++;
      }
      else
      {
        save.add(p[a] + (s == 1 ? "" : "^" + s));
        s = 1;
      }
    }
    
    save.add(p[p.length - 1] + "");
    
    String[] sv = new String[save.size()];
    
    for(int a = 0; a < save.size(); a++)
    {
      sv[a] = save.get(a);
    }
    
    saveStrings("data/files/pictures/" + name + ".pic", sv);
  }
  
  color[] load()
  {
    if(isFileExist("data/files/pictures/" + name + ".pic"))
    {
      ArrayList<Integer> p = new ArrayList<Integer>();
      String[] loadFile = loadStrings("data/files/pictures/" + name + ".pic");
      for(String s : loadFile)
      {
        boolean hasCh = false;
        for(int a = 0; a < s.length(); a++)
        {
          if(s.charAt(a) == '^')
          {
            hasCh = true;
            break;
          }
        }
        
        if(hasCh)
        {
          String[] t = split(s, '^');
          for(int a = 0; a < Integer.parseInt(t[1]); a++)
          {
            p.add(Integer.parseInt(t[0]));
          }
        }
        else
        {
          p.add(Integer.parseInt(s));
        }
      }
      
      color[] c = new color[p.size()];
      for(int a = 0; a < p.size(); a++)
      {
        c[a] = p.get(a);
      }
      return c;
    }
    
    return null;
  }
  
  color[] customLoad(String file)
  {
    PImage img = loadImage("data/files/pictures/" + file);
    
    return img.pixels;
  }
}