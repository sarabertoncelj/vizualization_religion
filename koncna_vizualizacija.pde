import controlP5.*;
ControlP5 controlP5;

class Person {
  
  int age;
  int gender;
  float religious_conviction; // 0 (least religous) - 1 (most religios)
  float views_on_lgbt; // 0 (negative) - 1 (positive)
  float views_on_womensrights; // 0 (negative) - 1 (positive)
  float views_on_immigration; // 0 (negative) - 1 (positive)
  float views_on_otherreligions; // 0 (negative) - 1 (positive)
  float progressive; // 0 (most conservative) - 1 (most progressive)
  
  Person (int age, int gender, float religious, float lgbt, float women, float other){
    this.age = age; 
    this.gender = gender;
    this.religious_conviction = religious;
    this.views_on_lgbt = lgbt;
    this.views_on_womensrights = women;
    this.views_on_otherreligions = other;
  }

}

class Religion {
  String name;
  ArrayList<Person> people;
  int avg_age;
  float female;
  float male;
  float avg_conviction;
  float avg_lgbt;
  float avg_womensrights;
  float avg_otherreligions;
  
  Religion (String religion){
    this.name = religion;
    this.people = new ArrayList<Person>();
  }
  void add_person (int age, int gender, float religious, float lgbt, float women, float other){
    this.people.add(new Person(age, gender, religious, lgbt, women, other));
  }
  String get_religion(){
    return name;
  }
  void set_lgbt(float lgbt){
    this.avg_lgbt = lgbt;
  }
  void set_womensrights(float wr){
    this.avg_womensrights = wr;
  }
  void set_otherreligions(float other){
    this.avg_otherreligions = other;
  }
  void set_female(float f){
    this.female = f;
  }
  void set_male(float m){
    this.male = m;
  }
  void set_age(int age){
    this.avg_age = age;
  }
  
}

Religion[] religion;
Table table;
float w_main;
int spacing;
float offset;
float w_bar;


