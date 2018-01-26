class appMaker extends application
{
  appMaker() {}
  data data;
  image img;
  layout l;
  
  void init()
  {
    l = new layout(800, 600);
    data = new data("");
    img = new image(10, 10, 500, 500);
    
    l.addComponent(img);
  }
  
  void update()
  {
    setLayout(l);
    img.setImage(data.getImage("textures/painter/colors.png", 2, 2, 20, 20));
  }
}