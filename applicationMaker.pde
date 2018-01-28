class appMaker extends application
{ 
  layout main;
  void init()
  {
    main = new layout(600, 400);
  }
  
  void update()
  {
    setLayout(main);
  }
}