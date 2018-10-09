class Letters {

  //value of the harmonic values, each trig function is of the form
  // cos(cosHarmo*PI*t) or sin(cosHarmo*PI*t) or any combinations of both
  float cosHarmo;
  float sinHarmo;

  //array containing the possible letters that can be displayed
  String[] alphabet = { 
    "あ", "い", "う", "え", "お", 
    "か", "き", "く", "け", "こ", 
    "さ", "し", "す", "せ", "そ", 
    "た", "ち", "つ", "て", "と", 
    "な", "に", "ぬ", "ね", "の", 
    "は", "ひ", "ふ", "へ", "ほ", 
    "ま", "み", "む", "め", "も", 
    "や", "ゆ", "よ", 
    "ら", "り", "る", "れ", "ろ", 
    "わ", "を", 
    "ん"
  };
  int numLetters = alphabet.length;

  //array of the position of the letter in alphabet at each position
  int[] letter;

  //array containing the color at each position
  float[] currentCols;
  //array that store the size of each letter
  float[] letterSize;
  //float for the max letter size
  float letSizeMax;


  float[] x;
  float[] y;
  int memory = 300;
  //amplitude
  float amplitude;
  int currentFunction;
  
  //time
  float t;
  //float value that represents the increment in time used 
  float inc = 0.0005;


  Letters(float csH, float snH, float incre, int m, float amp, float lSizeMax) {
    cosHarmo = csH;
    sinHarmo = snH;
    inc = incre;
    memory  = m;
    amplitude = amp;
    letSizeMax = lSizeMax;
    x = new float[memory];
    y = new float[memory];
    letterSize = new float[memory];
    currentCols = new float[memory];
    letter = new int[memory];
    t = 0.;
    cosHarmo = int(random(2, 16));
    sinHarmo = int(random(2, 16));
    float maxCol = random(50,100);
    int let = int(random(0, numLetters));
    for (int i =0; i<memory; i++) {
      x[i] =width+800;
      y[i] = height+800;
      letterSize[i] = letSizeMax;
      currentCols[i] = maxCol - float(i)/memory*50;
      letter[i] = let;
    }
    functionOnLast(currentFunction);
  }

  void display() {
    for (int i =0; i<memory; i++) {
      fill(currentCols[i], 100, 100, sin(TWO_PI*i/memory)*sin(TWO_PI*i/memory)*60);
      textAlign(CENTER, CENTER);
      textSize(abs(letterSize[i]));
      text(alphabet[letter[i]], x[i], y[i]);
      text(alphabet[letter[i]], -x[i], y[i]);
      text(alphabet[letter[i]], -x[i], -y[i]);
      text(alphabet[letter[i]], x[i], -y[i]);
      //ellipse(x[i], y[i], letterSize[i], letterSize[i]);
    }
  }

  void update() {
    for (int i =0; i<memory-1; i++) {
      x[i] = x[i+1];
      y[i] = y[i+1];
      letterSize[i] = letterSize[i+1];
      letter[i] = letter[i+1];
     
    }
    functionOnLast(currentFunction);
    letterSize[memory-1] = letSizeMax*sin(TWO_PI*cos(TWO_PI*t)*cos(TWO_PI*t));
    t+=inc; 
  }


  void changeCosHarmo(float csh) {
    cosHarmo = 2*csh;
  }
  
    void changeSinHarmo( float snh) {
    sinHarmo = 2*snh;
  }

  void changeInc(float in) {
    float[] incs = {0.0001, 0.0005, 0.001,0.002, 0.003};
    inc = incs[int(in)];
  }

  void changeLetSizeMax(float ls) {
    letSizeMax = 10*ls;
  }

  void changeLetter() {
    letter[memory-1] = int(random(0, numLetters));
  }

  //change the function that determines the value for x and y
  void functionOnLast(int r) {
    if (r == 0) {
      x[memory-1] = amplitude*cos(cosHarmo*PI*t)*cos(cosHarmo*PI*t)-amplitude*sin(2*sinHarmo*PI*t)*sin(2*sinHarmo*PI*t);
      y[memory-1] = amplitude*(sin(sinHarmo*PI*t)*sin(sinHarmo*PI*t)-0.5);
    } else if (r==1){
       x[memory-1] = amplitude*cos(cosHarmo*PI*cos(cosHarmo*PI*t))*cos(cosHarmo*PI*t)-amplitude*sin(0.5*sinHarmo*PI*t)*sin(0.5*sinHarmo*PI*t);
      y[memory-1] = amplitude*(sin(sinHarmo*PI*sin(sinHarmo*PI*t))*sin(sinHarmo*PI*t)-0.5);
    } else if (r == 2) {
      x[memory-1] = amplitude*cos(16*cosHarmo*PI*t)*cos(16*cosHarmo*PI*t)-amplitude*sin(2*sinHarmo*PI*t)*sin(2*sinHarmo*PI*t);
      y[memory-1] = amplitude*(sin(sinHarmo/16*PI*t)*sin(sinHarmo/16*PI*t)-0.5);
    } else if (r == 3) {
      x[memory-1] = amplitude*cos(cosHarmo/16*PI*t)*cos(cosHarmo/16*PI*t)-amplitude*sin(2*sinHarmo*PI*t)*sin(2*sinHarmo*PI*t);
      y[memory-1] = amplitude*(sin(sinHarmo*16*PI*t)*sin(sinHarmo*16*PI*t)-0.5);
    } else if (r == 3) {
      x[memory-1] = 0.5*amplitude*cos(cosHarmo*PI*t);
      y[memory-1] = 0.5*amplitude*(sin(sinHarmo*PI*t));
    }
  }
  
  void changeFunction(float r){
    currentFunction = int(r);
    changeLetter() ;

  }
  
  void changeColors(float maxCol){
    //max col from 70 to 130, 7 values in increments of 10
    
    for (int i =0; i<memory; i++) {
      currentCols[i] = maxCol*10+60 - float(i)/memory*50;
    }
  }
}