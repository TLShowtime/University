public class Hielo implements IConstant{
  float x;
  float y;
  float speed = 0;
  int height_rect;
  float width_rect;
  float colorRGB;
  int hasBounced = 0;
  
  public Hielo(float x,float y,int height_rect,float width_rect,float colorRGB){
    this.x = x;
    this.y = y;
    this.height_rect = height_rect;
    this.width_rect =width_rect;
    this.colorRGB = colorRGB;
    
  }
  
  public void fall(){
    if (colorRGB == 0){
      fill(99,200,248);
    }
    else {
      fill(#FF0000);
    }
    
    //noStroke();
    rect(x,y,height_rect,width_rect);
    y += speed;
    speed += gravity;
      
    if(y >= height && colorRGB !=0){
      speed = speed * -0.3;
      y = height;
      //stroke(#6B6B6B);
      //fill(#6B6B6B);
      
      hasBounced++;
      
    }
    if (hasBounced >=2){
      fallOff();
    }
  }
  
  public void fallOff(){
    //noStroke();
    y *=2;
    rect(x,y*2,height_rect,width_rect);
  }
  
  public float getY(){
    return y;
  }
  
  public int getBounced(){
    return hasBounced;
  }
}
