public class ControlPanel extends Viewport{

  private OnValueChangeListener listener;
  private Slider minimumSlider;
  private Slider mediumSlider;

  public ControlPanel(OnValueChangeListener listener, float viewX, float viewY, float viewWidth, float viewHeight){
    super(viewX, viewY, viewWidth, viewHeight);
    this.listener = listener;

    float sliderViewX = viewX + viewWidth * 0.1f;
    float sliderViewWidth = viewWidth * 0.8f;
    float sliderViewHeight = viewHeight / 4.0f;
    float sliderViewY = viewY;
    this.minimumSlider = new Slider("Minimum value",music.Cascada.MIN,20,100);
    this.minimumSlider.set(sliderViewX, sliderViewY, sliderViewWidth, sliderViewHeight);
    sliderViewY += sliderViewHeight;
    this.mediumSlider = new Slider("Medium value",music.Cascada.MEDIUM,100,256);
    this.mediumSlider.set(sliderViewX, sliderViewY, sliderViewWidth, sliderViewHeight);
  }

  public void draw(){
    noStroke();
    fill(245);
    rect(this.getX(), this.getY(), this.getWidth(), this.getHeight());
    this.minimumSlider.draw();
    this.mediumSlider.draw();
  }

  public void onMousePressedAt(int x, int y){
    if(this.minimumSlider.isIntersectingWith(x,y)){
      this.minimumSlider.updateValueBy(x);
      float value = this.minimumSlider.getValue();
      this.listener.onMinimumChangedTo(int(value));
    }else if(this.mediumSlider.isIntersectingWith(x,y)){
      this.mediumSlider.updateValueBy(x);
      float value = this.mediumSlider.getValue();
      this.listener.onMediumChangedTo(int(value));
    }
  }
  public void onMouseDraggedTo(int x, int y){
    this.onMousePressedAt(x, y);
  }

}
