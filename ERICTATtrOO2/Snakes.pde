class Snakes
{
  private NodeSnake[] snakes;
  public Snakes(ModelMesh mesh, int count)
  {
    snakes = new NodeSnake[count];
    for(int i = 0; i < snakes.length; i++)
    {
      MeshNode tmp = null;
      while(tmp == null)
        tmp = mesh.getRandomNode();
      snakes[i] = new NodeSnake(tmp,5);
    }
  }
  
  public void update(float tm)
  {
    for(int i = 0; i < snakes.length; i++)
    {
      snakes[i].update(tm);
    }
  }
  
  public void draw()
  {
    for(int i = 0; i < snakes.length; i++)
    {
      snakes[i].draw();
    }
  }
}
