public class Cascada extends Viewport implements OnValueChangeListener{
    Minim minim;
    AudioPlayer myAudio;
    FFT myAudioFFT;
  
  
    int myAudioRange = 256;
    int myAudioMax = 100;
    
    float myAudioAmp = 20.0;
    float myAudioIndex = 0.05;
    float myAudioIndexAmp = myAudioIndex;
    float myAudioIndexStep = 0.025;
    
    public static final float MIN = 40.0;
    public static final float MEDIUM = 100;
    
    private float minimum = MIN;
    private float medium = MEDIUM;
    
    
    //--------------------
    
    int rectSize = 5;
    
    int stageMargin = 0;
    int stageWidth = (myAudioRange*rectSize) + (stageMargin*2);
    int stageHeight = 700;
    
    float xStart = stageMargin;
    float yStart = stageMargin;
    
    int xSpacing = rectSize;
    
    //--------------------------
    
    color bgColor = 0;
    
    ArrayList<Hielo> hielos = new ArrayList<Hielo>();
    
    public Cascada (){
      minim = new Minim(this);
      myAudio = minim.loadFile("Prayer~Message2.mp3");
    }
    
    public Cascada (Minim minim,AudioPlayer audio){
      this.minim = minim;
      this.myAudio = audio;
    }
    
    public void play(){  
        myAudio.play();
        
        myAudioFFT = new FFT(myAudio.bufferSize(),myAudio.sampleRate()); //BufferSize = 1024, sampleRate = 44100 hZ
        myAudioFFT.linAverages(myAudioRange); // calculate the averages by grouping frequency bands linearly, use 250 averabge  
        myAudioFFT.window(FFT.GAUSS); // window options from minim, FFT
    }
    
    public void calculateIce(){
        myAudioFFT.forward(myAudio.mix);
  
        for(int i = 0;i<myAudioRange;++i){
          
          stroke(0);
          //noStroke();
          fill(255,5);
          
          float tempIndexAvg = (myAudioFFT.getAvg(i) * myAudioAmp )* myAudioIndexAmp;
          
          if(tempIndexAvg >minimum && tempIndexAvg <= medium){
            Hielo hielo= new Hielo(xStart + (i*xSpacing),yStart,rectSize,rectSize,0);
            hielos.add(hielo);
          }
          
          if(tempIndexAvg >medium){
            //Hielo hielo= new Hielo(xStart + (i*xSpacing),yStart,rectSize,5,tempIndexAvg);
            Hielo hielo= new Hielo(xStart + (i*xSpacing),yStart,rectSize,rectSize,tempIndexAvg);
            
            hielos.add(hielo);
            
          }
          
          myAudioIndexAmp += myAudioIndexStep;
        }
        myAudioIndexAmp = myAudioIndex;
    
    }
    
    public void draw(){
      stroke(0);
        for(int i = 0;i<hielos.size();++i){
          
          hielos.get(i).fall();
          if (hielos.get(i).getY() > height && hielos.get(i).hasBounced >= 3){
            //hielos.get(i).fallOff();
            hielos.remove(i);
          }
        }
    }
    
    public void stop(){
      myAudio.close();
      minim.stop();
      stop();
    }
    
    public void onMinimumChangedTo(float value){
      this.minimum = value;
    }
    
    public void onMediumChangedTo(float value){
      this.medium = value;
    }
  

}
