import ddf.minim.*;
import java.util.Collections;

Minim minim;
AudioPlayer player;
Data output;
float currentTime = 0;
ArrayList<Note> notes;
float timeOffset = 0;
PFont font;
int fontSize = 24;

void setup() {
  size(512, 512, P2D);
  minim = new Minim(this);
  player = minim.loadFile("march.mp3");
  player.play();

  outputSetup();
  
  font = loadFont("Arial-Black-120.vlw");
  textFont(font, fontSize);
}

void draw() {
  updateControls();
  
  currentTime = (player.position() / 1000.0) + timeOffset;
  
  background(0);
  
  for (int i=0; i<notes.size(); i++) {
    notes.get(i).run();
  }  
  
  fill(200);
  text(currentTime, fontSize / 2, fontSize * 1.5);
}

void outputSetup() {
  notes = new ArrayList<Note>();
  output = new Data();
  
  try {
    output.load("output.txt");
    for (int i=0; i<output.data.length; i++) {
      String[] s = output.data[i].split(",");
      int index = int(s[0]);
      float time = float(s[1]);
      notes.add(new Note(index, time));
    }
  } catch (Exception e) { }  
}

void outputWrite() {
  output.beginSave();
  
  Collections.sort(notes);
  
  for (int i=0; i<notes.size(); i++) {
    Note n = notes.get(i);
    String s = n.index + ", " + n.startTime;
    output.add(s);
  }
  
  output.endSave("output.txt");
}