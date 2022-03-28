import processing.sound.*;
import oscP5.*;
import netP5.*;

OscP5 oscP5;
SoundFile kick;
SoundFile glass;
SoundFile water;
SoundFile bell;

//float lastDetectedClass = -1;
float lastDetectedClass = 0;


void setup() {
  size(640, 360);
  background(255);


  oscP5 = new OscP5(this, 12000);


  // Load a soundfile from the /data folder of the sketch and play it back
  //Objekt wird gebaut
  kick = new SoundFile(this, "kick.wav");
  //kick.play();
  
 glass = new SoundFile(this, "glass-breaking.mp3");
  //kick.play();
  
  water = new SoundFile(this, "water-filled-cup.mp3");
  
  bell = new SoundFile(this, "bell.wav");
}

void draw() {
    fill(0);
    ellipse(40, 40, 35, 35);
    fill(100);
    rect(40, 40, 40, 30);
    fill(255);
    triangle(60, 60, 20, 90, 60, 90);
}

void oscEvent(OscMessage msg) {
  String address = msg.addrPattern();

  if (address.equals("/kick")) {
    println("trigger kick");
    kick.play();
  }
  if (address.equals("/glass")) {
    println("trigger glass");
    glass.play();
    
  }
    if (address.equals("/water")) {
    println("trigger water");
    water.play();
  }
    if (address.equals("/bell")) {
    println("trigger bell");
    bell.play();
  }

  if (msg.checkAddrPattern("/wek/outputs")) {
    //println("got message "+msg.addrPattern());
    if (msg.checkTypetag("f")) {
      //float detectedClass = msg.get(0).floatValue();
       float detectedClass = msg.get(0).floatValue();
      // if nothing has changed then return function
      if (detectedClass == lastDetectedClass) {
        return;
      }
      if (detectedClass == 1) {
        kick.play();
      }
      if (detectedClass == 2) {
        glass.play();
      }
       if (detectedClass == 3) {
        water.play();
      }
      if (detectedClass == 4) {
        bell.play();
      }
       if (detectedClass == 5) {
       // bell.play();
      }
      println("last detected class: "+lastDetectedClass);
      println("detected class: "+detectedClass);
      lastDetectedClass = detectedClass;
      return;
    }
  }
}
