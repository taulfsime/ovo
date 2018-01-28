class file
{
  file() {}
}

class picture extends file
{
  String author;
  String name;
  color pixel[][] = new color[100][100];
  picture(String author, String name)
  {
    this.author = author;
    this.name = name;
  }
  
  void setPicture(color[][] p)
  {
    pixel = p;
  }
  
  color[][] getPicture()
  {
    return pixel;
  }
}