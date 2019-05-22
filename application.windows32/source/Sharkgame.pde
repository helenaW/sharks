/////Sharks
/////by Helena Winkler
/////13.03.2018


ArrayList mySharks; // ArrayList to put all my sharks in.
ArrayList scorePrettifiers; // ArrayList to put all the pretty +1 and -1 notices above the score


PImage shark;
PImage sharkDead;

int score; //Killscore
int timeStamp;

int totalSharks; // How many sharks were ever spawned?
int maxSharks = 50; // How many sharks before the game ends?
PImage bg1;//Hintergrundbild

boolean started;




void setup(){
  size(596,842);// Bildschirm zeichen
  smooth();
  frameRate(30);
  started = false;
  cursor(CROSS); // make the cursor look like a cross
  
  mySharks = new ArrayList();
  scorePrettifiers = new ArrayList();
  
  shark = loadImage("data/sharkBest.png");
  sharkDead = loadImage("data/deadsharkBetter.png");
  bg1 = loadImage("data/sea.png");
  timeStamp = millis();
  score = 0;
  
}//end setup

void draw(){
 background(bg1);
 textSize(32);
 fill(0);
 text("Quick! Dangerous Shark!", 134, 344);
 text("Shoot them all. ", 210, 400);
 noFill();
 rect(291, 436, 90, 49);
 text("Start", 300, 471);
 
 if(started){
   background(bg1);
  //////////////////////////////////////
  ////////// ADDING SHARKS ////////////
  //////////////////////////////////////
  for (int i = 0; i < mySharks.size(); i++) {
    Shark t = (Shark)mySharks.get(i);
    t.display();
  }

  // Display score prettifiers
  for (int i = 0; i < scorePrettifiers.size(); i++) {
    scorePrettifier s = (scorePrettifier) scorePrettifiers.get(i);
    s.display();
    if (s.y > height-40) {
      s.y--;
    }
    else {
      scorePrettifiers.remove(i);
    }
  }
 
  
  // Counter
  int passedTime = millis() - timeStamp;

  if (passedTime >= random(300, 4000) && totalSharks < maxSharks) { // If 0.5 to 2 seconds have passed since the last target was placed..
    mySharks.add(new Shark(random(0, width-60), random(0, height-80)));
    totalSharks++;
    timeStamp = millis(); // Reset the timer.
  }
  
 ////////////////////////////////
  /////// REMOVING SHARKS ///////
  ////////////////////////////////
  if (mySharks.size() == 5) { // If there's 5 sharks on scene
      mySharks.remove(0); // Remove the oldest one
  }
  
 ////////////////////////////////
  //////////// SCORE /////////////
  ////////////////////////////////
  if (totalSharks < maxSharks) {
    noStroke();
    fill(0, 0, 0, 200);
    rect(0, height-20, width, 20);
    fill(255);
    textSize(12);
    text("SCORE: " + score, 10, height-5);
  }
 ////////////////////////////////
  ////////// END GAME ////////////
  ////////////////////////////////
  if (totalSharks >= maxSharks) {
    // Remove remaining Sharks
    for (int i = 0; i < mySharks.size(); i++) {
      Shark s = (Shark) mySharks.get(i);
      mySharks.remove(i);
    }
    
    // End game text
    background(0);
    fill(255);
    textAlign(CENTER);
    textSize(24);
    text("Game over!", 267, 80);
    text("You killed: " + score+" sharks", 272, 113);
    text("Humans killed by sharks: 12 a year", 294, 195);
    text("Sharks killed by humans: 190 a minute", 297, 234);
    text("Sharks are not a danger to humans and", 293, 323);
    text("still we hunt them to almost extinction.", 290, 363);
    text("Reasons for killing them are often for food, as", 294, 402);
    text("by-catch or to get the new surf area shark-free.", 292, 441);
    text("But are those really good reasons", 307, 527);
    text("or is it time for a change?", 306, 563);
  }
 }
}//end draw




class Shark{
  boolean alive;
  float x, y, w, h;
  
  
  //constr
  Shark(float ranX, float ranY){
    x= ranX;
    y= ranY;
    w = 60;
    h = 80;
    alive = true;
  }
  //func
  void dead(){
    alive = false;
  }
  boolean life(){
    return alive;
  }
  
  void display(){
    if(alive){
      noStroke();
      image(shark, x, y, w, h);
      fill(256,0,0); // red
      ellipse(x+30, y+60, w*0.5, w*0.5); // Draw the target with the properties passed as argument.
      fill(255);
      ellipse(x+30, y+60, w*0.3, w*0.3);    
      fill(256,0,0);
      ellipse(x+30, y+60, w*0.1, w*0.1);
    }else{
      image(sharkDead, x, y,w,h);
    }
  }
  
}



 /////////////////////////////////
/////// SCORE PRETTIFIER ////////
/////////////////////////////////
class scorePrettifier {
  // properties
  float x = 20;
  float y = height-20;
  float a = 255;

  // constructor
  scorePrettifier() {
  }

  // functions
  void display() {
    fill(0, 200, 0, a);
    textSize(12);
    text("+1", x, y);
  }
}



void mousePressed() {
    if(!started){
      if((mouseX>291  && mouseX<381 )&&(mouseY>436 && mouseY< 485)){
        started = true;
      }
    }
    for (int i = 0; i < mySharks.size(); i++) {
      Shark t = (Shark) mySharks.get(i);
      float distance = dist(mouseX, mouseY, t.x+30, t.y+60);

      if (distance < t.w*0.5) {
       if(t.life()){
        score++;
        t.dead();
        scorePrettifiers.add(new scorePrettifier());
       }
      }
    }
 
}
