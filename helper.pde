class dataReader
{
  String readData(String type, String name, String path, String dir)
  {
    String data = type + "." + name + "." + path;
    String[] loadData = loadStrings(dir);
    
    for(String d : loadData)
    {
      if(d.length() > 0)
      {
        String test = "";
        for(int a = 0; a < d.length() && a < data.length(); a++)
        {
          test += d.charAt(a);
        }
        
        if(test.length() > 0 && checkStrings(data, test))
        {
          test = d.substring(data.length());
         
         for(int a = 0; a < test.length(); a++)
         {
           if(test.charAt(a) != ' ' && test.charAt(a) != '=')
           {
             test = test.substring(a);
             break;
           }
         }
          return test;
        }
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
    if(!isFileExist("data/tags/" + dir + ".txt"))
    {
      createOutput("data/tags/" + dir + ".txt");
    }
    
    this.dir = dir;
  }
  
  void toTag(String tag, String info)
  {
    String[] data = loadStrings("data/tags/" + dir + ".txt");
    if(getTag(tag).length() <= 0)
    {
      String[] newData = new String[data.length + 1];
      for(int a = 0; a < data.length; a++)
      {
        newData[a] = data[a];
      }
      newData[data.length] = tag + "=" + info;
      saveStrings("data/tags/" + dir + ".txt", newData);
    }
    else
    {
      for(int a = 0; a < data.length; a++)
      {
        String s = split(data[a], '=')[0];
        
        if(checkStrings(s, tag))
        {
          data[a] = tag + "=" + info;
          break;
        }
      }
      saveStrings("data/tags/" + dir + ".txt", data);
    }
  }
  
  void clear()
  {
    createOutput("data/tags/" + dir + ".txt");
  }
  
  void removeTag(String tag)
  {
    String[] data = loadStrings("data/tags/" + dir + ".txt");
    if(getTag(tag).length() > 0)
    {
      String[] newData = new String[data.length - 1];
      int n = 0;
      for(int a = 0; a < data.length; a++)
      {
        String s = split(data[a], '=')[0];
        if(!checkStrings(s, tag))
        {
          newData[n] = data[a];
          n++;
        }
      }
      saveStrings("data/tags/" + dir + ".txt", newData);
    }
  }
  
  String getTag(String tag)
  {
    String[] data = loadStrings("data/tags/" + dir + ".txt");
    
    for(String s : data)
    {
      String testTag = split(s, '=')[0];
      if(checkStrings(testTag, tag))
      {
        return split(s, '=')[1];
      }
    }
    return "";
  }
  
  String[] getTags()
  {
    String[] data = loadStrings("data/tags/" + dir + ".txt");
    String[] returnData = new String[data.length];
    
    for(int a = 0; a < data.length; a++)
    {
      returnData[a] = split(data[a], '=')[0];
    }
    
    return returnData;
  }
}