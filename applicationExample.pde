class example extends application
{
  //ArrayList<bubble> info = new ArrayList<bubble>();
  
  button button;
  label label;
  textArea textArea;
  switchButton switchButton;
  progressBar progressBar;
  slider slider;
  itemList itemList;
  layout layout;
  checkBox checkBox1;
  checkBox checkBox2;
  checkBox checkBox3;
  checkBox checkBox4;
  radioGroup radioGroup; 
    
  void preinit()
  {
    //register component
    layout = new layout(x, y, w, h);
                                           //+40
    button = new button                (20, 20, 100, 30, "Button");
    label = new label                  (20, 60, 100, 30, "Label");
    switchButton = new switchButton    (20, 100, 100, 30, "SwitchButton");
    progressBar = new progressBar      (20, 140, 100, 30);
    slider = new slider                (20, 180, 100, 30);
    itemList = new itemList            (20, 220, 100, 30, "test");
    textArea = new textArea            (20, 260, 100, 30);
    checkBox1 = new checkBox           (20, 300, 100, 30,  "test1");
    checkBox2 = new checkBox           (20, 340, 100, 30,  "test2");
    checkBox3 = new checkBox           (20, 380, 100, 30,  "test3");
    checkBox4 = new checkBox           (20, 420, 100, 30,  "test4");
    radioGroup = new radioGroup        ();
    
    //Custom settings
    itemList.addItem("iwan1");
    itemList.addItem("iwan2");
    itemList.addItem("iwan3");
    itemList.addItem("iwan4");
    progressBar.showPercentage(true);
    slider.showPercentage(true);
    radioGroup.addItem(checkBox1);
    radioGroup.addItem(checkBox2);
    radioGroup.addItem(checkBox3);
    radioGroup.addItem(checkBox4);
    
    //add component to layout
    layout.addComponent(button);
    layout.addComponent(label);
    layout.addComponent(switchButton);
    layout.addComponent(progressBar);
    layout.addComponent(slider);
    layout.addComponent(itemList);
    layout.addComponent(textArea);
    layout.addComponent(checkBox1);
    layout.addComponent(checkBox2);
    layout.addComponent(checkBox3);
    layout.addComponent(checkBox4);
    layout.addComponent(radioGroup);
  }
    
  void init()
  {
    setLayout(layout);
    radioGroup.show();
    
    progressBar.setProgress(slider.getPercentage());
  } //<>//
}