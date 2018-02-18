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
        String test = d.substring(0, data.length());
        
        if(checkStrings(data, test))
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
    String[] data = loadStrings("data/tags/" + dir + ".txt");
    if(data.length <= 0)
    {
      createOutput("data/tags/" + dir + ".txt");
    }
    this.dir = dir;
  }
  
  void writeToFile(String tag, String info)
  {
    String[] data = loadStrings("data/tags/" + dir + ".txt");
    if(readFromFile(tag).length() <= 0)
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
        if(checkStrings(data[a].substring(0, tag.length()), tag))
        {
          println(data[a].substring(0, tag.length()));
          data[a] = tag + "=" + info;
          break;
        }
      }
      saveStrings("data/tags/" + dir + ".txt", data);
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
      String[] t1 = split(data[b], ' ');
      for(String s : t1)
      {
        if(s.length() > 0)
        {
          t = s;
          break;
        }
      }
      
      if(t.length() < tag.length())
      {
        return "";
      }
      
      //Get tag from text
      for(int a = 0; a < tag.length(); a++)
      {
        testTag += t.charAt(a);
      }
      
      //Check tags  
      if(checkStrings(tag, testTag))
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
    return "";
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