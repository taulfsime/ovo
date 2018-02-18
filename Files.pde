class file
{
  String name;
  file(String name) 
  {
    this.name = name;
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
    String[] saves = new String[p.length];
    for(int line = 0; line < p.length; line++)
    {
      saves[line] = (int) red(p[line]) + "-" + (int) green(p[line]) + "-" + (int) blue(p[line]);
    }
    
    saveStrings("data/files/pictures/" + name + ".txt", saves);
  }
  
  color[] read()
  {
    color[] p = new color[10000];
    String[] loadFile = loadStrings("data/files/pictures/" + name + ".txt");
    for(int line = 0; line < loadFile.length; line++)
    {
      String[] ch = split(loadFile[line], '-');
      
      int c1 = Integer.parseInt(ch[0]);
      int c2 = Integer.parseInt(ch[1]);
      int c3 = Integer.parseInt(ch[2]);
      
      p[line] = color(c1, c2, c3);
    }
    
    return p;
  }
}