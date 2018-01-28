class example extends application
{
  layout layout;
  button button;
  label label;
  textField textField;
  switchButton switchButton;
  progressBar progressBar;
  slider slider;
  itemList itemList; 
  checkBox checkBox1;
  checkBox checkBox2;
    
  void init()
  {
    //register component
    layout = new layout(500, 500);
                                           //+40
    button = new button                (20, 20, 100, 30, "Button");
    label = new label                  (20, 60, 100, 30, "Label");
    switchButton = new switchButton    (20, 100, 100, 30, "SwitchButton");
    progressBar = new progressBar      (20, 140, 100, 30);
    slider = new slider                (20, 180, 100, 30);
    itemList = new itemList            (150, 220, 100, 300);
    textField = new textField            (20, 260, 100, 30, "Text Field");
    checkBox1 = new checkBox           (20, 300, 100, 30,  "CheckBox1");
    checkBox2 = new checkBox           (20, 340, 100, 30,  "CheckBox2");
    
    //Custom settings
    itemList.addItem("iwan1");
    itemList.addItem("iwan2");
    itemList.addItem("iwan3");
    itemList.addItem("iwan4");
    progressBar.showPercentage(true);
    slider.showPercentage(true);
    progressBar.setColor(150, 0, 255);
    
    button.bindKey(ENTER);
    
    //add component to layout
    layout.addComponent(button);
    layout.addComponent(label);
    layout.addComponent(switchButton);
    layout.addComponent(progressBar);
    layout.addComponent(slider);
    layout.addComponent(itemList);
    layout.addComponent(textField);
    layout.addComponent(checkBox1);
    layout.addComponent(checkBox2);
  }
    
  void update()
  {
    setLayout(layout);

    itemList.setOpen(switchButton.isClicked);
    
    progressBar.setProgress(slider.getPercentage());
  } //<>//
}