public class Pez implements IConstant{
  float x;
  float y;
  float speed = 8;
  int radius;
  float swimSpeed= 2;
  boolean top = false;
  PShape s;
  
  public Pez(float x,float y,float radius){
    this.x = x;
    this.y = y;
    s = loadShape("data/pez.svg");
    if (x >= width/2){
      s.rotate(0.8);
      swimSpeed *= -1;
    }
    else{
      s.rotate(2.2);
    }
    
      
  }
  
  public void swim(){
    
    fill(255,152,32);
    
    //fill(#FF0000);
    
    //noStroke();
    //ellipse(x, y, eRadius, eRadius);
    shape(s, x, y, eRadius*5, eRadius*5);
    
    x += swimSpeed;
    
    y -= speed;
    speed -= gravity;
      
      
    //y += speed;
    //speed += gravity;
    
    if(/**y <= height/2*/ speed <= 0){
      speed = speed - gravity ;
      top = true;
        
      //speed = speed * -0.3;
      //y = height;
      //y = height;
      //stroke(#6B6B6B);
      //fill(#6B6B6B);
      
    }
  }
  
  
  public float getY(){
    return y;
  }
  
  public float getX(){
    return x;
  }
  
  public boolean getTop(){
    return top;
  }

}
