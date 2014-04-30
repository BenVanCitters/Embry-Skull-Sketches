class NodeSnake
{
  int maxLength;
  ArrayList<MeshNode> nodes;
  float[] dir;
  float[] dirCooefs;
  
  public NodeSnake(MeshNode start, int maxLen)
  {
    nodes = new ArrayList<MeshNode>();
    nodes.add(start);
    maxLength = maxLen;
    dir = new float[3];
    dirCooefs = new float[]{random(2),
                            random(2),
                            random(2)};
  }
  
  public void update(float tm)
  {
    dir[0] = sin(2+tm*dirCooefs[0]);
    dir[1] = sin(3+tm*dirCooefs[1]);
    dir[2] = cos(1+tm*dirCooefs[2]);
    MeshNode tmp = nodes.get(0).getNeighborFromDir(dir);
    
//    if(!nodes.contains(tmp))
    {
      nodes.add(0,tmp);
      while(nodes.size() > maxLength)
        nodes.remove(nodes.size()-1);    
    }
  }
  public void draw()
  {
    noFill();
    stroke(70,120,255);//127+127*dir[0],127+127*dir[1],127+127*dir[2]);
    strokeWeight(5);
    beginShape();
    for(MeshNode n : nodes)
    {
      //if(n != null)
      {
//        println("node null");
      float[] pos = n.getPos();
      float[] nrm = n.getNormal();
      float amt = -.05;
      pos[0] = pos[0]+(nrm[0]*amt);
      pos[1] = pos[1]+(nrm[1]*amt);
      pos[2] = pos[2]+(nrm[2]*amt);
      vertex(pos[0],pos[1],pos[2]);
      }
    }
    endShape();
  }
}