void setup() {
  background(255, 255, 255);
  fullScreen();
  noStroke();
  
  table = loadTable("east.csv", "header");
  religion = new Religion [8];
  religion[0] = new Religion ("Orthodox");
  religion[1] = new Religion ("Catholic");
  religion[2] = new Religion ("Protestant");
  religion[3] = new Religion ("Jehovah's\nWitnesses");
  religion[4] = new Religion ("Other\nChristian");
  religion[5] = new Religion ("Muslim");
  religion[6] = new Religion ("Atheist/\nagnostic");
  religion[7] = new Religion ("Other");
  
   
  w_main = width*0.75;
  spacing = religion.length + 1;
  
  offset = ((w_main/spacing)*0.35);
  w_bar = (0.55*offset);
  
  
  
  controlP5 = new ControlP5(this);
  controlP5.setColorForeground(0xff332d44);
  controlP5.setColorBackground(0xab332d44);
  controlP5.setColorActive(0xff332d44);
  PFont p = createFont("Verdana",30); 
  ControlFont font = new ControlFont(p);
  controlP5.setFont(font);
  
  controlP5.addSlider("", 0, 1, 0.5, int((w_main/spacing)-offset), 200, int(((w_main/spacing)*(religion.length))-((w_main/spacing)-2*offset)), int(w_bar));
  float[] religious_conviction = {-2.0, -2.0, -2.0, -2.0}; // services, prayer, importance, belief;
  float[] views_on_lgbt = {-2.0, -2.0, -2.0};
  float[] views_on_womensrights = {-2.0, -2.0, -2.0, -2.0, -2.0, -2.0};
  float[] views_on_otherreligions = {-2.0, -2.0, -2.0, -2.0, -2.0, -2.0, -2.0, -2.0, -2.0, -2.0, -2.0, -2.0};
  int rel_index = 0;
  
  
  for (TableRow row : table.rows()) {
    //strength of religion    
    if (row.getInt("Q41") < 98) religious_conviction[0] = (6.0 - row.getInt("Q41"))/5.0;
    if (row.getInt("Q54") < 98) religious_conviction[1] = (7.0 - row.getInt("Q54"))/6.0;
    if (row.getInt("Q44") < 98) religious_conviction[2] = (4.0 - row.getInt("Q44"))/3.0;
    if (row.getInt("Q51") == 1 && row.getInt("Q52") < 98) religious_conviction[3] = (5.0 - row.getInt("Q52"))/4.0;
    else if (row.getInt("Q51") == 98) religious_conviction[3] = 0.0;
    else if (row.getInt("Q51") == 2)religious_conviction[3] = 0.0; 
    
    //viewes on lgbt    
    if (row.getInt("Q10") < 98) views_on_lgbt[0] = (4.0 - row.getInt("Q10"))/3.0;
    else if (row.getInt("Q10") == 98) views_on_lgbt[0] = 0.5;
    if (row.getInt("Q64") == 1) views_on_lgbt[1] = 1.0;
    else if (row.getInt("Q64") == 2) views_on_lgbt[1] = 0.0;
    else if (row.getInt("Q64") == 98) views_on_lgbt[1] = 0.5;
    if (row.getInt("Q71h") == 1 || row.getInt("Q71h") == 3) views_on_lgbt[1] = 1.0;
    else if (row.getInt("Q71h") == 4 || row.getInt("Q71h") == 98) views_on_lgbt[1] = 0.5;
    else if (row.getInt("Q71h") == 2) views_on_lgbt[1] = 0.0;
    
    //viewes on womens rights    
    if (row.getInt("Q11") < 98) views_on_womensrights[0] = (4.0 - row.getInt("Q11"))/3.0;
    else if (row.getInt("Q11") == 98) views_on_womensrights[0] = 0.5;
    if (row.getInt("Q16c") < 98) views_on_womensrights[1] = (row.getInt("Q16c") - 1.0)/3.0;
    else if (row.getInt("Q16c") == 98) views_on_womensrights[1] = 0.5;
    if (row.getInt("Q16d") < 98) views_on_womensrights[2] = (row.getInt("Q16d") - 1.0)/3.0;
    else if (row.getInt("Q16d") == 98) views_on_womensrights[2] = 0.5;
    if (row.getInt("Q71b") == 1 || row.getInt("Q71b") == 3) views_on_womensrights[3] = 1.0;
    else if (row.getInt("Q71b") == 4 || row.getInt("Q71b") == 98) views_on_womensrights[3] = 0.5;
    else if (row.getInt("Q71b") == 2) views_on_womensrights[3] = 0.0;
    if (row.getInt("Q71e") == 1 || row.getInt("Q71e") == 3) views_on_womensrights[4] = 1.0;
    else if (row.getInt("Q71e") == 4 || row.getInt("Q71e") == 98) views_on_womensrights[4] = 0.5;
    else if (row.getInt("Q71e") == 2) views_on_womensrights[4] = 0.0;
    
    //views on other religons
    
    //if (row.getInt("Q63a") == 1) views_on_otherreligions[6] = 1.0;
    //else if (row.getInt("Q63a") == 98 || row.getInt("Q63a") == 3) views_on_otherreligions[6] = 0.5;
    //else if (row.getInt("Q63a") == 2) views_on_otherreligions[6] = 0.0;
    //if (row.getInt("Q63b") == 1) views_on_otherreligions[7] = 1.0;
    //else if (row.getInt("Q63b") == 98 || row.getInt("Q63b") == 3) views_on_otherreligions[7] = 0.5;
    //else if (row.getInt("Q63b") == 2) views_on_otherreligions[7] = 0.0;
    //if (row.getInt("Q63c") == 1) views_on_otherreligions[8] = 1.0;
    //else if (row.getInt("Q63c") == 98 || row.getInt("Q63c") == 3) views_on_otherreligions[8] = 0.5;
    //else if (row.getInt("Q63c") == 2) views_on_otherreligions[8] = 0.0;
    if (row.getInt("Q65") < 97) views_on_otherreligions[0] = (row.getInt("Q65") -1.0)/3.0;
    if (row.getInt("Q66a") < 97) views_on_otherreligions[1] = (row.getInt("Q66a") -1.0)/3.0;
    if (row.getInt("Q66b") < 97) views_on_otherreligions[2] = (row.getInt("Q66b") -1.0)/3.0;
    if (row.getInt("Q66c") < 97) views_on_otherreligions[3] = (row.getInt("Q66c") -1.0)/3.0;
    if (row.getInt("Q66f") < 97) views_on_otherreligions[3] = (row.getInt("Q66f") -1.0)/3.0;
    
    if (row.getInt("QCURRELrec") == 2 || row.getInt("QCURRELD") == 2) {
      rel_index = 5;
      religious_conviction[0] = (6.0 - row.getInt("Q41"))/5.0;
    }
    else if (row.getInt("QCURRELrec") == 1 || row.getInt("QCURRELC") == 1 || row.getInt("QCURRELD") == 1){
      if (row.getInt("QDENOMrec") == 1 || row.getInt("QDENOMrec") == 22 || row.getInt("QDENOMrec") == 21){
        rel_index = 0;
      }
      else if (row.getInt("QDENOMrec") == 2){
        rel_index = 1;
      }
      else if (row.getInt("QDENOMrec") == 3 || row.getInt("QDENOMrec") == 10 || row.getInt("QDENOMrec") == 6
                || row.getInt("QDENOMrec") == 7  || row.getInt("QDENOMrec") == 8){
        rel_index = 2;
      }
      else if (row.getInt("QDENOMrec") == 4){
        rel_index = 3;
      }
      else {
        rel_index = 4;
      }
    }
    else if (row.getInt("QCURRELrec") == 9 || row.getInt("QCURRELrec") == 10 || row.getInt("QCURRELrec") == 92) {
      rel_index = 6;
      if (row.getInt("Q51") == 98) religious_conviction[3] = 0.5;
    }
    else {
      rel_index = 7;
    }
    float rc = 0.0;
    float lgbt = 0.0;
    float wr = 0.0;
    float other = 0.0;
    int count = 0;
    for (int i = 0; i < religious_conviction.length; i++){
      if (religious_conviction[i] != -2.0){
        rc += religious_conviction[i];
        count++;
      }
    }
    rc = rc/count;
    if (rel_index == 6) rc = rc;
    count = 0;
    for (int i = 0; i < views_on_lgbt.length; i++){
      if (views_on_lgbt[i] != -2.0){
        lgbt += views_on_lgbt[i];
        count++;
      }
    }
    lgbt = lgbt/count;
    count = 0;
    for (int i = 0; i < views_on_womensrights.length; i++){
      if (views_on_womensrights[i] != -2.0){
        wr += views_on_womensrights[i];
        count++;
      }
    }
    wr = wr/count;
    
    count = 0;
    for (int i = 0; i < views_on_otherreligions.length; i++){
      if (views_on_otherreligions[i] != -2.0){
        other += views_on_otherreligions[i];
        count++;
      }
    }
    other = other/count;
    
    float max = 1.0;
    float min = 0.0;
    if (rc >= min && rc <= max) religion[rel_index].add_person(row.getInt("QAGE"), row.getInt("QGEN"), rc, lgbt, wr, other);
  }
  update(0.0, 1.0);
}
void update(float min, float max){
  for (int i = 0; i < 8; i++){
    int avg_age = 0;
    float avg_rc = 0.0;
    float avg_lgbt = 0.0;
    float avg_wr = 0.0;
    float avg_other = 0.0;
    int count_age = 0;
    int count = 0;
    float male = 0;
    float female = 0;
    if (religion[i].people.size()>0){
      for (Person person : religion[i].people) {
        if (person.religious_conviction >= min && person.religious_conviction <= max){
          count ++;
          avg_rc += person.religious_conviction;
          avg_lgbt += person.views_on_lgbt;
          avg_wr += person.views_on_womensrights;
          avg_other += person.views_on_otherreligions;
          if (person.age < 98){
            avg_age += person.age;
            count_age ++;   
          }
          if (person.gender == 1) male ++;
          else if (person.gender == 2) female ++;
        }
      }
      religion[i].set_lgbt(avg_lgbt/count);
      religion[i].set_womensrights(avg_wr/count);
      religion[i].set_otherreligions(avg_other/count);
      religion[i].set_female(female/(male+female));
      religion[i].set_male(male/(male+female));
      println(religion[i].name + ": " + count + ", level: " + avg_rc/religion[i].people.size()
                                      + ", views on lgbt people: " + religion[i].avg_lgbt
                                      + ", views on womens rights: " + religion[i].avg_womensrights
                                      + ", views on other religions: " + religion[i].avg_otherreligions);
      avg_age = avg_age/count_age;
      println("average age: " + avg_age + ", female: " + female/(male+female) + ", male: " + male/(male+female));
      religion[i].set_age(avg_age);
    }
  }
}
void draw() {
  background(255, 255, 255);
  textSize(50);
  textAlign(CENTER);
  //text("importance of religion and strenght of faith", w_main/spacing*(religion.length+1)/2, 100);
  textSize(30);
  fill(92, 82, 123);
  textAlign(LEFT);
  text("not very religious", w_main/spacing-offset, 180);
  textAlign(CENTER);
  text("moderatly religious", w_main/spacing*(religion.length+1)/2, 180);
  textAlign(RIGHT);
  text("extremly religious", w_main/spacing*(religion.length)+offset, 180);
  
  for (int i = 0; i < religion.length; i++) {
    textSize(40);
    textAlign(CENTER);
    fill(92, 82, 123);
    text(religion[i].name, w_main/spacing*(i+1), height-450);
    float lgbt_bar_h = (height-800)*religion[i].avg_lgbt;
    float wr_bar_h = (height-800)*religion[i].avg_womensrights;
    float other_bar_h = (height-800)*religion[i].avg_otherreligions;
    float x = (w_main/spacing*(i+1));
    rectMode(CORNERS);
    fill(165, 153, 181);
    rect(x-offset, height-500-lgbt_bar_h, x-(offset-w_bar), height-500);
    
    fill(172, 216, 170);
    rect(x+(w_bar/2), height-500, x-(w_bar/2), height-500-wr_bar_h);
    fill(244, 132, 152);
    rect(x+(offset-w_bar), height-500, x+offset, height-500-other_bar_h);
    float[] angles = {religion[i].female * 360.0, religion[i].male*360.0}; 
    pieChart(x, height-200, 180, angles);    
    fill(92, 82, 123);
    textSize(30);
    textAlign(CENTER);
    if (religion[i].female > 0 || religion[i].male > 0) text("age\n" + religion[i].avg_age, x, height-215);
    else text("no people\nwith this conviction", x, height-215);
  }
  for (int i = 0; i < religion.length; i++) {
    float lgbt_bar_h = (height-800)*religion[i].avg_lgbt;
    float wr_bar_h = (height-800)*religion[i].avg_womensrights;
    float other_bar_h = (height-800)*religion[i].avg_otherreligions;
    float x = (w_main/spacing*(i+1));
    rectMode(CORNERS);
  
    if (overRect(x-offset, height-500-lgbt_bar_h, x-(offset-w_bar), height-500)) {  
      fill(92, 82, 123);
      text(religion[i].avg_lgbt, w_main/spacing-offset-50, height-500-lgbt_bar_h);
      rect(w_main/spacing-offset, height-500-lgbt_bar_h, w_main/spacing*religion.length+offset, height-500-lgbt_bar_h-5);
    }
  
    if (overRect(x-(w_bar/2), height-500-wr_bar_h, x+(w_bar/2), height-500)) {  
      fill(92, 82, 123);
      text(religion[i].avg_womensrights, w_main/spacing-offset-50, height-500-wr_bar_h);
      rect(w_main/spacing-offset, height-500-wr_bar_h, w_main/spacing*religion.length+offset, height-500-wr_bar_h-5);
    }
    
    if (overRect(x+(offset-w_bar), height-500-other_bar_h, x+offset, height-500)) {  
      fill(92, 82, 123);
      text(religion[i].avg_otherreligions, w_main/spacing-offset-50, height-500-other_bar_h);
      rect(w_main/spacing-offset, height-500-other_bar_h, w_main/spacing*religion.length+offset, height-500-other_bar_h-5);
    }
  }
  
  textAlign(CENTER);
  textSize(60);
  float w_legenda = width-w_main-spacing;
  float x = (w_legenda-offset);
  text("Effects of\nRELIGIOUS CONVICTIONS\non attitudes towards\nmarginalized groups in society", w_main+(x/2), 180);
  
  textSize(30);
  textAlign(LEFT);
  rectMode(CORNERS);
  fill(165, 153, 181);
  rect(w_main, 180+360, w_main+x*0.2, 180+410);   
  fill(92, 82, 123);
  text("acceptance of same-sex attraction", w_main+(x*0.25), 180 + 400);
  
  fill(172, 216, 170);
  rect(w_main, 180+460, w_main+x*0.2, 180+510);    
  fill(92, 82, 123);
  text("support for equality between sexes", w_main+(x*0.25), 180 + 500);
  
  fill(244, 132, 152); 
  rect(w_main, 180+560, w_main+x*0.2, 180+610);   
  fill(92, 82, 123);
  text("acceptance of different ethnicities", w_main+(x*0.25), 180 + 600);
  float r = 80;
  fill(255, 176, 140);
  ellipse(w_main+x*0.1, 180+700, r, r);
  fill(255, 255, 255);
  ellipse(w_main+x*0.1, 180+700, r*0.4, r*0.4);
  fill(92, 82, 123);
  text("percentage of women", w_main+(x*0.25), 180 + 700);
  fill(177, 223, 226);
  ellipse(w_main+x*0.1, 180+800, r, r);
  fill(255, 255, 255);
  ellipse(w_main+x*0.1, 180+800, r*0.4, r*0.4);
  fill(92, 82, 123);
  text("percentage of men", w_main+(x*0.25), 180 + 800);
  
  
  if (keyPressed) { 
    if (key == 27) { //The ASCII code for esc is 27
      exit();
    }
  } 
}
void pieChart(float w, float h, float diameter, float[] data) {
  float lastAngle = 0;
  for (int i = 0; i < data.length; i++) {
    if (i == 0) fill(255, 176, 140);
    else fill(177, 223, 226);
    arc(w, h, diameter, diameter, lastAngle, lastAngle+radians(data[i]));
    lastAngle += radians(data[i]);
  }
  fill(255, 255, 255);
  ellipse(w, h, diameter*0.7, diameter*0.7);
}

boolean overRect(float x, float y, float x2, float y2) {
  if (mouseX >= x && mouseX <= x2 && 
      mouseY >= y && mouseY <= y2) {
    return true;
  } else {
    return false;
  }
}


void controlEvent(ControlEvent theEvent) {
 
 if(theEvent.isController()) { 
 
   print("control event from : "+theEvent.getController().getName());
   println(", value : "+theEvent.getController().getValue());
  
   if(theEvent.getController().getName()=="") {
   update(theEvent.getController().getValue()-0.1,theEvent.getController().getValue()+0.1);
   }
 } 
}
