import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Minim minim;
AudioPlayer myAudio;
FFT myAudioFFT;
String song_name = "Counterattack.mp3";

BeatDetect beat;
float eRadius;

ArrayList<Pez> peces = new ArrayList();

final int CANVAS_WIDTH_DEFAULT  = 1000;
final int CANVAS_HEIGHT_DEFAULT = 700;
//-----------------------------------------
Cascada cascada;
ControlPanel controlPanel;


public void settings() {
  size(1000, 700);
}

void setup(){
  
  int canvasWidth = CANVAS_WIDTH_DEFAULT;
  int canvasHeight = CANVAS_HEIGHT_DEFAULT;
  settings();

  minim = new Minim(this);
  myAudio = minim.loadFile(song_name);
  cascada = new Cascada(minim,myAudio);
  cascada.set(0.0f, 0.0f, (float)canvasWidth * 0.8f, (float)canvasHeight);
  controlPanel = new ControlPanel(cascada, cascada.getX() + cascada.getWidth(), 0.0f, (float)canvasWidth * 0.2f, (float)canvasHeight);
  cascada.play();
  
  
  beat = new BeatDetect();
  ellipseMode(RADIUS);
  eRadius = 20;
  
}

void draw(){
  
  //background(91,48,0);
  background(#FFFFFF);
  
  cascada.calculateIce();
  cascada.draw();
  controlPanel.draw();
  
  beat.detect(myAudio.mix);
  
  if ( beat.isOnset() ){
    float xPosition = (width*0.8f) * (float)Math.random();
    
    peces.add(new Pez(xPosition, height,eRadius));
    
  }
  for (int i = 0;i<peces.size();i++){
    peces.get(i).swim();
    if(peces.get(i).getTop() && peces.get(i).getY()>=height + eRadius){
      peces.remove(i);
    }
  }
}

void mousePressed(){
  if(controlPanel.isIntersectingWith(mouseX, mouseY))
    controlPanel.onMousePressedAt(mouseX, mouseY);
}
void mouseDragged(){
  if(controlPanel.isIntersectingWith(mouseX, mouseY))
    controlPanel.onMouseDraggedTo(mouseX, mouseY);
}
