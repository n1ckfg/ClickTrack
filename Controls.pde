int skipVal = 100;

void keyPressed() {
  if (key=='0' || key=='1' || key=='2' || key=='3' || key=='4' || key=='5' || key=='6' || key=='7' || key=='8' || key=='9') {
    notes.add(new Note(int(""+key), currentTime));
  }
  
  if (key=='s' || key=='S') {
    outputWrite();
  }
  
  if (key=='r' || key=='R') {
    outputSetup();
  }
  
  if (key==' ') {
    println("rewind: " + currentTime);
    player.rewind();
    if (!player.isPlaying()) player.play();
  }
  
  if (key=='k' || key=='K') {
    if (player.isPlaying()) {
      println("pause: " + currentTime);
      player.pause();
    } else {
      println("play: " + currentTime);
      player.play();
    }
  }
}

void updateControls() {
  if (keyPressed) {
    if (key=='j' || key=='J') {
      doSkip(-3 * skipVal);
    }
    
    if (key=='l' || key=='L') {
      doSkip(skipVal);
    }
  }
}

void doSkip(int val) {
  if (!player.isPlaying()) player.play();
  player.skip(val);
  println("skip: " + currentTime);
}